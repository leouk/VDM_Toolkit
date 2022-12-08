package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCSubseqExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRSubseqExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    public final TRExpression seq;
    public final TRExpression from;
    public final TRExpression to;

    public TRSubseqExpression(TCSubseqExpression tc, TRExpression seq, TRExpression from, TRExpression to, TRType exptype)
    {
        super(seq != null ? seq.location : LexLocation.ANY, tc, exptype);
        this.seq = seq;
        this.from = from;
        this.to = to;
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(seq, from, to);
    }

    @Override
    protected TRType getBestGuessType()
    {
        return seq.getType();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.SEQ;
    }

    @Override
    public String oldtranslate() {
        return "(" + seq.oldtranslate() + IsaToken.APPLY.toString() + 
            IsaToken.SET_OPEN.toString() + from.oldtranslate() + IsaToken.SUBSEQ.toString() + 
            to.oldtranslate() + IsaToken.SET_CLOSE.toString() + ")";
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSubseqExpression(this, arg);
	}
}
