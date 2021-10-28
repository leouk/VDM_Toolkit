package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRSetEnumExpression extends TREnumeratedExpression 
{
	private static final long serialVersionUID = 1L;

    public TRSetEnumExpression(LexLocation location, TRExpressionList members)
	{
		super(location, members);
	}

    @Override
    public IsaToken leftBracket() {
        return IsaToken.SET_OPEN;
    }

    @Override
    public IsaToken rightBracket() {
       return IsaToken.SET_CLOSE;
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSetEnumExpression(this, arg);
	}
}
