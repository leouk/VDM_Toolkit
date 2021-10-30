package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRTupleExpression extends TREnumeratedExpression {
    
	private static final long serialVersionUID = 1L;

    public TRTupleExpression(LexLocation location, TRExpressionList args)
    {
        super(location, args);
    }

    @Override
    public IsaToken leftBracket() {
        return IsaToken.LPAREN;
    }

    @Override
    public IsaToken rightBracket() {
        return IsaToken.RPAREN;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.CROSSPROD;
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseTupleExpression(this, arg);
	}
}
