package vdm2isa.tr.types;

import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;

import com.fujitsu.vdmj.lex.LexLocation;

public abstract class TRInvariantType extends TRType 
{
    protected TRExplicitFunctionDefinition invdef = null;
    protected TRExplicitFunctionDefinition eqdef  = null;
    protected TRExplicitFunctionDefinition orddef = null;

    public TRInvariantType(LexLocation location)
    {
        super(location);
    }
}
