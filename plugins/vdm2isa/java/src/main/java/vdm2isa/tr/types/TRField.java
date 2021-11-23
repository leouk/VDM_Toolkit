package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
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
        super(type.getVDMType(), null, type);
        this.tagname = tagname;
        this.equalityAbstraction = equalityAbstraction;
        this.record = null;
    }

    @Override
	public TRType copy(boolean atTLD)
	{
		TRType result = new TRField(tagname, getInnerType().copy(true), equalityAbstraction);
		result.setAtTopLevelDefinition(atTLD);
		return result;
	}

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
        return this.tagname.toString();
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
