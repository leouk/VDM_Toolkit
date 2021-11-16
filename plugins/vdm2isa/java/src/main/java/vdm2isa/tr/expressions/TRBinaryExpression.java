/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexToken;

import plugins.GeneralisaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRUnknownType;

public class TRBinaryExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	protected final TRExpression left;
	protected final TRExpression right;
	protected final LexToken op;
	
	public TRBinaryExpression(TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		super(op.location, exptype);
		this.left = left;
		//@todo equals expression has to be specialised because of record and other equality tests ? 
		this.op = op;
		this.right = right;
		if (!VALID_BINARY_OPS.contains(isaToken()))
			report(IsaErrorMessage.VDMSL_INVALID_EXPROP_1P, isaToken().toString());
		if (isaToken().equals(IsaToken.STARSTAR) || isaToken().equals(IsaToken.STARSTARNAT))
			// add because of comment on potential problem? 
			setFormattingSeparator("\n\t");
	}

	/**
	 * Choose the type according to the operator
	 */
	@Override
	protected TRType getBestGuessType()
	{
		TRType result;
		switch (isaToken())
		{
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
				result = TRBasicType.boolType(location);
				break;
			
			case NE:
			case EQUALS:
				result = left.getType();
				if (result instanceof TRUnknownType)
					result = right.getType(); 
				if (result instanceof TRUnknownType)
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects equivalent type");
				break;

            case PLUS:
            case MINUS:
            case TIMES:
            case DIV:
            case DIVIDE:
            case MOD:
            case REM:
			case STARSTAR:
			case STARSTARNAT:				
				result = left.getType();
				if (result instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result instanceof TRBasicType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects basic type");
				break; 

			case UNION:
            case INTER:
            case SETDIFF:
				result = left.getType();
				if (result instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result instanceof TRSetType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects set type");

				break;

			case CONCATENATE:
				result = left.getType();
				if (result instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result instanceof TRSeqType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects seq type");
				break;

            case MUNION:
            case PLUSPLUS:
            case COMP:
				result = left.getType();
				if (result instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects map type");
				break;

			case DOMRESTO:  // S <: m , get right  
            case DOMRESBY:
				result = right.getType();
				if (!(result instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects map type");
				break;

            case RANGERESTO: // m :> S, get left
            case RANGERESBY:
				result = left.getType();
				if (!(result instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects map type");
				break;

			default:
				result = super.getType();
				break;
		}
		return result;
	}

    @Override 
    protected void setup()
    {
        super.setup();
		// binary operator are spaced given Isabelle currying
        setSemanticSeparator(" ");
    }

	@Override
	public IsaToken isaToken()
	{
		return IsaToken.from(op);
	}

	@Override
	public String translate()
	{
		return tokenise(isaToken(), location, left, right);
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseBinaryExpression(this, arg);
	}

	public static boolean uniformlyTyped(TRType type, TRExpression... args)
	{
		boolean result = args == null || args.length == 0;
		if (!result)
		{
			result = args[0].getType().compatible(type);
			for(int i = 1; i < args.length && result; i++)
			{
				result = result && args[i].getType().compatible(type);				
			}
		}
		return result;
	}
	/**
	 * Creates a boolean chain of expressions (e.g., args[0] and ... and args[i]).
	 * This presumes op is valid boolean chain operator (e.g. and, or, etc.), and that
	 * all elements within args have boolean type. Simply "true" is returned otherwise. 
	 */
	public static TRExpression newBooleanChain(LexToken op, TRExpression... args)
	{
		TRExpression result = TRLiteralExpression.newBooleanLiteralExpression(op.location, true);
		if (!VALID_BOOLEAN_CHAIN_OPS.contains(IsaToken.from(op)))
		{
			GeneralisaPlugin.report(IsaErrorMessage.VDMSL_INVALID_EXPROP_1P, op.location, IsaToken.from(op).toString());
		}
		else if (args != null && args.length > 0)
		{
			if (TRBinaryExpression.uniformlyTyped(result.getType(), args))
			{
				result = args[0];
				for(int i = 1; i < args.length; i++)
				{
					result = new TRBinaryExpression(result, op, args[i], result.getType());
				}
			}
			else 
			{
				GeneralisaPlugin.report(IsaErrorMessage.ISA_INVALID_EXPRCHAIN_TYPE_1P, op.location, IsaToken.from(op).toString());
			}
		}
		return result;
	}
}
