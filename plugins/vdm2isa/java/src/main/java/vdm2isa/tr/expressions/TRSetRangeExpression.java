package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCSetRangeExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRUnknownType;

public class TRSetRangeExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    public final TRExpression first;
    public final TRExpression last;

    public TRSetRangeExpression(LexLocation start, TCSetRangeExpression tc, TRExpression first, TRExpression last, TRType exptype)
    {
        super(start, tc, exptype);
        this.first = first;
        this.last = last;
    }

    @Override
    public void setup()
    {
        super.setup();
        assert first != null && last != null;
        TRNode.setup(first, last);
        if (!first.getType().isPossibleSetRange() || !last.getType().isPossibleSetRange())
        {
            report(IsaErrorMessage.ISA_INVALID_SET_RANGE_TYPE_1P, 
                first.getType().isPossibleSetRange() ? last.getType().translate() : first.getType().translate());
        }
    }

    @Override
    protected TRType getBestGuessType()
    {
        TRType t = first.getType();
        if (t instanceof TRUnknownType)
            t = last.getType();
        return TRSetType.newSetType(location, t, false);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.SET;
    }

    @Override
    public String translate() {
        return IsaToken.SET_OPEN.toString() + first.translate() + IsaToken.RANGE.toString() + last.translate() + IsaToken.SET_CLOSE.toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSetRangeExpression(this, arg);
	}
}
