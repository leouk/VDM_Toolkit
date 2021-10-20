package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRTupleExpression extends TREnumeratedExpression {
    
	private static final long serialVersionUID = 1L;

    public TRTupleExpression(LexLocation location, TRExpressionList args)
    {
        super(location, args);
    }

    @Override
    public IsaToken leftBracket() {
        return IsaToken.LPAREN;
    }

    @Override
    public IsaToken rightBracket() {
        return IsaToken.RPAREN;
    }
}
