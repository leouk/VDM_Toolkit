package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCUndefinedExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRUndefinedExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;

    public TRUndefinedExpression(LexLocation location, TCUndefinedExpression tc, TRType exptype)
    {
        super(location, tc, exptype);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.UNDEFINED;
    }

    @Override
    public String translate() {
        return isaToken().toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseUndefinedExpression(this, arg);
	}
}
