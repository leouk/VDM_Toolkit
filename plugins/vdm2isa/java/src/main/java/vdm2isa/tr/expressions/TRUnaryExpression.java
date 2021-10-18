package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCAbsoluteExpression;
import com.fujitsu.vdmj.tc.expressions.TCCardinalityExpression;
import com.fujitsu.vdmj.tc.expressions.TCIndicesExpression;
import com.fujitsu.vdmj.tc.expressions.TCDistConcatExpression;
import com.fujitsu.vdmj.tc.expressions.TCDistIntersectExpression;
import com.fujitsu.vdmj.tc.expressions.TCDistMergeExpression;
import com.fujitsu.vdmj.tc.expressions.TCDistUnionExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapDomainExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapRangeExpression;
import com.fujitsu.vdmj.tc.expressions.TCNotExpression;
import com.fujitsu.vdmj.tc.expressions.TCReverseExpression;
import com.fujitsu.vdmj.tc.expressions.TCFloorExpression;
import com.fujitsu.vdmj.tc.expressions.TCHeadExpression;
import com.fujitsu.vdmj.tc.expressions.TCLenExpression;
import com.fujitsu.vdmj.tc.expressions.TCTailExpression;
import com.fujitsu.vdmj.tc.expressions.TCUnaryMinusExpression;
import com.fujitsu.vdmj.tc.expressions.TCUnaryPlusExpression;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;

//@todo uncertain whether to have unique cases or not, like in the "literal" sense. 
public class TRUnaryExpression extends TRExpression {

    private static final long serialVersionUID = 1L;

    protected final TCExpression owner;
	protected final TRExpression exp;

	public TRUnaryExpression(TCAbsoluteExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCFloorExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCUnaryMinusExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCUnaryPlusExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCCardinalityExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCLenExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCHeadExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCTailExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCIndicesExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCDistConcatExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCDistIntersectExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCDistUnionExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCDistMergeExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCMapDomainExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCMapRangeExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCNotExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCReverseExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    @Override
    public String translate() 
    {
        return IsaTemplates.tokenise(isaToken(), location, exp);
    }

    @Override
    public IsaToken isaToken() 
    {
        if (owner instanceof TCNotExpression)
            return IsaToken.NOT;
        else if (owner instanceof TCAbsoluteExpression)
            return IsaToken.ABS;
        else if (owner instanceof TCFloorExpression)
            return IsaToken.FLOOR;
        else if (owner instanceof TCUnaryMinusExpression)
            return IsaToken.MINUS;
        else if (owner instanceof TCUnaryPlusExpression)
            return IsaToken.PLUS;
        else if (owner instanceof TCCardinalityExpression)
            return IsaToken.CARD;
        else if (owner instanceof TCDistUnionExpression)
            return IsaToken.DUNION;
        else if (owner instanceof TCDistIntersectExpression)
            return IsaToken.DINTER;
        else if (owner instanceof TCLenExpression)
            return IsaToken.LEN;
        else if (owner instanceof TCHeadExpression)
            return IsaToken.HEAD;
        else if (owner instanceof TCTailExpression)
            return IsaToken.TAIL;
        else if (owner instanceof TCIndicesExpression)
            return IsaToken.INDS;
        else if (owner instanceof TCDistConcatExpression)
            return IsaToken.DISTCONC;
        else if (owner instanceof TCDistMergeExpression)
            return IsaToken.MERGE;
        else if (owner instanceof TCMapDomainExpression)
            return IsaToken.DOM;
        else if (owner instanceof TCMapRangeExpression)
            return IsaToken.RNG;
        else if (owner instanceof TCReverseExpression)
            return IsaToken.REVERSE;
        else
			throw new RuntimeException("Invalid VDM unary expression " + owner.getClass().getName() + " = " + owner.toString());
    }


}