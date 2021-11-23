package vdm2isa.tr.types;

import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

import com.fujitsu.vdmj.tc.types.TCType;

public abstract class TRInvariantType extends TRType 
{
	private static final long serialVersionUID = 1L;
    // those that might require implicit undeclared specification are not final
    private TRExplicitFunctionDefinition invdef;
    private TRExplicitFunctionDefinition eqdef;
    private TRExplicitFunctionDefinition orddef;
    
    public TRInvariantType(TCType  vdmType, TRDefinitionList definitions, 
        TRExplicitFunctionDefinition invdef, 
        TRExplicitFunctionDefinition eqdef, 
        TRExplicitFunctionDefinition orddef)
    {
        super(vdmType, definitions);
        setInvariantDefinition(invdef);
        setEqualityDefinition(eqdef);
        setOrderingDefinition(orddef);
    }

    public void setInvariantDefinition(TRExplicitFunctionDefinition invdef)
    {
        this.invdef = invdef;
    }

    public void setEqualityDefinition(TRExplicitFunctionDefinition eqdef)
    {
        this.eqdef = eqdef;
    }

    public void setOrderingDefinition(TRExplicitFunctionDefinition orddef)
    {
        this.orddef = orddef;
    }

    protected TRExplicitFunctionDefinition getInvDef()
    {
        return invdef;
    }

    protected TRExplicitFunctionDefinition getEqDef()
    {
        return eqdef;
    }

    protected TRExplicitFunctionDefinition getOrdDef()
    {
        return orddef;
    }

    @Override 
    protected void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t ");
    }

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseInvariantType(this, arg);
	}

    public String translateTLD()
    {
        StringBuilder sb = new StringBuilder();
        if (invdef != null)
        {
            sb.append(invdef.translate());
            sb.append(getFormattingSeparator());
            sb.append("\n");
        }

        if (eqdef != null)
        {
            sb.append(eqdef.translate());
            sb.append(getFormattingSeparator());
            sb.append("\n");
        }
        
        if (orddef != null)
        {
            sb.append(orddef.translate());
            sb.append(getFormattingSeparator());
            sb.append("\n");
        }

        return sb.toString();
    }

    public void checkTypeDefinitionConsistency(TRExplicitFunctionDefinition invdef2,
            TRExplicitFunctionDefinition eqdef2, TRExplicitFunctionDefinition orddef2) 
    {
        // check stuff is consistent to expectations
		if ((invdef != null && invdef2 == null) || (invdef == null && invdef2 != null))
            report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_1P, "invariant");
        if ((eqdef != null && eqdef2 == null) || (eqdef == null && eqdef2 != null))
            report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_1P, "equality");
        if ((orddef != null && orddef2 == null) || (orddef == null && orddef2 != null))
            report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_1P, "ordering");
    }
}
