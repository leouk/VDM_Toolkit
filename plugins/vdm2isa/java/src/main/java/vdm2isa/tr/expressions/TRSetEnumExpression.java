package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRSetEnumExpression extends TREnumeratedExpression 
{
	public TRSetEnumExpression(LexLocation location, TRExpressionList members)
	{
		super(location, members);
	}

    @Override
    public IsaToken leftBracket() {
        return IsaToken.SEQ_OPEN;
    }

    @Override
    public IsaToken rightBracket() {
       return IsaToken.SEQ_CLOSE;
    }
}
