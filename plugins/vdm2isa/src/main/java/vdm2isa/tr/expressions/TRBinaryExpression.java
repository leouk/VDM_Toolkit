/*******************************************************************************
 *	Copyright (c) 2021 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexKeywordToken;
import com.fujitsu.vdmj.ast.lex.LexToken;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCAndExpression;
import com.fujitsu.vdmj.tc.expressions.TCBinaryExpression;
import com.fujitsu.vdmj.tc.expressions.TCCompExpression;
import com.fujitsu.vdmj.tc.expressions.TCDivExpression;
import com.fujitsu.vdmj.tc.expressions.TCDivideExpression;
import com.fujitsu.vdmj.tc.expressions.TCDomainResByExpression;
import com.fujitsu.vdmj.tc.expressions.TCDomainResToExpression;
import com.fujitsu.vdmj.tc.expressions.TCEqualsExpression;
import com.fujitsu.vdmj.tc.expressions.TCEquivalentExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCGreaterEqualExpression;
import com.fujitsu.vdmj.tc.expressions.TCGreaterExpression;
import com.fujitsu.vdmj.tc.expressions.TCImpliesExpression;
import com.fujitsu.vdmj.tc.expressions.TCInSetExpression;
import com.fujitsu.vdmj.tc.expressions.TCLessEqualExpression;
import com.fujitsu.vdmj.tc.expressions.TCLessExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapUnionExpression;
import com.fujitsu.vdmj.tc.expressions.TCModExpression;
import com.fujitsu.vdmj.tc.expressions.TCNotEqualExpression;
import com.fujitsu.vdmj.tc.expressions.TCNotInSetExpression;
import com.fujitsu.vdmj.tc.expressions.TCOrExpression;
import com.fujitsu.vdmj.tc.expressions.TCPlusExpression;
import com.fujitsu.vdmj.tc.expressions.TCPlusPlusExpression;
import com.fujitsu.vdmj.tc.expressions.TCProperSubsetExpression;
import com.fujitsu.vdmj.tc.expressions.TCRangeResByExpression;
import com.fujitsu.vdmj.tc.expressions.TCRangeResToExpression;
import com.fujitsu.vdmj.tc.expressions.TCRemExpression;
import com.fujitsu.vdmj.tc.expressions.TCSeqConcatExpression;
import com.fujitsu.vdmj.tc.expressions.TCSetDifferenceExpression;
import com.fujitsu.vdmj.tc.expressions.TCSetIntersectExpression;
import com.fujitsu.vdmj.tc.expressions.TCSetUnionExpression;
import com.fujitsu.vdmj.tc.expressions.TCStarStarExpression;
import com.fujitsu.vdmj.tc.expressions.TCSubsetExpression;
import com.fujitsu.vdmj.tc.expressions.TCSubtractExpression;
import com.fujitsu.vdmj.tc.expressions.TCTimesExpression;

import plugins.GeneralisaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
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
	public final TRExpression left;
	public final TRExpression right;
	public final LexToken op;
	
	public TRBinaryExpression(TCBinaryExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		super(op != null ? op.location : LexLocation.ANY, tc, exptype);
		this.left = left;
		//@todo equals expression has to be specialised because of record and other equality tests ? 
		this.op = op;
		this.right = right;
	}

	// Class mapper really insists on type-specific constructors, so can't rely on inheritance for TCBinaryExpression :-()
	private TRBinaryExpression(TCBinaryExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype, boolean dummy)
	{
		this(tc, left, op, right, exptype);
	}

	public TRBinaryExpression(TCMapUnionExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCModExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCAndExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCCompExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCSetUnionExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCSetIntersectExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCImpliesExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCEquivalentExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCLessExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCLessEqualExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCGreaterExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCGreaterEqualExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCSeqConcatExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCDivideExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCDomainResToExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCDomainResByExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCRangeResToExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCRangeResByExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCStarStarExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCSubtractExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCPlusExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCProperSubsetExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCSubsetExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCNotInSetExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCInSetExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCRemExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCDivExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCPlusPlusExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCOrExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCNotEqualExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCEqualsExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCTimesExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	public TRBinaryExpression(TCSetDifferenceExpression tc, TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		this(tc, left, op, right, exptype, false);
	}

	@Override
	public void setup()
	{
		super.setup();
		// binary operator are spaced given Isabelle currying
		setSemanticSeparator(IsaToken.SPACE.toString());

		if (!VALID_BINARY_OPS.contains(isaToken()))
			report(IsaErrorMessage.VDMSL_INVALID_EXPROP_1P, isaToken().toString());
		if (isaToken().equals(IsaToken.STARSTAR) || isaToken().equals(IsaToken.STARSTARNAT))
			// add because of comment on potential problem? 
			setFormattingSeparator("\n\t");

		TRNode.setup(left, right);
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
				if (result.ultimateType() instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result.ultimateType() instanceof TRBasicType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects basic type");
				break; 

			case UNION:
            case INTER:
            case SETDIFF:
				result = left.getType();
				if (result.ultimateType() instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result.ultimateType() instanceof TRSetType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects set type");

				break;

			case CONCATENATE:
				result = left.getType();
				if (result.ultimateType() instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result.ultimateType() instanceof TRSeqType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects seq type");
				break;

            case MUNION:
            case PLUSPLUS:
            case COMP:
				result = left.getType();
				if (result.ultimateType() instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result.ultimateType() instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects map type");
				break;

			case DOMRESTO:  // S <: m , get right  
            case DOMRESBY:
				result = right.getType();
				if (!(result.ultimateType() instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects map type");
				break;

            case RANGERESTO: // m :> S, get left
            case RANGERESBY:
				result = left.getType();
				if (!(result.ultimateType() instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects map type");
				break;

			default:
				result = super.getType();
				break;
		}
		return result;
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

	public static final TRBinaryExpression newBinaryExpression(TRExpression left, IsaToken token, TRExpression right, TRType exptype)
	{
		return TRBinaryExpression.newBinaryExpression(left, new LexKeywordToken(token.vdmToken(), left.location), right, exptype);
	}

	public static final TRBinaryExpression newBinaryExpression(TRExpression left, LexToken op, TRExpression right, TRType exptype)
	{
		IsaToken token = IsaToken.from(op);
		assert VALID_BINARY_OPS.contains(token);
		TRBinaryExpression result = 
			new TRBinaryExpression(
				TRBinaryExpression.newTCBinaryExpression(left, op, right), 
				left, op, right, exptype);
		return result;
	} 

	protected static TCBinaryExpression newTCBinaryExpression(TRExpression left, LexToken op, TRExpression right)
	{
		IsaToken token = IsaToken.from(op);
		assert VALID_BINARY_OPS.contains(token);
		TCExpression l = left.getVDMExpr();
		TCExpression r = right.getVDMExpr();
		TCBinaryExpression result;
		switch (token)
		{
			case AND:
				result = new TCAndExpression(l, op, r);
				break;
			case  OR:
				result = new TCOrExpression(l, op, r);
				break;
			case  IMPLIES:
				result = new TCImpliesExpression(l, op, r);
				break;
			case  EQUIVALENT:
				result = new TCEquivalentExpression(l, op, r);
				break;
			case  NE:
				result = new TCNotEqualExpression(l, op, r);
				break;
			case  LT:
				result = new TCLessExpression(l, op, r);
				break;
			case  LE:
				result = new TCLessEqualExpression(l, op, r);
				break;
			case  GT:
				result = new TCGreaterExpression(l, op, r);
				break;
			case  GE:
				result = new TCGreaterEqualExpression(l, op, r);
				break;
			case  PLUS:
				result = new TCPlusExpression(l, op, r);
				break;
			case  MINUS:
				result = new TCSubtractExpression(l, op, r);
				break;
			case  TIMES:
				result = new TCTimesExpression(l, op, r);
				break;
			case  DIV:
				result = new TCDivExpression(l, op, r);
				break;
			case  DIVIDE:
				result = new TCDivideExpression(l, op, r);
				break;
			case  MOD:
				result = new TCModExpression(l, op, r);
				break;
			case  REM:
				result = new TCRemExpression(l, op, r);
				break;
			case  INSET:
				result = new TCInSetExpression(l, op, r);
				break;
			case  NOTINSET:
				result = new TCNotInSetExpression(l, op, r);
				break;
			case  UNION:
				result = new TCSetUnionExpression(l, op, r);
				break;
			case  INTER:
				result = new TCSetIntersectExpression(l, op, r);
				break;
			case  SETDIFF:
				result = new TCSetDifferenceExpression(l, op, r);
				break;
			case  SUBSET:
				result = new TCSubsetExpression(l, op, r);
				break;
			case  PSUBSET:
				result = new TCProperSubsetExpression(l, op, r);
				break;
			case  CONCATENATE:
				result = new TCSeqConcatExpression(l, op, r);
				break;
			case  PLUSPLUS:
				result = new TCPlusPlusExpression(l, op, r);
				break;
			case  DOMRESTO:
				result = new TCDomainResToExpression(l, op, r);
				break;
			case  DOMRESBY:
				result = new TCDomainResByExpression(l, op, r);
				break;
			case  RANGERESTO:
				result = new TCRangeResToExpression(l, op, r);
				break;
			case  RANGERESBY:
				result = new TCRangeResByExpression(l, op, r);
				break;
			case  MUNION:
				result = new TCMapUnionExpression(l, op, r);
				break;
			case  COMP:
				result = new TCCompExpression(l, op, r);
				break;
			case  EQUALS:
				result = new TCEqualsExpression(l, op, r);
				break;
			case  STARSTAR:
			case  STARSTARNAT:
				result = new TCStarStarExpression(l, op, r);
				break;
			default:
				result = null;
				break;
		}
		return result;
	}

	public static final boolean uniformlyTyped(TRType type, TRExpression... args)
	{
		boolean result = args == null || args.length == 0;
		if (!result)
		{
			result = args[0] != null && args[0].getType().compatible(type);
			for(int i = 1; i < args.length && result; i++)
			{
				result = result && args[i] != null && args[i].getType().compatible(type);				
			}
		}
		return result;
	}

	public static final TRExpression newBooleanChain(LexLocation location, IsaToken token, TRExpression... args)
	{
		return TRBinaryExpression.newBooleanChain(new LexKeywordToken(token.vdmToken(), location), args);
	}

	/**
	 * Creates a boolean chain of expressions (e.g., args[0] and ... and args[i]).
	 * This presumes op is valid boolean chain operator (e.g. and, or, etc.), and that
	 * all elements within args have boolean type. Simply "true" is returned otherwise. 
	 */
	public static final TRExpression newBooleanChain(LexToken op, TRExpression... args)
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
					result = TRBinaryExpression.newBinaryExpression(result, op, args[i], result.getType());
				}
			}
			else 
			{
				GeneralisaPlugin.report(IsaErrorMessage.ISA_INVALID_EXPRCHAIN_TYPE_1P, op.location, IsaToken.from(op).toString());
			}
		}
		TRNode.setup(result);
		return result;
	}
}
