package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public abstract class TREnumeratedExpression extends TRExpression 
{
	private static final long serialVersionUID = 1L;
	protected final TRExpressionList members;

	public TREnumeratedExpression(LexLocation location, TRExpressionList members, TRType exptype)
	{
		super(location, exptype);
		this.members = members;
	}

	@Override
	public void setup()
	{
		super.setup();
		TRNode.setup(members);
        this.members.setSemanticSeparator(IsaToken.COMMA.toString());
        this.members.setFormattingSeparator(" ");
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
