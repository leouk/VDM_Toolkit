package vdm2isa.tr.types;

import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

import com.fujitsu.vdmj.lex.LexLocation;

public abstract class TRInvariantType extends TRType 
{
	private static final long serialVersionUID = 1L;
    protected final TRExplicitFunctionDefinition invdef;
    protected final TRExplicitFunctionDefinition eqdef;
    protected final TRExplicitFunctionDefinition orddef;

    public TRInvariantType(LexLocation location, TRDefinitionList definitions, 
        TRExplicitFunctionDefinition invdef, 
        TRExplicitFunctionDefinition eqdef, 
        TRExplicitFunctionDefinition orddef)
    {
        super(location, definitions);

        // make any given definitions local to the type
        this.invdef = invdef;
        if (this.invdef != null) 
            this.invdef.local = true;
        this.eqdef = eqdef;
        if (this.eqdef != null) 
            this.eqdef.local = true;
        this.orddef = orddef;
        if (this.orddef != null) 
            this.orddef.local = true;
    }

    @Override 
    protected void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t");
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
}
