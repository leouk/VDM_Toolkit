package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRType;

public class TRSeqEnumExpression extends TREnumeratedExpression 
{
	private static final long serialVersionUID = 1L;

    public TRSeqEnumExpression(LexLocation location, TRExpressionList members)
	{
		super(location, members);
	}

    @Override
    public TRType getType()
    {
        return new TRSeqType(location, new TRDefinitionList(), members.getType(), !members.isEmpty());
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
