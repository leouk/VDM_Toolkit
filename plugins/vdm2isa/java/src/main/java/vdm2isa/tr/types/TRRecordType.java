package vdm2isa.tr.types;

import java.util.HashMap;
import java.util.Map;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import plugins.GeneralisaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
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

    public TRRecordType(TCNameToken name, TRDefinitionList definitions, TRFieldList fields, boolean composed, TRExplicitFunctionDefinition invdef, TRExplicitFunctionDefinition eqdef, TRExplicitFunctionDefinition orddef)
    {
        super(name.getLocation(), definitions, invdef, eqdef, orddef);
        this.name = name;
        this.fields = fields;
        this.composed = composed;
        if (this.fields.size() == 0)
            report(10002, "Isabelle does not allow empty records for VDM record type " + name.toString());

        this.fields.setRecordType(this);
        this.fields.setFormattingSeparator(getFormattingSeparator());
        recordMap.put(name, this); 
    }

    // public TRType copy()
    // {
    //     return new TRRecordType(name, definitions, fields, composed, invdef, eqdef, orddef);
    // }

    public static void reset()
    {
        recordMap.clear();
    }

    @Override 
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t ");
    }

    @Override
	public String getName()
	{
		return String.valueOf(this.name);//.toString();
	}

    @Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
        if (varName != null)
        {
            // definition of the type for "inv_R x" itself
            sb.append(getFormattingSeparator());
            sb.append(IsaToken.LPAREN.toString());
            sb.append(fields.invTranslate(varName));
            sb.append(getFormattingSeparator());
            sb.append(IsaToken.RPAREN.toString());
        }
        else
        {
            // definition for a reference to record, i.e. variable of its type
            sb.append(IsaToken.INV);
            sb.append(translate());
            sb.append(" "); 
        }
        return sb.toString();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.RECORD;
    }

    @Override
    public String translate() {
        return name.toString(); 
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
}
