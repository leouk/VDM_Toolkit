package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public abstract class TREnumeratedExpression extends TRExpression 
{
	private final TRExpressionList members;

	public TREnumeratedExpression(LexLocation location, TRExpressionList members)
	{
		super(location);
		this.members = members;
        this.members.separator = separator().toString();
	}

    public abstract IsaToken leftBracket();
    public abstract IsaToken rightBracket();

    public IsaToken separator()
    {
        return IsaToken.COMMA;
    }

    @Override
    public String translate() {
        members.separator = separator().toString();
        return leftBracket().toString() + members.translate() + rightBracket().toString(); 
    }

    @Override
    public IsaToken isaToken() 
    {
        return IsaToken.EOF;
    }
    

}
