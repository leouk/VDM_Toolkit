package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexKeywordToken;
import com.fujitsu.vdmj.ast.lex.LexToken;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCAbsoluteExpression;
import com.fujitsu.vdmj.tc.expressions.TCCardinalityExpression;
import com.fujitsu.vdmj.tc.expressions.TCIndicesExpression;
import com.fujitsu.vdmj.tc.expressions.TCElementsExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCDistConcatExpression;
import com.fujitsu.vdmj.tc.expressions.TCDistIntersectExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapInverseExpression;
import com.fujitsu.vdmj.tc.expressions.TCDistMergeExpression;
import com.fujitsu.vdmj.tc.expressions.TCDistUnionExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapDomainExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapRangeExpression;
import com.fujitsu.vdmj.tc.expressions.TCNotExpression;
import com.fujitsu.vdmj.tc.expressions.TCPowerSetExpression;
import com.fujitsu.vdmj.tc.expressions.TCReverseExpression;
import com.fujitsu.vdmj.tc.expressions.TCFloorExpression;
import com.fujitsu.vdmj.tc.expressions.TCHeadExpression;
import com.fujitsu.vdmj.tc.expressions.TCLenExpression;
import com.fujitsu.vdmj.tc.expressions.TCTailExpression;
import com.fujitsu.vdmj.tc.expressions.TCUnaryMinusExpression;
import com.fujitsu.vdmj.tc.expressions.TCUnaryPlusExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;

//@todo uncertain whether to have unique cases or not, like in the "literal" sense. 
public class TRUnaryExpression extends TRExpression {

    private static final long serialVersionUID = 1L;

    public final IsaToken owner;
	public final TRExpression exp;

	protected TRUnaryExpression(LexLocation location, TCExpression tc, IsaToken token, TRExpression exp, TRType exptype)
	{
		super(location, tc, exptype);
		this.owner = token;
		this.exp = exp;
	}

