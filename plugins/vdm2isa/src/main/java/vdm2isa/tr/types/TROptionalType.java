package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCOptionalType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TROptionalType extends TRAbstractInnerTypedType implements TRDataType {
    private static final long serialVersionUID = 1L;

    private TRTypeSet dataTypeConstructors;
    
    public TROptionalType(TCOptionalType vdmType, TRDefinitionList definitions, TRType type)
    {
        super(vdmType, definitions, type);
        dataTypeConstructors = null;
    }

    @Override
    public void setup()
    {
        super.setup();
        this.dataTypeConstructors = new TRTypeSet(TRTokenType.newTokenType(location, new TRTypeSet(getInnerType())), getInnerType());
        TRNode.setup(dataTypeConstructors);
    }

    @Override
	public TRType copy(boolean atTLD)
	{
        TRType result = this;
        if (getInnerType() == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "optional type", "null type?");
        }
        else
        {
            result = new TROptionalType((TCOptionalType)getVDMType(), definitions, getInnerType().copy(true));
            TRNode.setup(result);
            result.setAtTopLevelDefinition(atTLD);    
        }
		return result;
	}

    @Override
    public boolean setAtTopLevelDefinition(boolean b, boolean deep)
    {
        boolean old = super.setAtTopLevelDefinition(b, deep);
        if (deep)
        {
            this.dataTypeConstructors.setAtTopLevelDefinition(b, deep);
        }
        return old;
    }

    @Override 
    protected void setInferredNamedForType(TCNameToken tn)
    {
        super.setInferredNamedForType(tn);
        this.dataTypeConstructors.setInferredNamedForType(tn);
    }

    // @Override
    // public String setSemanticSeparator(String sep)
    // {
    //     return super.setSemanticSeparator(sep);
    // }

    @Override
	protected String getInvTypeString()
	{
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.INV.toString());
        // transform "option" => "Option" for inv_Option call
        int i = sb.length();
        sb.append(isaToken().toString());
        sb.setCharAt(i, Character.toUpperCase(sb.charAt(i)));
        return sb.toString();
    }

    @Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
        sb.append(getInvTypeString());
        // make sure we get the inv check without var name (e.g. inv_VDMNat1 instea of inv_VDMNat1 x)
        sb.append(IsaToken.SPACE.toString());
        sb.append(getInnerType().invTranslate(null));
        if (varName != null)
        {
            sb.append(getSemanticSeparator());
            sb.append(varName);
        }
        return IsaToken.parenthesise(sb.toString());
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.OPTIONAL;
    }

    @Override
    public String translate() {
        return getInnerType().translate() + getSemanticSeparator() + isaToken().toString();
    }

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseOptionalType(this, arg);
	}

    @Override
    public boolean isNumericType() {
        return false;
    }

    @Override
	public boolean isOrdered()
	{
		return getInnerType().isOrdered();
	}

    @Override
	public boolean isDataType()
	{
		return true;
	}

	@Override
	public boolean isUnion()
	{
		return true;
	}
	
    // @Override 
    // public String getName()
    // {
    //     return this.type.getName() + " option";
    // }

    public static final TROptionalType newOptionalType(TRType type)
    {
        TROptionalType result = new TROptionalType(new TCOptionalType(type.getLocation(), type.getVDMType()), type.getDefinitions(), type);
        TRNode.setup(result);
        return result;
    }

    @Override
    public TRTypeSet getDataTypeConstructors() {
        return dataTypeConstructors; 
    }

    @Override
    public boolean isEnumerated()
    {
        return false;//dataTypeConstructors.isEnumerated();
    }
}
