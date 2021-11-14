package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;

public class TRSetEnumExpression extends TREnumeratedExpression 
{
	private static final long serialVersionUID = 1L;

    public TRSetEnumExpression(LexLocation location, TRExpressionList members, TRType exptype)
	{
		super(location, members, exptype);
	}

    @Override
    protected TRType getBestGuessType()
    {
        return new TRSetType(location, new TRDefinitionList(), members.getType(), !members.isEmpty());
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
    public IsaToken isaToken() {
        return IsaToken.SET;
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSetEnumExpression(this, arg);
	}
}
