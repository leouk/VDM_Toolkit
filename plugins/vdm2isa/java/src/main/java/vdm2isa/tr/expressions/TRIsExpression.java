package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRType;

public class TRIsExpression extends TRVDMTestExpression {

    public TRIsExpression(LexLocation location, TCNameToken typename, TRType basictype, TRExpression test)
    {
        super(location, typename, basictype, test);
    }

    @Override
    public String translate() {
        // TODO needs to register all is_X expressions and define it? 
        return "not yet";
    }
}
