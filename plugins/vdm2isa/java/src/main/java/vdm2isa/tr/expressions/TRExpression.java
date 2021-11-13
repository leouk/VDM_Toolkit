/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRLocalDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRNamedType;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRUnknownType;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import com.fujitsu.vdmj.lex.LexLocation;

//@nb how to add this? 
//@todo add comments and/or location? 
public abstract class TRExpression extends TRNode
{
	private static final long serialVersionUID = 1L;

    protected static final Set<IsaToken> VALID_BINARY_OPS = new HashSet<IsaToken>(
        Arrays.asList(IsaToken.AND, IsaToken.OR, IsaToken.IMPLIES, IsaToken.EQUIVALENT, 
                      IsaToken.NE, IsaToken.LT, IsaToken.LE, IsaToken.GT, IsaToken.GE, 
                      IsaToken.PLUS, IsaToken.MINUS, IsaToken.TIMES, IsaToken.DIV, 
                      IsaToken.DIVIDE, IsaToken.MOD, IsaToken.REM, IsaToken.INSET, 
                      IsaToken.NOTINSET, IsaToken.UNION, IsaToken.INTER, IsaToken.SETDIFF, 
                      IsaToken.SUBSET, IsaToken.PSUBSET, IsaToken.CONCATENATE, IsaToken.PLUSPLUS, 
                      IsaToken.DOMRESTO, IsaToken.DOMRESBY, IsaToken.RANGERESTO, IsaToken.RANGERESBY, 
                      IsaToken.MUNION, IsaToken.COMP, IsaToken.EQUALS, IsaToken.STARSTAR, IsaToken.STARSTARNAT));
	
    protected static final Set<IsaToken> VALID_UNARY_OPS = new HashSet<IsaToken>(
        Arrays.asList(IsaToken.NOT, IsaToken.ABS, IsaToken.FLOOR, IsaToken.UMINUS, IsaToken.CARD, 
                      IsaToken.DUNION, IsaToken.DINTER, IsaToken.LEN, IsaToken.HEAD, IsaToken.TAIL, 
                      IsaToken.INDS, IsaToken.ELEMS, IsaToken.DISTCONC, IsaToken.REVERSE, IsaToken.MERGE, 
                      IsaToken.DOM, IsaToken.RNG, IsaToken.INVERSE, IsaToken.FPOWERSET, IsaToken.UPLUS));
	
    protected static final Set<IsaToken> VALID_LITERAL_TOKENS = new HashSet<IsaToken>(
        Arrays.asList(IsaToken.NOT, IsaToken.ABS, IsaToken.FLOOR, IsaToken.UMINUS, IsaToken.CARD, 
                    IsaToken.DUNION, IsaToken.DINTER, IsaToken.LEN, IsaToken.HEAD, IsaToken.TAIL, 
                    IsaToken.INDS, IsaToken.ELEMS, IsaToken.DISTCONC, IsaToken.REVERSE, IsaToken.MERGE, 
                    IsaToken.DOM, IsaToken.RNG, IsaToken.INVERSE, IsaToken.FPOWERSET, IsaToken.UPLUS));

    protected final TRType exptype;
    private boolean hasWarnedAboutUnknownType;

	public TRExpression(LexLocation location, TRType exptype)
	{
		super(location);
        this.exptype = exptype;
        this.hasWarnedAboutUnknownType = false;
	}

	/**
	 * General debug string for all TRExpression classes
	 */
    @Override
    public String toString()
    {
        return super.toString() + ": " + String.valueOf(getType());
    }

    /**
     * Attempt at getting the type for the expression. Important for pattern translation with context, like optional types. 
     * @return
     */
    public TRType getType()
    {
        if (exptype instanceof TRUnknownType && !hasWarnedAboutUnknownType)
        {
            // don't inundate user with warnings; just once per expression. 
            warning(IsaWarningMessage.ISA_UNKNOWN_VDM_TYPE);
            hasWarnedAboutUnknownType = true;
        }
        return exptype;
    }

    /**
     * Keep the static method to allow others (e.g. empty expression lists) to return the same as above.
     * @param location
     * @return
     */
    public static TRType unknownType(LexLocation location)
    {
        return new TRUnknownType(location);
    }

