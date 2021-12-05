package vdm2isa.tr.expressions;

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
import vdm2isa.tr.definitions.TRDefinitionList;
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
				if (!(result instanceof TRBasicType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "1", "expects basic type");
				break;

			case DUNION:
            case DINTER:
				if (expType instanceof TRSetType)
				{
					result = ((TRSetType)expType).getInnerType();
					if (!(result instanceof TRSetType))
						report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "1", "expects set type");
				}
				else
					result = super.getType();
				break;
			
			case INDS:
				if (expType instanceof TRSeqType)
				{
					TRType indsType = TRBasicType.nat1Type(location);
					result = new TRSetType(indsType.getVDMType(), new TRDefinitionList(), indsType, ((TRSeqType)expType).seq1);
				}	
				else
					result = super.getType();
				break;

			case ELEMS:
				if (expType instanceof TRSeqType)
				{
					TRType elemsType = ((TRSeqType)expType).getInnerType();
					result = new TRSetType(elemsType.getVDMType(), new TRDefinitionList(), elemsType, ((TRSeqType)expType).seq1);
				}	
				else
					result = super.getType();
				break;

			case REVERSE:
			case TAIL:
				result = expType;
				if (!(result instanceof TRSeqType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "1", "expects seq type");
				break;

			case HEAD:
				if (expType instanceof TRSeqType)
				{
					TRSeqType seqt = (TRSeqType)expType;
					result = seqt.getInnerType();
				}
				else
					result = super.getType();
				break;
	
			case DISTCONC:
				if (expType instanceof TRSeqType)
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
				if (expType instanceof TRSetType)
				{
					TRSetType sexp = (TRSetType)expType;
					result = sexp.getInnerType();
					if (!(result instanceof TRMapType))
						report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "1", "expects map type");
				}
				else
					result = super.getType();
				break;

            case INVERSE:
				result = expType;
				if (!(result instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "1", "expects map type");
				break;

			case DOM:
				if (expType instanceof TRMapType)
				{
					TRMapType mtyp = (TRMapType)expType;
					result = mtyp.getFromType();
				}
				else
					result = super.getType();
				break;

			case RNG:
				if (expType instanceof TRMapType)
				{
					TRMapType mtyp = (TRMapType)expType;
					result = mtyp.getToType();
				}
				else
					result = super.getType();
				break;

			case FPOWERSET:
				if (expType instanceof TRSetType)
				{
					TRSetType sexp = (TRSetType)expType;
					result = new TRSetType(sexp.getVDMType(), new TRDefinitionList(), sexp, true);
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
}
