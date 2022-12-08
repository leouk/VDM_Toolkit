package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCNilExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRNilExpression extends TRExpression {

	private static final long serialVersionUID = 1L;
    
    public TRNilExpression(LexLocation location, TCNilExpression tc, TRType exptype)
    {
        super(location, tc, exptype);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.NIL;
    }

    @Override
    public String oldtranslate() {
        return isaToken().toString();
    }
    
	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseNilExpression(this, arg);
	}
}