	public abstract <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg);

    //TODO Perhaps add this to translate? Yes! 
    /**
     * Add any extra type-aware wrapping to expression. 
     * @param expr
     * @return
     */
	protected String typeAware(String expr)
	{
        StringBuilder sb = new StringBuilder();
        // add type info extra expression if of optional type (either as variable "x" or function call "f(x)"). 
		if (getType() instanceof TROptionalType)
		{	
			TRType t = getType();
			String comment = IsaWarningMessage.ISA_OPTIONALTYPE_VARIABLE_3P.format(expr, t.getClass().getName());
			warning(IsaWarningMessage.ISA_OPTIONALTYPE_VARIABLE_3P, expr, t.getClass().getName());
			sb.append(IsaToken.comment(comment, getFormattingSeparator()));	
			sb.append(IsaToken.parenthesise(IsaToken.OPTIONAL_THE.toString() + IsaToken.parenthesise(expr)));
		}
		else
		{
			//if vardef is null, ctor reports the error; 
			sb.append(expr);
		}
		return sb.toString();	
	}
    
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
            case FPOWERSET:
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
            case INSET:
            case NOTINSET:
            case SUBSET:
            case PSUBSET:
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

			case UNION:
            case INTER:
            case SETDIFF:

			case CONCATENATE:

            case MUNION:
            case PLUSPLUS:
            case COMP:
			case DOMRESTO:  
            case DOMRESBY:
            case RANGERESTO:
            case RANGERESBY:
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

            //TODO equals *must* be reimplemented for record types because of record equality abstraction! 
            //     Might even need a separate class from TRBinaryExpression! 
            case NE:
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
            default:
                report(IsaErrorMessage.PLUGIN_NYI_2P, "token " + token.toString(), TRExpressionList.translate(args));
        }
        return sb.toString();
    }

    private TRType getUltimateType(TRType t)
    {
        TRType result = t;
        if (t instanceof TRNamedType)
            result = ((TRNamedType)t).ultimateType();
        return result;
    }

    protected TRType/* Might not be record type? */ getRecordType()
    {
        TRType result = getType(); 
        // e.g. R :: x : nat, r.x ; 
        if (this instanceof TRVariableExpression)
        {
            TRVariableExpression vexpr = (TRVariableExpression)this;
            if (vexpr.getVarDef() instanceof TRLocalDefinition)
            {
                TRLocalDefinition ldef = (TRLocalDefinition)vexpr.getVarDef();
                result = getUltimateType(ldef.getType());
            }
        }
        // e.g. mk_R(v).x 
        else if (this instanceof TRMkTypeExpression)
        {
            TRMkTypeExpression mexpr = (TRMkTypeExpression)this;
            result = getUltimateType(mexpr.getType());
        }
        // e.g. mkr(v).x, for mkr: nat -> R mkr(n) == mk_R(n); 
        else if (this instanceof TRApplyExpression)
        {
            TRApplyExpression aexpr = (TRApplyExpression)this;
            if (aexpr.type instanceof TRFunctionType)
            {
                TRFunctionType ftype = (TRFunctionType)aexpr.type;
                result = getUltimateType(ftype.result);
            }
        }
        //TODO missing various cases, like iota, mu, if, etc.!!!!
        if (!(result instanceof TRRecordType))
        {
            report(IsaErrorMessage.ISA_FIELDEXPR_RECORDNAME_2P, getClass().getName(), result.getClass().getName());            
        }
        return result;
        // if (this instanceof TRVariableExpression && 
        //     ((TRVariableExpression)this).getVarDef() instanceof TRLocalDefinition &&
        //     (((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType() instanceof TRRecordType ||
        //      (((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType() instanceof TRNamedType && 
        //         (TRNamedType)(((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType()).ultimateType() instanceof TRecordType 
        //      )
        //     )
        //    ) 
        //     return ((TRRecordType)((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType());
        // e.g. mk_R(v).x  (bit wacky, but)
        //else if (this instanceof TRMkTypeExpression && ((TRMkTypeExpression)this).getType() instanceof TRRecordType)
        //    return (TRRecordType)((TRMkTypeExpression)this).getType();   
        // e.g. mkr(v).x, for mkr: nat -> R mkr(n) == mk_R(n); 
        // else if (this instanceof TRApplyExpression && 
        //             ((TRApplyExpression)this).type instanceof TRFunctionType &&
        //             ((TRFunctionType)((TRApplyExpression)this).type).result instanceof TRRecordType)
        //     return ((TRRecordType)((TRFunctionType)((TRApplyExpression)this).type).result);
        //TODO missing various cases, like iota, mu, if, etc.!!!!
        // else
        // {
        //     // do not change Isabelle record name. issue warning
        //     String problem = "Could not retrieve record name in field expression for " + 
        //         getClass().getName() + "[" + 
        //         // add inner information about casts above; horrible! but will be deleted once above completes?
        //         (this instanceof TRVariableExpression ? ((TRVariableExpression)this).getVarDef().getClass().getName() + ", " : "")  +
                
        //         (this instanceof TRVariableExpression && ((TRVariableExpression)this).getVarDef() instanceof TRLocalDefinition &&
        //         !(((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType() instanceof TRRecordType) ? 
        //         ((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType().getClass().getName() + ", " : "") + 
                
        //         ((this instanceof TRMkTypeExpression && !(((TRMkTypeExpression)this).getType() instanceof TRRecordType)) ?
        //         ((TRMkTypeExpression)this).getType().getClass().getName() + ", " : "") +

        //         ((this instanceof TRApplyExpression) && !(((TRApplyExpression)this).type instanceof TRFunctionType) &&
        //         !(((TRFunctionType)((TRApplyExpression)this).type).result instanceof TRRecordType) ? 
        //         ((TRFunctionType)((TRApplyExpression)this).type).result.getClass().getName() : "") +

        //         "]" + translate();
        //     warning(11111, problem);
        //     // Don't add this as it's within the context of \<^sub>!
        //     //sb.append("\n\t");
        //     //sb.append(IsaToken.comment(problem));
        //     return getType();
        // }        
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
        //TODO refactor getRecordType to be called from here? Problem for TRMkTypeExpression? 
        boolean okay = false;
        StringBuilder sb = new StringBuilder();
        // e.g. R :: x : nat, r.x ; 
        if (this instanceof TRVariableExpression)
        {
            TRVariableExpression vexpr = (TRVariableExpression)this;
            if (vexpr.getVarDef() instanceof TRLocalDefinition)
            {
                TRLocalDefinition ldef = (TRLocalDefinition)vexpr.getVarDef();
                sb.append(getUltimateType(ldef.getType()).translate());
                okay = true;
            }
        }
        // e.g. mk_R(v).x 
        else if (this instanceof TRMkTypeExpression)
        {
            TRMkTypeExpression mexpr = (TRMkTypeExpression)this;
            sb.append(mexpr.typename);//getUltimateType(mexpr.getType()).getName());?
            okay = true;
        }
        // e.g. mkr(v).x, for mkr: nat -> R mkr(n) == mk_R(n); 
        else if (this instanceof TRApplyExpression)
        {
            TRApplyExpression aexpr = (TRApplyExpression)this;
            if (aexpr.type instanceof TRFunctionType)
            {
                TRFunctionType ftype = (TRFunctionType)aexpr.type;
                sb.append(getUltimateType(ftype.result).getName());
                okay = true;
            }
        }
        //TODO missing various cases, like iota, mu, if, etc.!!!!
        if (!okay)
        {
            report(IsaErrorMessage.ISA_FIELDEXPR_RECORDNAME_2P, getClass().getName(), "???");            
        }
        return sb.toString();
        // StringBuilder sb = new StringBuilder();
        // // e.g. R :: x : nat, r.x ; could variable have other inner? 
        // if (this instanceof TRVariableExpression && 
        //     ((TRVariableExpression)this).getVarDef() instanceof TRLocalDefinition &&
        //     ((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType() instanceof TRRecordType) 
        //     sb.append(((TRRecordType)((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType()).translate());
        // // e.g. mk_R(v).x  (bit wacky, but)
        // else if (this instanceof TRMkTypeExpression)
        //     sb.append(((TRMkTypeExpression)this).typename);   
        // // e.g. mkr(v).x, for mkr: nat -> R mkr(n) == mk_R(n); 
        // else if (this instanceof TRApplyExpression && ((TRApplyExpression)this).type instanceof TRFunctionType &&
        //     ((TRFunctionType)((TRApplyExpression)this).type).result instanceof TRRecordType)
        //     sb.append(((TRRecordType)((TRFunctionType)((TRApplyExpression)this).type).result).getName());
        // else
        // {
        //     // do not change Isabelle record name. issue warning
        //     String problem = "Could not retrieve field expression record name for " + 
        //         getClass().getName() + "[" + 
        //         // add inner information about casts above; horrible! but will be deleted once above completes?
        //         (this instanceof TRVariableExpression ? ((TRVariableExpression)this).getVarDef().getClass().getName() + ", " : "")  +
        //         (this instanceof TRVariableExpression && ((TRVariableExpression)this).getVarDef() instanceof TRLocalDefinition &&
        //          !(((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType() instanceof TRRecordType) ? 
        //          ((TRLocalDefinition)((TRVariableExpression)this).getVarDef()).getType().getClass().getName() + ", " : "") + 
        //         ((this instanceof TRApplyExpression) && !(((TRApplyExpression)this).type instanceof TRFunctionType) &&
        //           !(((TRFunctionType)((TRApplyExpression)this).type).result instanceof TRRecordType) ? 
        //           ((TRFunctionType)((TRApplyExpression)this).type).result.getClass().getName() : "") +
        //         "]" + 
        //         translate();
        //     warning(11111, problem);
        //     // Don't add this as it's within the context of \<^sub>!
        //     //sb.append("\n\t");
        //     //sb.append(IsaToken.comment(problem));
        // }
        // return sb.toString(); 
    }

    /**
     * Whether or not implicit type invariant checks are needed for this class. 
     * @return
     */
    public boolean requiresImplicitTypeInvariantChecks() {
        return false;
    }
}
