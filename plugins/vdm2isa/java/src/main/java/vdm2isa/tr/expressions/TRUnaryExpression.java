package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCAbsoluteExpression;
import com.fujitsu.vdmj.tc.expressions.TCCardinalityExpression;
import com.fujitsu.vdmj.tc.expressions.TCIndicesExpression;
import com.fujitsu.vdmj.tc.expressions.TCElementsExpression;
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
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRBasicPattern;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;

//@todo uncertain whether to have unique cases or not, like in the "literal" sense. 
public class TRUnaryExpression extends TRExpression {

    private static final long serialVersionUID = 1L;

    protected final IsaToken owner;
	protected final TRExpression exp;

	protected TRUnaryExpression(LexLocation location, IsaToken token, TRExpression exp)
	{
		super(location);
		this.owner = token;
		this.exp = exp;
		if (!VALID_UNARY_OPS.contains(isaToken()))
			report(IsaErrorMessage.VDMSL_INVALID_EXPROP_1P, isaToken().toString());
	}

	public TRUnaryExpression(TCAbsoluteExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.ABS, exp);
	}

    public TRUnaryExpression(TCFloorExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.FLOOR, exp);
	}

    public TRUnaryExpression(TCUnaryMinusExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.UMINUS, exp);
	}

    public TRUnaryExpression(TCUnaryPlusExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.UPLUS, exp);
	}

    public TRUnaryExpression(TCCardinalityExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.CARD, exp);
	}

    public TRUnaryExpression(TCPowerSetExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.FPOWERSET, exp);
	}

    public TRUnaryExpression(TCLenExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.LEN, exp);
	}

    public TRUnaryExpression(TCHeadExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.HEAD, exp);
	}

    public TRUnaryExpression(TCTailExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.TAIL, exp);
	}

    public TRUnaryExpression(TCIndicesExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.INDS, exp);
	}

    public TRUnaryExpression(TCElementsExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.ELEMS, exp);
	}

    public TRUnaryExpression(TCDistConcatExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.DISTCONC, exp);
	}

    public TRUnaryExpression(TCDistIntersectExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.DINTER, exp);
	}

    public TRUnaryExpression(TCDistUnionExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.DUNION, exp);
	}

    public TRUnaryExpression(TCDistMergeExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.MERGE, exp);
	}

    public TRUnaryExpression(TCMapDomainExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.DOM, exp);
	}

    public TRUnaryExpression(TCMapRangeExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.RNG, exp);
	}

    public TRUnaryExpression(TCMapInverseExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.INVERSE, exp);
	}

    public TRUnaryExpression(TCNotExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.NOT, exp);
	}

    public TRUnaryExpression(TCReverseExpression owner, TRExpression exp)
	{
		this(owner.location, IsaToken.REVERSE, exp);
	}

	@Override 
    protected void setup()
    {
        super.setup();
		// unary operator are spaced given Isabelle currying
        setSemanticSeparator(" ");
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
