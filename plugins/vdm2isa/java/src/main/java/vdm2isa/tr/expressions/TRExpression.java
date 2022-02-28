/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.expressions.visitors.TCGetFreeVariablesVisitorSet;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.patterns.TRPatternContext;
import vdm2isa.tr.types.TRAbstractInnerTypedType;
import vdm2isa.tr.types.TRInvariantType;
import vdm2isa.tr.types.TRMapType;
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
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.visitors.TCFreeVariableExpressionVisitor;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

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
    private final TCExpression exp;
    private boolean hasWarnedAboutUnknownType;
    private boolean hasWarnedAboutNullType;

    // setup a free variables visitor
    private final TCFreeVariableExpressionVisitor exprFVV;
    private final Environment fvvENV;//EnvTriple fvvENV; 
    
	public TRExpression(LexLocation location, TCExpression exp, TRType exptype)
	{
		super(location);
        this.exp = exp;
        this.exptype = exptype;
        this.hasWarnedAboutUnknownType = false;
        this.hasWarnedAboutNullType = false;
        this.exprFVV = new TCFreeVariableExpressionVisitor(new TCGetFreeVariablesVisitorSet());
        //this.fvvENV = new EnvTriple(new FlatEnvironment(new TCDefinitionList()), new FlatEnvironment(new TCDefinitionList()), new AtomicBoolean(false)); 
        this.fvvENV = new FlatEnvironment(new TCDefinitionList());
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

    public final TCExpression getVDMExpr()
    {
        return exp;
    }

    public TCNameSet findFV()
    {
        return this.getVDMExpr().apply(this.exprFVV, this.fvvENV);
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
    public static final TRType unknownType(LexLocation location)
    {
        return TRUnknownType.newUnkownType(location);
    }

	public abstract <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg);

    private static final boolean isMapType(TRType type)
    {
        assert type != null;
        // either a map on the top-level, or a renamed type
        return type instanceof TRMapType || type.ultimateType() instanceof TRMapType;
    }

    private static final boolean isOptionalType(TRType type)
    {
        assert type != null;
        // either a map on the top-level, or a renamed type
        return type instanceof TROptionalType || type.ultimateType() instanceof TROptionalType;
    }

    public static final boolean requiresTheOperator(TRType targetType)
    {
        assert targetType != null;
        return !isMapType(targetType) && !isOptionalType(targetType);
    }

    public static final boolean requiresTheOperator(TRExpression expr)
    {
        assert expr != null;
        return (isMapType(expr.getType()))
               ||
               (expr instanceof TRApplyExpression
                &&
                isMapType(((TRApplyExpression)expr).type)
               );
    }

    /**
     * Depending on the target type an expression is associated with, there is a need to type convert it.
     * For example, map application or optional types require the "the" operator wrapping. 
     * @param innerExpr when null, translate directly from this expression. Important for some cases like variable expression of value definition
     * @param targetType the type target this expression is landing on. Important to know whether the wraping is needed. 
     * @return type converted translation
     */
	public String typeConvertTranslate(TRExpression innerExpr, TRType targetType)
	{
        StringBuilder sb = new StringBuilder();
        
        TRExpression tawareExpr = innerExpr != null ? innerExpr : this;
        assert tawareExpr != null && targetType != null;

        String exprStr = tawareExpr.translate();
        // the expression being translated requires "the" when it is landing on a type that also requires it (i.e. not a map or optional)
        if (TRExpression.requiresTheOperator(tawareExpr) && TRExpression.requiresTheOperator(targetType))
        {
            sb.append(IsaToken.the(exprStr));
        }
        // add type info extra expression if of optional type (either as variable "x" or function call "f(x)"). 
		// else if (getType() instanceof TROptionalType)
		// {	
        //     //TODO this sounds like unnecessary.
		// 	TRType t = getType();
		// 	String comment = IsaWarningMessage.ISA_OPTIONALTYPE_VARIABLE_3P.format(exprStr, t.getClass().getSimpleName());
		// 	warning(IsaWarningMessage.ISA_OPTIONALTYPE_VARIABLE_3P, tawareExpr, t.getClass().getSimpleName());
		// 	sb.append(getFormattingSeparator() + IsaToken.comment(comment, getFormattingSeparator()));	
		// 	sb.append(IsaToken.the(exprStr));
		// }
		else
		{
			//if vardef is null, ctor reports the error; 
			sb.append(exprStr);
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
    public String patternContextTranslate(TRPatternContext context)
    {
        StringBuilder sb = new StringBuilder();
        boolean hasPatternContext = context != null && context.needsPatternContext();
        if (hasPatternContext)
        {
            sb.append(IsaToken.LPAREN.toString());
            sb.append(context.patternContextTranslate(null));
        }
        // could have a "context.needsPatternContext() ? IsaToken.parenthesise(context.patternContextTranslate(null) + expr.translate()) : expr.translate()"
        // but kept it explicitly for clarity. 
        sb.append(translate());
        if (hasPatternContext)
        {
            sb.append(IsaToken.RPAREN.toString());
        }
        return sb.toString();
    }

    public String extendedCheckTranslate(String ifCheck)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.LPAREN.toString());
        sb.append(IsaToken.IF.toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(ifCheck);
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.THEN.toString());
        sb.append(getFormattingSeparator() + "\t");
        sb.append(translate());        
        sb.append(getFormattingSeparator() + IsaToken.SPACE.toString());
        sb.append(IsaToken.ELSE.toString());
        sb.append(getFormattingSeparator() + "\t");
        sb.append(IsaToken.UNDEFINED.toString());
        sb.append(getFormattingSeparator()); 
        sb.append(IsaToken.RPAREN.toString());
        sb.append(getFormattingSeparator());
        return sb.toString();
    }

    private String processBinaryOrdExpression(TRExpression left, IsaToken op, TRExpression right, boolean lt)
    {
        TRExplicitFunctionDefinition orddef = 
            TRInvariantType.getOrdDef(
                left.getType().ultimateInvariantType(), 
                right.getType().ultimateInvariantType());
        if (orddef != null)
        {
            assert orddef.getParameters().getFlatPatternList().size() == 2;
            TRApplyExpression aexpr = TRExplicitFunctionDefinition.newExplicitFunctionDefinitionCall(
                orddef, 
                // orddef is always "<"; if ">", then flip arguments
                lt ? TRExpressionList.newExpressionList(left, right) :
                TRExpressionList.newExpressionList(right, left));
            StringBuilder sb = new StringBuilder();
            String typeName = orddef.getType().parameters.get(0).getName();
            sb.append(IsaToken.comment(
                        lt ? IsaInfoMessage.VDM_EXPLICIT_ORDER_PRED_1P.format(typeName) :
                            IsaInfoMessage.VDM_EXPLICIT_REVERSED_ORDER_PRED_1P.format(typeName), "\n\t"));         
            sb.append(aexpr.translate());
            return sb.toString();
        }
        else
        {
            return processBinaryExpression(left, op, right);
        }
    }

    private String processBinaryEqExpression(TRExpression left, IsaToken op, TRExpression right, boolean eq)
    {
        TRExplicitFunctionDefinition eqdef = 
            TRInvariantType.getEqDef(
                left.getType().ultimateInvariantType(), 
                right.getType().ultimateInvariantType());
        if (eqdef != null)
        {
            assert eqdef.getParameters().getFlatPatternList().size() == 2;
            TRApplyExpression aexpr = TRExplicitFunctionDefinition.newExplicitFunctionDefinitionCall(eqdef, TRExpressionList.newExpressionList(left, right));

            StringBuilder sb = new StringBuilder();
            String typeName = eqdef.getType().parameters.get(0).getName();
            sb.append(IsaToken.comment(
                        eq ? IsaInfoMessage.VDM_EXPLICIT_EQ_PRED_1P.format(typeName) :
                             IsaInfoMessage.VDM_EXPLICIT_NOT_EQ_PRED_1P.format(typeName), "\n\t"));         
            sb.append(eq ? aexpr.translate() : 
                           TRUnaryExpression.newUnaryExpression(IsaToken.NOT, aexpr).translate());
            return sb.toString();
        }
        else
        {
            return processBinaryExpression(left, op, right);
        }
    }

    private String processBinaryOrdEqExpression(TRExpression left, IsaToken op, TRExpression right, boolean lt)
    {
        if (left.getType().hasOrderingSpecification() ||
        right.getType().hasOrderingSpecification())
        {
            StringBuilder sb = new StringBuilder();
            sb.append(processBinaryOrdExpression(left, op, right, lt));
            sb.append(IsaToken.SPACE.toString());
            sb.append(IsaToken.OR.toString());
            sb.append(IsaToken.SPACE.toString());
            sb.append("\n\t");
            sb.append(processBinaryEqExpression(left, op, right, true));
            return sb.toString();
        }
        else
        {
            return processBinaryExpression(left, op, right);
        }
    }

    private String processBinaryExpression(TRExpression left, IsaToken op, TRExpression right)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.LPAREN.toString());
        sb.append(left.translate());
        sb.append(getSemanticSeparator());
        sb.append(op.toString());
        sb.append(getSemanticSeparator());
        sb.append(right.translate());
        sb.append(IsaToken.RPAREN.toString());
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
                    sb.append(processBinaryExpression(args[0], token, args[1]));
                }
                break;

            case STARSTAR:
            case STARSTARNAT:
                if (args.length != 2)
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), token.toString(), args.length, TRExpressionList.translate(args));
                else
                {
                    sb.append(processBinaryExpression(args[0], token, args[1]));
                    sb.append(getFormattingSeparator());
                    sb.append(IsaToken.comment(IsaWarningMessage.ISA_POWEROP_TYPEDEP.message, getFormattingSeparator()));
                    warning(IsaWarningMessage.ISA_POWEROP_TYPEDEP);
                }
                break;

            case LT:
            case GT:
                if (args.length != 2)
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), token.toString(), args.length, TRExpressionList.translate(args));
                else
                {
                    sb.append(processBinaryOrdExpression(args[0], token, args[1], token.equals(IsaToken.LT)));
                }
                break;    

            case LE:
            case GE:
                if (args.length != 2)
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), token.toString(), args.length, TRExpressionList.translate(args));
                else
                {
                    sb.append(processBinaryOrdEqExpression(args[0], token, args[1], token.equals(IsaToken.LE)));                    
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
                    sb.append(processBinaryEqExpression(args[0], token, args[1], token.equals(IsaToken.EQUALS)));
                }
                break;    
            default:
                report(IsaErrorMessage.PLUGIN_NYI_2P, "token " + token.toString(), TRExpressionList.translate(args));
        }
        return sb.toString();
    }

    // public final TRType getUltimateType(TRType t)
    // {
    //     TRType result = t;
    //     if (t instanceof TRNamedType)
    //         result = ((TRNamedType)t).ultimateType();
    //     return result;
    // }

    public final TRType getRecordType()
    {
        TRType result = doGetRecordType();
        if (!(result.ultimateType() instanceof TRRecordType))
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
        TRType result = getType().ultimateType();//getUltimateType(getType());

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
                result = t.getInnerType().ultimateType();//getUltimateType(t.getInnerType());            
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

    /**
     * Variables to bind as the union of all possibly free variables intersected with all bound variables  
     * This is usually called with the associated multiple bind list where the bound variables come from.
     * @param bound
     * @param possiblyFree
     * @return dunion possiblyFree inter bound
     */
    public static final TCNameSet variablesToBind(TCNameList bound, TCNameSet... possiblyFree)
    {
        TCNameSet result = new TCNameSet();
        for(TCNameSet vs : possiblyFree)
        {
            result.addAll(vs);
        }
        result.retainAll(bound);
        return result;
    }

    public static final TCNameSet variablesToBind(TRMultipleBindList bindings, TCNameSet... possiblyFree)
    {
        return TRExpression.variablesToBind(bindings.getPatternListList().getNamesInPatternListList(), possiblyFree);
    }

    public static final boolean isTrivialPred(TRExpression pred)
    {
        return pred == null || 
              (pred instanceof TRLiteralExpression && 
                ((TRLiteralExpression)pred).exp.equals(IsaToken.TRUE.toString()));
    }
}
