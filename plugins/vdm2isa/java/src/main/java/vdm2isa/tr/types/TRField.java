package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRField extends TRType {
    
	private static final long serialVersionUID = 1L;
    private final TCNameToken tagname;
    private final TRType type;
    protected final boolean equalityAbstraction; 

    // the record this field belongs to; set by TRFieldList
    protected TRRecordType record;    
    
    public TRField(TCNameToken tagname, TRType type, boolean equalityAbstraction)
    {
        super(tagname.getLocation());
        this.tagname = tagname;
        this.type = type;
        this.equalityAbstraction = equalityAbstraction;
        this.record = null;
    }

    private void checkRecordType()
    {
        if (record == null)
            report(11111, "Field " + getTagName() + " does not have its record type set.");
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.POINT;
    }

    @Override
    public String translate() {
        return getIsabelleTagName() + " " + IsaToken.TYPEOF.toString() + " " + 
            "\"" + this.type.translate() + "\"";
    }

    @Override
    public String invTranslate(String varName) {
        String fieldName = varName == null ? varName : 
            IsaToken.parenthesise(getIsabelleTagName() + " " + varName);
        return IsaToken.parenthesise(type.invTranslate(fieldName));
    }

    /**
     * Avoid other classes getting the wrong field name. Only allowed for record field search by VDM name
     * @return
     */
    protected String getTagName()
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
        return IsaTemplates.isabelleRecordFieldName(record != null ? record.getName().toString() : "null", getTagName());
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
}
