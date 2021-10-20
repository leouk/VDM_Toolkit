package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRNilExpression extends TRExpression {

	private static final long serialVersionUID = 1L;
    
    public TRNilExpression(LexLocation location)
    {
        super(location);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.NIL;
    }

    @Override
    public String translate() {
        return isaToken().toString();
    }
    
}
