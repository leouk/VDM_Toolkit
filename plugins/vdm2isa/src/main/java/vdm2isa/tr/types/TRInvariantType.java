package vdm2isa.tr.types;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCType;

public abstract class TRInvariantType extends TRType 
{
	private static final long serialVersionUID = 1L;
    
    public final TCNameToken typename;

    // those that might require implicit undeclared specification are not final
    private TRExplicitFunctionDefinition invdef;
    private TRExplicitFunctionDefinition eqdef;
    private TRExplicitFunctionDefinition orddef;
    
    public TRInvariantType(TCType  vdmType, TCNameToken typename, TRDefinitionList definitions, 
        TRExplicitFunctionDefinition invdef, 
        TRExplicitFunctionDefinition eqdef, 
        TRExplicitFunctionDefinition orddef)
    {
        super(vdmType, definitions);
        this.typename = typename;
        setInvariantDefinition(invdef);
        setEqualityDefinition(eqdef);
        setOrderingDefinition(orddef);
    }

    @Override
    protected String getInvTypeString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.INV.toString());
        sb.append(typename.toString());
        return sb.toString();
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
    public boolean hasOrderingSpecification()
    {
        return getOrdDef() != null && getEqDef() != null;
    }

    @Override
    public boolean hasSpecification()
    {
        return getOrdDef() != null || getEqDef() != null || getInvDef() != null;
    }

    @Override 
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t ");
        TRNode.setup(invdef, eqdef, orddef);
    }

    @Override
	public String getName()
	{
		return typename != null ? typename.toString() : super.getName();
	}

    @Override
    protected void setInferredNamedForType(TCNameToken tn)
	{
        // Only typename is null?
        // if (!typename.equals(tn))
        // {
        //     report(IsaErrorMessage.ISA_INVALID_NAMEDTYPE_RENAME_2P, typename, tn);
        // }
        // else
        // {
        //     // this already has a named type!
        //     super.setInferredNamedForType(typename);
        // }
        if (typename == null)
        {
            report(IsaErrorMessage.ISA_INVALID_NAMEDTYPE_RENAME_2P, "null", tn);
            super.setInferredNamedForType(tn);    
        }
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseInvariantType(this, arg);
	}

    public String translateSpecTLD()
    {
        StringBuilder sb = new StringBuilder();
        if (invdef != null)
        {
            sb.append(invdef.oldtranslate());
            sb.append(getFormattingSeparator());
            sb.append("\n");
        }

        if (eqdef == null && orddef != null || eqdef != null && orddef == null)
        {
            report(IsaErrorMessage.ISA_INVALID_INVTYP_2P, getName(), "must define both eq and ord specificaition");
        }

        if (eqdef != null)
        {
            sb.append(eqdef.oldtranslate());
            sb.append(getFormattingSeparator());
            sb.append("\n");
        }
        
        if (orddef != null)
        {
            sb.append(orddef.oldtranslate());
            sb.append(getFormattingSeparator());
            sb.append("\n");
        }

        return sb.toString();
    }

    public void checkTypeDefinitionConsistency(TRExplicitFunctionDefinition invdef2,
            TRExplicitFunctionDefinition eqdef2, TRExplicitFunctionDefinition orddef2) 
    {
        TRExplicitFunctionDefinition ef; 
        // check stuff is consistent to expectations
		if ((invdef != null && invdef2 == null) || (invdef == null && invdef2 != null))
        {
            ef = invdef != null ? invdef : invdef2; assert ef != null;
            // if implicitly generated then don't warn of course
            if (!ef.isImplicitlyGeneratedUndeclaredSpecification())
                report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_2P, getClass().getSimpleName(), "invariant");
        }
        if ((eqdef != null && eqdef2 == null) || (eqdef == null && eqdef2 != null))
        {
            ef = eqdef != null ? eqdef : eqdef2; assert ef != null;
            // if implicitly generated then don't warn of course
            if (!ef.isImplicitlyGeneratedUndeclaredSpecification())
                report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_2P, getClass().getSimpleName(), "equality");
        }
        if ((orddef != null && orddef2 == null) || (orddef == null && orddef2 != null))
        {
            ef = orddef != null ? orddef : orddef2; assert ef != null;
            // if implicitly generated then don't warn of course
            if (!ef.isImplicitlyGeneratedUndeclaredSpecification())
                report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_2P, getClass().getSimpleName(), "ordering");
        }
    }

    public static final TRExplicitFunctionDefinition getOrdDef(TRInvariantType... args)
    {
        TRExplicitFunctionDefinition result = null;
        if (args != null)
        {
            for(int i = 0; i < args.length && result == null; i++)
            {
                if (args[i] != null)
                {
                    result = args[i].getOrdDef();
                }
            }
        }
        return result;
    }

    public static final TRExplicitFunctionDefinition getEqDef(TRInvariantType... args)
    {
        TRExplicitFunctionDefinition result = null;
        if (args != null)
        {
            for(int i = 0; i < args.length && result == null; i++)
            {
                if (args[i] != null)
                {
                    result = args[i].getEqDef();
                }
            }
        }
        return result;
    }
}
