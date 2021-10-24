package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
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

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;

//@todo uncertain whether to have unique cases or not, like in the "literal" sense. 
public class TRUnaryExpression extends TRExpression {

    private static final long serialVersionUID = 1L;

    protected final IsaToken owner;
	protected final TRExpression exp;

	public TRUnaryExpression(TCAbsoluteExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.ABS;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCFloorExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.FLOOR;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCUnaryMinusExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.UMINUS;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCUnaryPlusExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.UPLUS;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCCardinalityExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.CARD;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCPowerSetExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.POWER;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCLenExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.LEN;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCHeadExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.HEAD;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCTailExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.TAIL;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCIndicesExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.INDS;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCElementsExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.ELEMS;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCDistConcatExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.DISTCONC;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCDistIntersectExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.DINTER;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCDistUnionExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.DUNION;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCDistMergeExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.MERGE;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCMapDomainExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.DOM;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCMapRangeExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.RANGE;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCMapInverseExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.INVERSE;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCNotExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.NOT;//owner;
		this.exp = exp;
	}

    public TRUnaryExpression(TCReverseExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = IsaToken.REVERSE;//owner;
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
        return owner;
        /* TODO fold this into owner as the IsaToken parameter (i.e. compute once at construction time only?)
        if (owner instanceof TCNotExpression)
            return IsaToken.NOT;
        else if (owner instanceof TCAbsoluteExpression)
            return IsaToken.ABS;
        else if (owner instanceof TCFloorExpression)
            return IsaToken.FLOOR;
        else if (owner instanceof TCUnaryMinusExpression)
            return IsaToken.UMINUS;
        else if (owner instanceof TCUnaryPlusExpression)
            return IsaToken.UPLUS;
        else if (owner instanceof TCCardinalityExpression)
            return IsaToken.CARD;
        else if (owner instanceof TCPowerSetExpression)
            return IsaToken.POWER;
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
        else if (owner instanceof TCElementsExpression)
            return IsaToken.ELEMS;
        else if (owner instanceof TCDistConcatExpression)
            return IsaToken.DISTCONC;
        else if (owner instanceof TCMapInverseExpression)
            return IsaToken.INVERSE;
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
        */
    }


}