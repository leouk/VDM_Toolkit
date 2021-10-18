package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;

public class TRNamedType extends TRInvariantType
{
    private final TCNameToken typename;
    private final TRType type;
    
    public TRNamedType(TCNameToken typename, TRType type)
    {
        super(typename.getLocation());
        this.typename = typename;
        this.type = type;
    }

    @Override
    public IsaToken isaToken() {
        return null;
    }

    @Override
    public String translate() {
        return typename.toString() + " = " + type.translate();
    }
}
