package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRSetType extends TRType
{
    private final TRType setof;
    private final boolean empty;

    public TRSetType(LexLocation location, TRType setof, boolean empty)    
    {
        super(location);
        this.setof = setof;
        this.empty = empty;
    }

    public TRSetType(LexLocation location, TRType setof)    
    {
        this(location, setof, false);
    }

    @Override
    public IsaToken isaToken() {
        return empty ? IsaToken.SET : IsaToken.SET1;
    }
    
    @Override
    public String translate() {
        return isaToken().toString();
    }
}
