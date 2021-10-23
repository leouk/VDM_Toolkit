package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRType;

public class TRNarrowExpression extends TRExpression {

    private final TCNameToken typename;
    private final TRType basictype; 
    private final TRExpression test;

    public TRNarrowExpression(LexLocation location, TCNameToken typename, TRType basictype, TRExpression test)
    {
        super(location);
        this.typename = typename;
        this.basictype = basictype;
        this.test = test;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String translate() {
        //System.out.println("typename = " + (typename == null ? "null" : typename.getName()));
        //System.out.println("test = " + (test == null ? "null" : test.translate()));
        //System.out.println("type = " + (basictype == null ? "null" : basictype.translate()));
        return IsaToken.parenthesise(IsaToken.parenthesise(test.translate()) + 
                    IsaToken.TYPEOF + basictype.translate()) +
               IsaToken.comment("VDM narrow expressions might create Isabelle type errors!"); 
    }
    
}