	public TRUnaryExpression(TCAbsoluteExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.ABS, exp, exptype);
	}

    public TRUnaryExpression(TCFloorExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.FLOOR, exp, exptype);
	}

    public TRUnaryExpression(TCUnaryMinusExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.UMINUS, exp, exptype);
	}

    public TRUnaryExpression(TCUnaryPlusExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.UPLUS, exp, exptype);
	}

    public TRUnaryExpression(TCCardinalityExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.CARD, exp, exptype);
	}

    public TRUnaryExpression(TCPowerSetExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.FPOWERSET, exp, exptype);
	}

    public TRUnaryExpression(TCLenExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.LEN, exp, exptype);
	}

    public TRUnaryExpression(TCHeadExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.HEAD, exp, exptype);
	}

    public TRUnaryExpression(TCTailExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.TAIL, exp, exptype);
	}

    public TRUnaryExpression(TCIndicesExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.INDS, exp, exptype);
	}

    public TRUnaryExpression(TCElementsExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.ELEMS, exp, exptype);
	}

    public TRUnaryExpression(TCDistConcatExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.DISTCONC, exp, exptype);
	}

    public TRUnaryExpression(TCDistIntersectExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.DINTER, exp, exptype);
	}

    public TRUnaryExpression(TCDistUnionExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.DUNION, exp, exptype);
	}

    public TRUnaryExpression(TCDistMergeExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.MERGE, exp, exptype);
	}

    public TRUnaryExpression(TCMapDomainExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.DOM, exp, exptype);
	}

    public TRUnaryExpression(TCMapRangeExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.RNG, exp, exptype);
	}

    public TRUnaryExpression(TCMapInverseExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.INVERSE, exp, exptype);
	}

    public TRUnaryExpression(TCNotExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.NOT, exp, exptype);
	}

    public TRUnaryExpression(TCReverseExpression owner, TRExpression exp, TRType exptype)
	{
		this(owner != null ? owner.location : LexLocation.ANY, owner, IsaToken.REVERSE, exp, exptype);
	}

	@Override 
    public void setup()
    {
        super.setup();
		// unary operator are spaced given Isabelle currying
        setSemanticSeparator(IsaToken.SPACE.toString());
		if (!VALID_UNARY_OPS.contains(isaToken()))
			report(IsaErrorMessage.VDMSL_INVALID_EXPROP_1P, isaToken().toString());
		TRNode.setup(exp);
    }

	/**
	 * Choose the type according to the operator
	 */
	@Override
	protected TRType getBestGuessType()
	{
		TRType result;
		TRType expType = exp.getType();
		switch (isaToken())
		{
            case NOT:
				result = TRBasicType.boolType(location);
				break;

			case ABS: 
            case FLOOR:
            case CARD:
            case LEN:
				result = TRBasicType.natType(location);
				break;

			case UMINUS:
            case UPLUS:
				// might be -1 or -1.5
				result = expType;
				if (!(result.ultimateType() instanceof TRBasicType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "1", "expects basic type");
				break;

			case DUNION:
            case DINTER:
				if (expType.ultimateType() instanceof TRSetType)
				{
					result = ((TRSetType)expType.ultimateType()).getInnerType();
					if (!(result.ultimateType() instanceof TRSetType))
						report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "1", "expects set type");
				}
				else
					result = super.getType();
				break;
			
			case INDS:
				if (expType.ultimateType() instanceof TRSeqType)
				{
					TRType indsType = TRBasicType.nat1Type(location);
					result = TRSetType.newSetType(location, indsType, ((TRSeqType)expType.ultimateType()).seq1);
				}	
				else
					result = super.getType();
				break;

			case ELEMS:
				if (expType.ultimateType() instanceof TRSeqType)
				{
					TRType elemsType = ((TRSeqType)expType.ultimateType()).getInnerType();
					result = TRSetType.newSetType(location, elemsType, ((TRSeqType)expType.ultimateType()).seq1);
				}	
				else
					result = super.getType();
				break;

			case REVERSE:
			case TAIL:
				result = expType;
				if (!(result.ultimateType() instanceof TRSeqType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "1", "expects seq type");
				break;

			case HEAD:
				if (expType.ultimateType() instanceof TRSeqType)
				{
					TRSeqType seqt = (TRSeqType)expType.ultimateType();
					result = seqt.getInnerType();
				}
				else
					result = super.getType();
				break;
	
			case DISTCONC:
				if (expType.ultimateType() instanceof TRSeqType)
				{
					TRSeqType seqt = (TRSeqType)expType;
					//TODO normalise these choices between raising a more specific error or delegating to super?  
					if (seqt.getInnerType() instanceof TRSeqType)
						result = seqt.getInnerType();
					else	
						result = super.getType();
				}
				else
					result = super.getType();
				break;

			case MERGE:
				if (expType.ultimateType() instanceof TRSetType)
				{
					TRSetType sexp = (TRSetType)expType.ultimateType();
					result = sexp.getInnerType();
					if (!(result.ultimateType() instanceof TRMapType))
						report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "1", "expects map type");
				}
				else
					result = super.getType();
				break;

            case INVERSE:
				result = expType;
				if (!(result.ultimateType() instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "1", "expects map type");
				break;

			case DOM:
				if (expType.ultimateType() instanceof TRMapType)
				{
					TRMapType mtyp = (TRMapType)expType.ultimateType();
					result = mtyp.getFromType();
				}
				else
					result = super.getType();
				break;

			case RNG:
				if (expType.ultimateType() instanceof TRMapType)
				{
					TRMapType mtyp = (TRMapType)expType.ultimateType();
					result = mtyp.getToType();
				}
				else
					result = super.getType();
				break;

			case FPOWERSET:
				if (expType.ultimateType() instanceof TRSetType)
				{
					TRSetType sexp = (TRSetType)expType.ultimateType();
					result = TRSetType.newSetType(location, sexp, false);
				}
				else
					result = super.getType();
				break;
			
			default:
				result = super.getType();
				break;
		}
		TRNode.setup(result);
		return result;
	}

    @Override
    public String translate() 
    {
        return tokenise(isaToken(), location, exp);
    }

    @Override
    public IsaToken isaToken() 
    {
        return owner;
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseUnaryExpression(this, arg);
	}

	protected static TCExpression newTCUnaryExpression(LexToken op, TRExpression expr)
	{
		IsaToken token = IsaToken.from(op);
		assert VALID_UNARY_OPS.contains(token);
		TCExpression exp = expr.getVDMExpr();
		TCExpression result;//TCUnaryExpression result;
		switch (token)
		{
			case NOT:
				result = new TCNotExpression(expr.location, exp);
				break;
			case ABS:
				result = new TCAbsoluteExpression(expr.location, exp);
				break;
			case FLOOR:
				result = new TCFloorExpression(expr.location, exp);
				break;
			case UMINUS:
				result = new TCUnaryMinusExpression(expr.location, exp);
				break;
			case CARD:
				result = new TCCardinalityExpression(expr.location, exp);
				break;
			case DUNION:
				result = new TCDistUnionExpression(expr.location, exp);
				break;
			case DINTER:
				result = new TCDistIntersectExpression(expr.location, exp);
				break;
			case LEN:
				result = new TCLenExpression(expr.location, exp);
				break;
			case HEAD:
				result = new TCHeadExpression(expr.location, exp);
				break;
			case TAIL:  
				result = new TCTailExpression(expr.location, exp);
				break;
			case INDS:
				result = new TCIndicesExpression(expr.location, exp);
				break;
			case ELEMS:
				result = new TCElementsExpression(expr.location, exp);
				break;
			case DISTCONC:
				result = new TCDistConcatExpression(expr.location, exp);
				break;
			case REVERSE:
				result = new TCReverseExpression(expr.location, exp);
				break;
			case MERGE:
				result = new TCDistMergeExpression(expr.location, exp);
				break;
			case DOM:
				result = new TCMapDomainExpression(expr.location, exp);
				break;
			case RNG:
				result = new TCMapRangeExpression(expr.location, exp);
				break;
			case INVERSE:
				result = new TCMapInverseExpression(expr.location, exp);
				break;
			case FPOWERSET:
				result = new TCPowerSetExpression(expr.location, exp);
				break;
			case UPLUS:
				result = new TCUnaryPlusExpression(expr.location, exp);
				break;
			default:
				result = null;
				break;
		}
		return result;
	}

	public static final TRUnaryExpression newUnaryExpression(IsaToken token, TRExpression expr)
	{
		assert VALID_UNARY_OPS.contains(token) && token.vdmToken() != null;
		TRUnaryExpression result = new TRUnaryExpression(expr.location, 
			TRUnaryExpression.newTCUnaryExpression(
				new LexKeywordToken(token.vdmToken(), expr.location), expr), 
			token, expr, expr.getType());
		TRNode.setup(result);
		return result; 
	}
}
