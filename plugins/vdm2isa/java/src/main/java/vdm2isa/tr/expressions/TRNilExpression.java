package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRNilExpression extends TRExpression {

	private static final long serialVersionUID = 1L;
    
    public TRNilExpression(LexLocation location, TRType exptype)
    {
        super(location, exptype);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.NIL;
    }

    @Override
    public String translate() {
        return isaToken().toString();
    }
    
	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseNilExpression(this, arg);
	}
}
