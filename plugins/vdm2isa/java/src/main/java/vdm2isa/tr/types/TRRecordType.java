package vdm2isa.tr.types;

import java.util.HashMap;
import java.util.Map;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCRecordType;

import plugins.GeneralisaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRRecordType extends TRInvariantType
{
	private final static long serialVersionUID = 1L;

    private final TCNameToken name;
    private final TRFieldList fields;
    private final boolean composed; 

    private final static Map<TCNameToken, TRRecordType> recordMap = new HashMap<TCNameToken, TRRecordType>(); 

    private TRRecordType(TCRecordType vdmType, TCNameToken name, TRDefinitionList definitions, TRFieldList fields, boolean composed, TRExplicitFunctionDefinition invdef, TRExplicitFunctionDefinition eqdef, TRExplicitFunctionDefinition orddef, boolean copying)
    {
        super(vdmType, definitions, invdef, eqdef, orddef);
        this.name = name;
        this.fields = fields;
        this.composed = composed;
        // should this be in setup? 
        if (!copying && name != null)
            recordMap.put(name, this); 
    }

    public TRRecordType(TCRecordType vdmType, TCNameToken name, TRDefinitionList definitions, TRFieldList fields, boolean composed, TRExplicitFunctionDefinition invdef, TRExplicitFunctionDefinition eqdef, TRExplicitFunctionDefinition orddef)
    {
        this(vdmType, name, definitions, fields, composed, invdef, eqdef, orddef, false);
    }

    @Override
    public void setup()
    {
        super.setup();
        assert fields != null;
        if (fields.size() == 0)
            report(10002, "Isabelle does not allow empty records for VDM record type " + String.valueOf(name));

        fields.setRecordType(this);
        TRNode.setup(fields);
        fields.setFormattingSeparator(getFormattingSeparator());

        setSemanticSeparator(IsaToken.SPACE.toString());
        setFormattingSeparator("\n\t\t");
    }

    @Override
    public void setAtTopLevelDefinition(boolean b)
    {
        // inner type at super = to type set
        super.setAtTopLevelDefinition(b);
		//this.fields.setAtTopLevelDefinition(b);
    }	

    @Override
    public TRType copy(boolean atTLD)
    {
        TRType result = new TRRecordType((TCRecordType)getVDMType(), name, definitions, fields/*//TODO ?fields.copy(atTLD)*/, composed, getInvDef(), getEqDef(), getOrdDef(), true);
        TRNode.setup(result);
        result.setAtTopLevelDefinition(atTLD);
        return result;
    }

    public static void reset()
    {
        recordMap.clear();
    }

    @Override
	public String getName()
	{
		return this.name != null ? this.name.toString() : super.getName();
    }

    @Override 
    public String invTranslate()
    {
        return this.name != null ? invTranslate(getName()) : super.invTranslate();
    }

    @Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
        if (varName == null)
        {
            // definition for a reference to record, i.e. variable of its type
            sb.append(IsaToken.INV.toString());
            sb.append(translate());
            sb.append(IsaToken.SPACE.toString()); 
        }
        else //if (varName != null)
        {
            // at top-level, we are getting the record itself
            if (atTopLevelDefinition())
            {
                sb.append(IsaToken.INV.toString());
                sb.append(translate());
                sb.append(getSemanticSeparator() + varName);
            }
            else
            {
                // definition of the type for "inv_R x" itself
                sb.append(getFormattingSeparator());
                sb.append(IsaToken.LPAREN.toString());
                sb.append(fields.invTranslate(varName));
                sb.append(getFormattingSeparator());
                sb.append(IsaToken.RPAREN.toString());
            }
        }
        return sb.toString();
}

    @Override
    public IsaToken isaToken() {
        return IsaToken.RECORD;
    }

    @Override
    public String translate() {
        return getName(); 
    }

    public TRFieldList getFields()
    {
        return fields;
    }

    public int fieldCount()
    {
        return fields.size();
    }

    public TRField findField(String tag)
	{
		for (TRField f: fields)
		{
			if (f.getTagName().equals(tag))
			{
				return f;
			}
		}
		return null;
	}


    public static TRRecordType recordTypeFor(TCNameToken recordName)
    {
        TRRecordType result = recordMap.get(recordName); 
        if (result == null)
            GeneralisaPlugin.report(IsaErrorMessage.ISA_INVALID_RECORDNAME_1P, recordName.getLocation(), recordName.toString());
        return result;
    }

    public static TRFieldList fieldsOf(TCNameToken recordName)
    {
        TRRecordType t = recordTypeFor(recordName); 
        TRFieldList result = null;
        if (t != null)
            result = t.fields;
        return result;
    }

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseRecordType(this, arg);
	}

    @Override
    public void checkForUnionTypes() {
        fields.checkForUnionTypes();//"fields");
    }
}
