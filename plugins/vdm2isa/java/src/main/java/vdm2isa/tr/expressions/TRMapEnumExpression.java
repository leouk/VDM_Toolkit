package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRMapEnumExpression extends TRExpression 
{
    protected final TRMapletExpressionList members;
    
	public TRMapEnumExpression(LexLocation location, TRMapletExpressionList members)
	{
		super(location);
        this.members = members;
	}

    public IsaToken leftBracket() {
        return IsaToken.MAP_OPEN;
    }

    public IsaToken rightBracket() {
       return IsaToken.MAP_CLOSE;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String translate() {
        return leftBracket().toString() + members.translate() + rightBracket().toString(); 
    }
}
