package vdm2isa.tr.types;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

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
	private static final long serialVersionUID = 1L;

   // private final TCNameToken name;
    private final TRFieldList fields;
    private final boolean composed; 

    private static final Map<TCNameToken, TRRecordType> recordMap = new HashMap<TCNameToken, TRRecordType>(); 

    private TRRecordType(TCRecordType vdmType, TCNameToken name, TRDefinitionList definitions, TRFieldList fields, boolean composed, TRExplicitFunctionDefinition invdef, TRExplicitFunctionDefinition eqdef, TRExplicitFunctionDefinition orddef, boolean copying)
    {
        super(vdmType, name, definitions, invdef, eqdef, orddef);
        //this.name = name;
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
        if (fields.isEmpty())
        {
            report(IsaErrorMessage.ISA_NO_EMPTYRECORD_1P, String.valueOf(typename));
        }

        fields.setRecordType(this);
        TRNode.setup(fields);
        fields.setFormattingSeparator(getFormattingSeparator());

        setSemanticSeparator(IsaToken.SPACE.toString());
        setFormattingSeparator("\n\t\t");
    }

    // @Override
    // public void setAtTopLevelDefinition(boolean b)
    // {
    //     // inner type at super = to type set
    //     super.setAtTopLevelDefinition(b);
	// 	//this.fields.setAtTopLevelDefinition(b);
    // }	

    @Override
    public TRType copy(boolean atTLD)
    {
        TRType result = new TRRecordType((TCRecordType)getVDMType(), typename, definitions, fields.copy(true), composed, getInvDef(), getEqDef(), getOrdDef(), true);
        TRNode.setup(result);
        result.setAtTopLevelDefinition(atTLD);
        return result;
    }

    public static final void reset()
    {
        recordMap.clear();
    }

    @Override 
    public String invTranslate()
    {
        return this.typename != null ? invTranslate(getName()) : super.invTranslate();
    }

    @Override
    public Set<String> getDefLemmas()
    {
        Set<String> result = super.getDefLemmas();
        result.addAll(fields.getDefLemmas());
        return result;
    }

    @Override 
    protected String getInvTypeString()
    {
        // definition for a reference to record, i.e. variable of its type
        return IsaToken.INV.toString() + translate();
    }

    @Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
        if (varName == null)
        {
            sb.append(getInvTypeString());
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


    public static final TRRecordType recordTypeFor(TCNameToken recordName)
    {
        TRRecordType result = recordMap.get(recordName); 
        if (result == null)
            GeneralisaPlugin.report(IsaErrorMessage.ISA_INVALID_RECORDNAME_1P, recordName.getLocation(), recordName.toString());
        return result;
    }

    public static final TRFieldList fieldsOf(TCNameToken recordName)
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
