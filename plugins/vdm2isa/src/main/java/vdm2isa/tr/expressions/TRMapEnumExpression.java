package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCMapEnumExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRMapEnumExpression extends TRExpression 
{
	private static final long serialVersionUID = 1L;
    public final TRMapletExpressionList members;

	public TRMapEnumExpression(LexLocation location, TCMapEnumExpression tc, TRMapletExpressionList members, TRType exptype)
	{
		super(location, tc, exptype);
        this.members = members;
	}

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(members);
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
        return members.size() == 0 ? 
            IsaToken.MAP_EMPTY.toString() 
            : 
            leftBracket().toString() + members.translate() + rightBracket().toString(); 
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMapEnumExpression(this, arg);
	}

    public static final TRMapEnumExpression newMapEnumExpression(LexLocation location, TRMapletExpressionList members, TRType exptype)
    {
        TRMapEnumExpression result = new TRMapEnumExpression(location, 
            new TCMapEnumExpression(location, members.getVDMMapletExpressionList()), 
            members, exptype);
        TRNode.setup(result);
        return result;
    }
}
