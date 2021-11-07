/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRLocalDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRRecordType;

import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.lex.LexLocation;

//@nb how to add this? 
//@todo add comments and/or location? 
public abstract class TRExpression extends TRNode
{
	private static final long serialVersionUID = 1L;
	
	public LexCommentList comments;

	public TRExpression(LexLocation location)
	{
		super(location);
	}

	public TRExpression(TRExpression exp)
	{
		this(exp.location);
	}

	public abstract <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg);

    /**
     * General tokenisation of operator-based expressions. The underlying caller's semantic separator is used
     * @param token
     * @param location
     * @param args
     * @return
     */
	protected String tokenise(IsaToken token, LexLocation location, TRExpression... args)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(tldIsaComment());
        switch (token)
        {
            case NOT:
            case ABS: 
            case FLOOR:
            case UMINUS:
            case CARD:
            case DUNION:
            case DINTER:
            case LEN:
            case HEAD:
            case TAIL:
            case INDS:
            case ELEMS:
            case DISTCONC:
            case REVERSE:
            case MERGE:
            case DOM:
            case RNG:
            case INVERSE:
            case POWER:
                if (args.length != 1)
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), token.toString(), args.length, TRExpressionList.translate(args));
                else
                {
                    sb.append(IsaToken.LPAREN.toString());
                    sb.append(token.toString());
                    sb.append(getSemanticSeparator());
                    sb.append(args[0].translate());
                    sb.append(IsaToken.RPAREN.toString());
                }
                break;
            case UPLUS: // +x is just x
                if (args.length != 1)
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), token.toString(), args.length, TRExpressionList.translate(args));
                else
                    sb.append(args[0].translate());
                break;
            
            // Binary Operators
            case AND:
            case OR:
            case IMPLIES:
            case EQUIVALENT:
            case NE:
            case LT:
            case LE:
            case GT:
            case GE:
            case PLUS:
            case MINUS:
            case TIMES:
            case DIV:
            case DIVIDE:
            case MOD:
            case REM:
            case INSET:
            case NOTINSET:
            case UNION:
            case INTER:
            case SETDIFF:
            case SUBSET:
            case PSUBSET:
            case CONCATENATE:
            case PLUSPLUS:
            case DOMRESTO:
            case DOMRESBY:
            case RANGERESTO:
            case RANGERESBY:
            case MUNION:
            case COMP:
            //TODO equals *must* be reimplemented for record types because of record equality abstraction! 
            //     Might even need a separate class from TRBinaryExpression! 
            case EQUALS:
                if (args.length != 2)
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), token.toString(), args.length, TRExpressionList.translate(args));
                else
                {
                    sb.append(IsaToken.LPAREN.toString());
                    sb.append(args[0].translate());
                    sb.append(getSemanticSeparator());
                    sb.append(token.toString());
                    sb.append(getSemanticSeparator());
                    sb.append(args[1].translate());
                    sb.append(IsaToken.RPAREN.toString());
                }
                break;
            case STARSTAR:
            case STARSTARNAT:
                if (args.length != 2)
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), token.toString(), args.length, TRExpressionList.translate(args));
                else
                {
                    sb.append(IsaToken.LPAREN.toString());
                    sb.append(args[0].translate());
                    sb.append(getSemanticSeparator());
                    sb.append(token.toString());
                    sb.append(getSemanticSeparator());
                    sb.append(args[1].translate());
                    sb.append(IsaToken.RPAREN.toString());
                    sb.append(getFormattingSeparator());
                    //sb.append("\n\t");
                    String comment = "result of the power operator is context dependenant on second argument type being nat or real.";
                    sb.append(IsaToken.comment(comment));
                    warning(11001, comment);
                }
                break;
            
            default:
                report(IsaErrorMessage.PLUGIN_NYI_2P, "token " + token.toString(), TRExpressionList.translate(args));
        }
        return sb.toString();
    }

    /**
     * Returns the record name of the type associated with the expression, if that's the case.
     * This is important so that Isabelle record related translations take into account field name
     * changes according to the underlying record type involved (e.g. "R :: x: nat" becomes "record R = x\^<sub>R :: VDMNat").
     * 
     * Given TLD types must be uniquely named, then the record type name plus the field name should be
     * sufficient to resolve the global name conflict associated with implicitly declared global record field projections
     * functions Isabelle creates (e.g. x :: R => VDMNat) for every record field. 
     * 
     * Thus, this TRExpression is viewed as a record name of its underlying associated type.
     * Common cases are TRVariableExpression (e.g. r.x) or TRMkTypeExpression (e.g. mk_R(1).x). 
     * Also possible is TRApplyExpression (e.g. g(10).x, for some g: nat -> R), etc.
     * 
     * There might be more cases than those catered for here, hence this became a method of TRExpression
     * rather than TRFieldExpression say for its object TRExpression field. As we discover more cases those
     * can be added below.   
     * 
     * If the case is not handled, a warning is raised and an Isabelle comment is included with the offending case.
     * Ultimately, this means no field renaming will take place, so translation outcome can still be type error free,
     * so long as the record field name is not used anywhere else (globally or locally!) though.  
     * 
     * @return record name of the underlying type associated with this expression, if possible, or empty string otherwise.
     */
    public String getRecordTypeName()
    {
        StringBuilder sb = new StringBuilder();
        // e.g. R :: x : nat, r.x ; could variable have other inner? 
        if (this instanceof TRVariableExpression && 
            ((TRVariableExpression)this).getVarDef() instanceof TRLocalDefinition &&
            ((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType() instanceof TRRecordType) 
            sb.append(((TRRecordType)((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType()).translate());
        // e.g. mk_R(v).x  (bit wacky, but)
        else if (this instanceof TRMkTypeExpression)
            sb.append(((TRMkTypeExpression)this).typename);   
        // e.g. mkr(v).x, for mkr: nat -> R mkr(n) == mk_R(n); 
        else if (this instanceof TRApplyExpression && ((TRApplyExpression)this).type instanceof TRFunctionType &&
            ((TRFunctionType)((TRApplyExpression)this).type).result instanceof TRRecordType)
            sb.append(((TRRecordType)((TRFunctionType)((TRApplyExpression)this).type).result).getName().toString());
        else
        {
            // do not change Isabelle record name. issue warning
            String problem = "Could not retrieve field expression record name for " + 
                getClass().getName() + "[" + 
                // add inner information about casts above; horrible! but will be deleted once above completes?
                (this instanceof TRVariableExpression ? ((TRVariableExpression)this).getVarDef().getClass().getName() + ", " : "")  +
                (this instanceof TRVariableExpression && ((TRVariableExpression)this).getVarDef() instanceof TRLocalDefinition &&
                 !(((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType() instanceof TRRecordType) ? 
                 ((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType().getClass().getName() + ", " : "") + 
                ((this instanceof TRApplyExpression) && !(((TRApplyExpression)this).type instanceof TRFunctionType) &&
                  !(((TRFunctionType)((TRApplyExpression)this).type).result instanceof TRRecordType) ? 
                  ((TRFunctionType)((TRApplyExpression)this).type).result.getClass().getName() : "") +
                "]" + 
                translate();
            warning(11111, problem);
            // Don't add this as it's within the context of \<^sub>!
            //sb.append("\n\t");
            //sb.append(IsaToken.comment(problem));
        }
        return sb.toString(); 
    }

    /**
     * Whether or not implicit type invariant checks are needed for this class. 
     * @return
     */
    public boolean requiresImplicitTypeInvariantChecks() {
        return false;
    }
}
