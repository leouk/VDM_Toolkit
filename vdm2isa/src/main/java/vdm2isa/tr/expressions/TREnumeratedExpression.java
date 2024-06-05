package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public abstract class TREnumeratedExpression extends TRExpression 
{
	private static final long serialVersionUID = 1L;
	public final TRExpressionList members;

	public TREnumeratedExpression(LexLocation location, TCExpression tc, TRExpressionList members, TRType exptype)
	{
		super(location, tc, exptype);
		this.members = members;
	}

	@Override
	public void setup()
	{
		super.setup();
		TRNode.setup(members);
        this.members.setSemanticSeparator(IsaToken.COMMA.toString(), false);
        this.members.setFormattingSeparator(IsaToken.SPACE.toString());
	}

    public abstract IsaToken leftBracket();
    public abstract IsaToken rightBracket();

    @Override
    public String translate() {
        return IsaToken.bracketit(leftBracket(), members.translate(), rightBracket()); 
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseEnumeratedExpression(this, arg);
	}
}
