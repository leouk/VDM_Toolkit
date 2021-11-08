package vdm2isa.tr.types;

import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

import com.fujitsu.vdmj.lex.LexLocation;

public abstract class TRInvariantType extends TRType 
{
	private static final long serialVersionUID = 1L;
    public final TRExplicitFunctionDefinition invdef;
    public final TRExplicitFunctionDefinition eqdef;
    public final TRExplicitFunctionDefinition orddef;

    public TRInvariantType(LexLocation location, TRExplicitFunctionDefinition invdef, TRExplicitFunctionDefinition eqdef, TRExplicitFunctionDefinition orddef)
    {
        super(location);
        this.invdef = invdef;
        this.eqdef = eqdef;
        this.orddef = orddef;
    }

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseInvariantType(this, arg);
	}
}
