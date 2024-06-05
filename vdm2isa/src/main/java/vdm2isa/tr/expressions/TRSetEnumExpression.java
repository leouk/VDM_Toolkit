package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCSetEnumExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;

public class TRSetEnumExpression extends TREnumeratedExpression 
{
	private static final long serialVersionUID = 1L;

    public TRSetEnumExpression(LexLocation location, TCSetEnumExpression tc, TRExpressionList members, TRType exptype)
	{
		super(location, tc, members, exptype);
	}

    @Override
    protected TRType getBestGuessType()
    {
        return TRSetType.newSetType(location, exptype, !members.isEmpty());
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

    public static final TRSetEnumExpression newSetEnumExpression(LexLocation location, TRExpressionList members, TRType exptype)
    {
        TRSetEnumExpression result = new TRSetEnumExpression(location, 
            new TCSetEnumExpression(location, members.getVDMExpressionList()), 
            members, exptype);
        TRNode.setup(result);
        return result;
    }
}
