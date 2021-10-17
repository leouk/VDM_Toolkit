package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRQuoteType extends TRType
{
    private final String value;

    public TRQuoteType(LexLocation location, String value) {
        super(location);
        this.value = value;
    }

    @Override
    public String translate() {
        return value;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.QUOTE;
    }
    
}
