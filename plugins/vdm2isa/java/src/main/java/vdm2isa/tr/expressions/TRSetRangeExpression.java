package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRSetRangeExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    private final TRExpression first;
    private final TRExpression last;

    public TRSetRangeExpression(LexLocation start, TRExpression first, TRExpression last)
    {
        super(start);
        this.first = first;
        this.last = last;
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
