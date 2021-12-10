package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCSeqEnumExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRType;

public class TRSeqEnumExpression extends TREnumeratedExpression 
{
	private static final long serialVersionUID = 1L;

    public TRSeqEnumExpression(LexLocation location, TCSeqEnumExpression tc, TRExpressionList members, TRType exptype)
	{
		super(location, tc, members, exptype);
	}

    @Override
    protected TRType getBestGuessType()
    {
        return TRSeqType.newSeqType(location, exptype, !members.isEmpty());
    }

    @Override
    public IsaToken leftBracket() {
        return IsaToken.SEQ_OPEN;
    }

    @Override
    public IsaToken rightBracket() {
       return IsaToken.SEQ_CLOSE;
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSeqEnumExpression(this, arg);
	}

    @Override
    public IsaToken isaToken() {
        return IsaToken.SEQ;
    }
}
