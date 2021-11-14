package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRMapEnumExpression extends TRExpression 
{
	private static final long serialVersionUID = 1L;
    protected final TRMapletExpressionList members;

	public TRMapEnumExpression(LexLocation location, TRMapletExpressionList members, TRType exptype)
	{
		super(location, exptype);
        this.members = members;
	}

    @Override
    protected TRType getBestGuessType()
    {
        return members.getType();
    }
    
    public IsaToken leftBracket() {
        return IsaToken.MAP_OPEN;
    }

    public IsaToken rightBracket() {
       return IsaToken.MAP_CLOSE;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.MAP;
    }

    @Override
    public String translate() {
        return leftBracket().toString() + members.translate() + rightBracket().toString(); 
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMapEnumExpression(this, arg);
	}
}
