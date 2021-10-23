package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public abstract class TREnumeratedExpression extends TRExpression 
{
	private static final long serialVersionUID = 1L;
	private final TRExpressionList members;

	public TREnumeratedExpression(LexLocation location, TRExpressionList members)
	{
		super(location);
		this.members = members;
        this.members.separator = IsaToken.COMMA.toString();
	}

    public abstract IsaToken leftBracket();
    public abstract IsaToken rightBracket();

    @Override
    public String translate() {
        return IsaToken.bracketit(leftBracket(), members.translate(), rightBracket()); 
    }

    @Override
    public IsaToken isaToken() 
    {
        return IsaToken.EOF;
    }
}
