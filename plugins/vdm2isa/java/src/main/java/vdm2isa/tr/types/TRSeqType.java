package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRSeqType extends TRType
{
    private final TRType seqof;

    public TRSeqType(LexLocation location, TRType seqof)    
    {
        super(location);
        this.seqof = seqof;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.SEQ;
    }

    @Override
    public String translate() {
        return isaToken().toString();
    }
}
