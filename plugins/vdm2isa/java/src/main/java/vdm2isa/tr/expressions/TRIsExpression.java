package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRIsExpression extends TRVDMTestExpression {

	private static final long serialVersionUID = 1L;

    public TRIsExpression(LexLocation location, TCNameToken typename, TRType basictype, TRExpression test, TRDefinition typedef)
    {
        super(location, typename, basictype, test, typedef);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.ISEXPR;
    }

    @Override
    public String translate() {
        // TODO needs to register all is_X expressions and define it? 
        return "not yet";
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseIsExpression(this, arg);
	}
}
