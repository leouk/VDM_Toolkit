package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

/**
 * TRField has to inherit from TRType instead of TRNode (as per TCField hierarchy). That's because
 * invTranslate(String) is needed for TRFieldList and TRRecordType.
 */
public class TRField extends TRAbstractInnerTypedType {
    
	private static final long serialVersionUID = 1L;
    private final TCNameToken tagname;
    protected final boolean equalityAbstraction; 

    // the record this field belongs to; set by TRFieldList
    protected TRRecordType record;    
    
    public TRField(TCNameToken tagname, TRType type, boolean equalityAbstraction)
    {
        super(type != null ? type.getVDMType() : null, null, type);
        this.tagname = tagname;
        this.equalityAbstraction = equalityAbstraction;
        this.record = null;
    }

    // @Override
	// public void setup()
	// {
	// 	super.setup();
    //     //TRNode.setup(record);
	// }

    @Override
	public TRType copy(boolean atTLD)
	{
        TRType result = this;
        if (getInnerType() == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, getTagName(), "null type?");
        }
        else
        {
            result = new TRField(tagname, getInnerType().copy(true), equalityAbstraction);
            result.setup();
            result.setAtTopLevelDefinition(atTLD);
        }
        return result;
	}

    // @Override
    // public void setAtTopLevelDefinition(boolean b)
    // {
    //     super.setAtTopLevelDefinition(b);
    //     // checkRecordType();
    //     // if (record != null)
    //     //     record.setAtTopLevelDefinition(b);
    // }


    private void checkRecordType()
    {
        if (record == null)
            report(IsaErrorMessage.VDMSL_FIELD_MISSING_RECORDTYPE_1P, getTagName());
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.POINT;
    }

    @Override
    public String translate() {
        return getIsabelleTagName() + " " + IsaToken.TYPEOF.toString() + " " + 
            "\"" + this.getInnerType().translate() + "\"";
    }

    @Override
    public String invTranslate(String varName) {
        String fieldName = varName == null ? varName : 
            IsaToken.parenthesise(getIsabelleTagName() + " " + varName);
        return IsaToken.parenthesise(getInnerType().invTranslate(fieldName));
    }

    /**
     * Avoid other classes getting the wrong field name. Only allowed for record field search by VDM name
     * @return
     */
    public String getTagName()
    {
        return this.tagname != null ? this.tagname.toString() : super.toString();
    }

    /**
     * The Isabelle name for record field. This must be adjusted to avoid global name capture as record fields
     * lead to global (impicit) projection function declarations.
     * @return
     */
    public String getIsabelleTagName()
    {
        checkRecordType();
        return IsaTemplates.isabelleRecordFieldName(record != null ? record.getName() : "null", getTagName());
    }

    public boolean equalityAbstraction()
    {
        return this.equalityAbstraction;
    }

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseField(this, arg);
	}

    @Override
    public void checkForUnionTypes()
    {
        super.checkForUnionTypes();
        checkRecordType();
        checkForUnionTypes(record != null ? record.getName() : "record field");
    }

    public void checkForUnionTypes(String recordName) {
        if (getInnerType() instanceof TRUnionType)
        {
            report(IsaErrorMessage.ISA_INVALID_UNIONTYPE_1P, recordName, getTagName());   
        }
    }
}
