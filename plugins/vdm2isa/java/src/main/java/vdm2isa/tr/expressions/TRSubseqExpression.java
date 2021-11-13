package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRSubseqExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    private final TRExpression seq;
    private final TRExpression from;
    private final TRExpression to;

    public TRSubseqExpression(TRExpression seq, TRExpression from, TRExpression to, TRType exptype)
    {
        super(seq.location, exptype);
        this.seq = seq;
        this.from = from;
        this.to = to;
    }

    @Override
    public TRType getType()
    {
        return seq.getType();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.SEQ;
    }

    @Override
    public String translate() {
        return "(" + seq.translate() + IsaToken.APPLY.toString() + 
            IsaToken.SET_OPEN.toString() + from.translate() + IsaToken.SUBSEQ.toString() + 
            to.translate() + IsaToken.SET_CLOSE.toString() + ")";
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSubseqExpression(this, arg);
	}
}
