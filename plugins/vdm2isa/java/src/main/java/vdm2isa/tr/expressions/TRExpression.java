/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.patterns.TRPatternContext;
import vdm2isa.tr.types.TRAbstractInnerTypedType;
import vdm2isa.tr.types.TRNamedType;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRSetType;
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

    public static final Set<IsaToken> VALID_BOOLEAN_CHAIN_OPS = new HashSet<IsaToken>(
        Arrays.asList(IsaToken.AND, IsaToken.OR, IsaToken.IMPLIES, IsaToken.EQUIVALENT)); 

    public static final Set<IsaToken> VALID_BINARY_OPS = new HashSet<IsaToken>(
        Arrays.asList(IsaToken.AND, IsaToken.OR, IsaToken.IMPLIES, IsaToken.EQUIVALENT, 
                      IsaToken.NE, IsaToken.LT, IsaToken.LE, IsaToken.GT, IsaToken.GE, 
                      IsaToken.PLUS, IsaToken.MINUS, IsaToken.TIMES, IsaToken.DIV, 
                      IsaToken.DIVIDE, IsaToken.MOD, IsaToken.REM, IsaToken.INSET, 
                      IsaToken.NOTINSET, IsaToken.UNION, IsaToken.INTER, IsaToken.SETDIFF, 
                      IsaToken.SUBSET, IsaToken.PSUBSET, IsaToken.CONCATENATE, IsaToken.PLUSPLUS, 
                      IsaToken.DOMRESTO, IsaToken.DOMRESBY, IsaToken.RANGERESTO, IsaToken.RANGERESBY, 
                      IsaToken.MUNION, IsaToken.COMP, IsaToken.EQUALS, IsaToken.STARSTAR, IsaToken.STARSTARNAT));
	
    public static final Set<IsaToken> VALID_UNARY_OPS = new HashSet<IsaToken>(
        Arrays.asList(IsaToken.NOT, IsaToken.ABS, IsaToken.FLOOR, IsaToken.UMINUS, IsaToken.CARD, 
                      IsaToken.DUNION, IsaToken.DINTER, IsaToken.LEN, IsaToken.HEAD, IsaToken.TAIL, 
                      IsaToken.INDS, IsaToken.ELEMS, IsaToken.DISTCONC, IsaToken.REVERSE, IsaToken.MERGE, 
                      IsaToken.DOM, IsaToken.RNG, IsaToken.INVERSE, IsaToken.FPOWERSET, IsaToken.UPLUS));
	
    public static final Set<IsaToken> VALID_LITERAL_TOKENS = new HashSet<IsaToken>(
        Arrays.asList(IsaToken.NOT, IsaToken.ABS, IsaToken.FLOOR, IsaToken.UMINUS, IsaToken.CARD, 
                    IsaToken.DUNION, IsaToken.DINTER, IsaToken.LEN, IsaToken.HEAD, IsaToken.TAIL, 
                    IsaToken.INDS, IsaToken.ELEMS, IsaToken.DISTCONC, IsaToken.REVERSE, IsaToken.MERGE, 
                    IsaToken.DOM, IsaToken.RNG, IsaToken.INVERSE, IsaToken.FPOWERSET, IsaToken.UPLUS));

    protected TRType exptype;
    private boolean hasWarnedAboutUnknownType;
    private boolean hasWarnedAboutNullType;

	public TRExpression(LexLocation location, TRType exptype)
	{
		super(location);
        this.exptype = exptype;
        this.hasWarnedAboutUnknownType = false;
        this.hasWarnedAboutNullType = false;
	}

    @Override 
    public void setup()
    {
        super.setup();
        if (exptype == null && !hasWarnedAboutNullType)
        {
            warning(IsaWarningMessage.VDMSL_INVALID_EXPR_TYPE_2P, getClass().getSimpleName(), "null");
            exptype = TRExpression.unknownType(location);
            hasWarnedAboutNullType = true;
        }
        TRNode.setup(exptype);
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
    public final TRType getType()
    {
        TRType result = exptype;
        if (result == null)
        {
            result = getBestGuessType();
            if (!hasWarnedAboutNullType)
            {
                warning(IsaWarningMessage.VDMSL_INVALID_EXPR_TYPE_2P, getClass().getSimpleName(), "null");
                hasWarnedAboutNullType = true;
            }
        }
        if (result == null)
        {
            result = TRExpression.unknownType(location);
        }
        if (result instanceof TRUnknownType && !hasWarnedAboutUnknownType)
        {
            // don't inundate user with warnings; just once per expression. 
            warning(IsaWarningMessage.ISA_UNKNOWN_VDM_TYPE);
            hasWarnedAboutUnknownType = true;
        }
        return result;
    }

    protected TRType getBestGuessType()
    {
        return TRExpression.unknownType(location);
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
			String comment = IsaWarningMessage.ISA_OPTIONALTYPE_VARIABLE_3P.format(expr, t.getClass().getSimpleName());
			warning(IsaWarningMessage.ISA_OPTIONALTYPE_VARIABLE_3P, expr, t.getClass().getSimpleName());
			sb.append(getFormattingSeparator() + IsaToken.comment(comment, getFormattingSeparator()));	
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
     * Given record pattern in expressions with record context (e.g. multiple binding, patterns etc), 
     * surround this expression translation with the record pattern let-def context projecting out the binding's 
     * fields so that the user-defined expression can directly access the bindings as named by the user. 
     * 
     * Every expression with such context ought to take this into account when translating itself. Nevertheless,
     * there are still cases where the pattern/binding is "null" when names are available elsewhere. For example
     * TREqualsDefinition has either a typebind or a pattern for its context, both of which reach this through
     * TRValueDefinition translate it inherits. So, for that, we allow for null context, in which case we just 
     * directly translate
     * @param context if null, normally translate; otherwise take recordpatterns into account. 
     * @return record-context (or normal) translation 
     */
    public String recordPatternTranslate(TRPatternContext context)
    {
        StringBuilder sb = new StringBuilder();
        boolean hasRecPattern = context != null && context.needsPatternContext();
        if (hasRecPattern)
        {
            sb.append(IsaToken.LPAREN.toString());
            sb.append(context.patternContextTranslate(null));
        }
        // could have a "context.hasRecordPatterns() ? IsaToken.parenthesise(context.recordPatternTranslate() + expr.translate()) : expr.translate()"
        // but kept it explicitly for clarity. 
        sb.append(translate());
        if (hasRecPattern)
        {
            sb.append(IsaToken.RPAREN.toString());
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
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), token.toString(), args.length, TRExpressionList.translate(args));
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
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), token.toString(), args.length, TRExpressionList.translate(args));
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
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), token.toString(), args.length, TRExpressionList.translate(args));
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
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), token.toString(), args.length, TRExpressionList.translate(args));
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
                    sb.append(IsaToken.comment(IsaWarningMessage.ISA_POWEROP_TYPEDEP.message, getFormattingSeparator()));
                    warning(IsaWarningMessage.ISA_POWEROP_TYPEDEP);
                }
                break;

            //TODO equals *must* be reimplemented for record types because of record equality abstraction! 
            //     Might even need a separate class from TRBinaryExpression! 
            case NE:
            case EQUALS:
                if (args.length != 2)
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), token.toString(), args.length, TRExpressionList.translate(args));
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

    public final TRType getUltimateType(TRType t)
    {
        TRType result = t;
        if (t instanceof TRNamedType)
            result = ((TRNamedType)t).ultimateType();
        return result;
    }

    public final TRType getRecordType()
    {
        TRType result = doGetRecordType();
        if (!(result instanceof TRRecordType))
        {
            report(IsaErrorMessage.ISA_FIELDEXPR_RECORDNAME_2P, getClass().getSimpleName(), result.getClass().getSimpleName());            
        }
        return result;
    }
    /**
     * For expressions in general, chase ultimate type considering type inner structure results
     * @return
     */
    protected TRType/* Might not be record type? */ doGetRecordType()
    {
        // get the ultimate type (i.e. chase all [re-]named types)
        TRType result = getUltimateType(getType());

        // TRFunctionType: if a function, chase its result type 
        // TRMapType     : if a map, chase range type
        // TROptionalType: if optional, chase inner type
        // TRBracketType : if bracketed, chase inner type
        // TRSetType     : if set, ignore
        // TRSeqType     : if seq, ignore
        if (result instanceof TRAbstractInnerTypedType)
        {
            TRAbstractInnerTypedType t = (TRAbstractInnerTypedType)result;
            
            if (!(result instanceof TRSetType || result instanceof TRSeqType))
                result = getUltimateType(t.getInnerType());            
        }  
        return result;      
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
    public final String getRecordTypeName()
    {
        //TODO refactor getRecordType to be called from here? Problem for TRMkTypeExpression? 
//        TRType rtype = getRecordType();
        throw new UnsupportedOperationException();//return rtype.getName();
        // // e.g. R :: x : nat, r.x ; 
        // if (this instanceof TRVariableExpression)
        // {
        //     TRVariableExpression vexpr = (TRVariableExpression)this;
        //     if (vexpr.getVarDef() instanceof TRLocalDefinition)
        //     {
        //         TRLocalDefinition ldef = (TRLocalDefinition)vexpr.getVarDef();
        //         TRType rtype = getUltimateType(ldef.getType());
        //         sb.append(rtype.translate());
        //         okay = true;
        //     }
        // }
        // // e.g. mk_R(v).x 
        // else if (this instanceof TRMkTypeExpression)
        // {
        //     TRMkTypeExpression mexpr = (TRMkTypeExpression)this;
        //     sb.append(mexpr.typename);//getUltimateType(mexpr.getType()).getName());?
        //     okay = true;
        // }
        // // e.g. mkr(v).x, for mkr: nat -> R mkr(n) == mk_R(n); 
        // else if (this instanceof TRApplyExpression)
        // {
        //     TRApplyExpression aexpr = (TRApplyExpression)this;
        //     if (aexpr.type instanceof TRFunctionType)
        //     {
        //         TRFunctionType ftype = (TRFunctionType)aexpr.type;
        //         sb.append(getUltimateType(ftype.result).getName());
        //         okay = true;
        //     }
        //     else 
        //     {
        //         TRType aexprtype = getUltimateType(aexpr.type);
        //         if (aexprtype instanceof TRRecordType)
        //         {
        //             TRRecordType rtype = (TRRecordType)aexprtype;
        //             sb.append(rtype.getName());
        //             okay = true;
        //         }
        //     }
        // }
        // e.g. r.x, 
        // else if (this instanceof TRFieldExpression)
        // {
        //     TRFieldExpression fexpr = (TRFieldExpression)this;
        //     sb.append(fexpr.recordExpression().getRecordTypeName());
        //     okay = true;
        // }
        // //TODO missing various cases, like iota, mu, if, etc.!!!!
        // if (!okay)
        // {
        //     report(IsaErrorMessage.ISA_FIELDEXPR_RECORDNAME_2P, getClass().getSimpleName(), "???");            
        // }
    }

    /**
     * Whether or not implicit type invariant checks are needed for this class. 
     * @return
     */
    public boolean requiresImplicitTypeInvariantChecks() {
        return false;
        //TODO who else might need to change this beyond TRBoundedExpression? 
    }

    /**
     * For TCExpressionPattern, we need to know the expression patterns of interest. 
     * This might also be useful elsewhere. Any expression with patterns ought to add it here! 
     * @return
     */
    public TRPatternListList getPatternListList() {
        return TRPatternListList.newPatternListList((TRPattern[])null);
    }
}
