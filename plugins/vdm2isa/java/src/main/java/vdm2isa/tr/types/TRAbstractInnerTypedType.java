package vdm2isa.tr.types;

import java.util.Set;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;

/**
 * General abstract class for types with inner types (e.g. optional, set, seq, named, field, function etc).
 * The inner type is supposed to be the "result" type of this type (e.g. result for function, to for maps, etc). 
 */
public abstract class TRAbstractInnerTypedType extends TRType {

	private static final long serialVersionUID = 1L;
    private final TRType type;
    
    protected TRAbstractInnerTypedType(TCType vdmType, TRDefinitionList defs, TRType type) {
        super(vdmType, defs);
        this.type = type;
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(type);
    }

    @Override
	protected String getInvTypeString()
	{
        return getInnerType().getInvTypeString();
    }

    @Override
    public Set<String> getDefLemmas()
    {
        Set<String> result = super.getDefLemmas();
        result.addAll(getInnerType().getDefLemmas());
        return result;
    }

    @Override
	public String toString()
	{
		return super.toString() + " of " + String.valueOf(getInnerType()); 
    }

    public TRType getInnerType()
    {
        return type;
    }

    // @Override 
    // public TRType ultimateType()
    // {
    //     return getInnerType().ultimateType();
    // }

    @Override
    protected void setInferredNamedForType(TCNameToken tn)
	{
		super.setInferredNamedForType(tn);
        getInnerType().setInferredNamedForType(tn);
	}

    @Override
    public String getName()
    {
        return getInnerType().getName();
    }

    @Override
    public boolean setAtTopLevelDefinition(boolean b, boolean deep)
    {
        boolean old = super.setAtTopLevelDefinition(b, deep);
        if (deep)
        {
            getInnerType().setAtTopLevelDefinition(b, deep);
        }
        return old;
    }

    @Override
    public void checkForUnionTypes() {
        if (getInnerType() instanceof TRUnionType)
        {
            report(IsaErrorMessage.ISA_INVALID_UNIONTYPE_1P, getInnerType().getClass().getSimpleName());   
        }
    }    
}
