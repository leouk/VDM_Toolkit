package vdm2isa.tr.types;

import java.util.HashMap;
import java.util.Map;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import vdm2isa.lex.IsaToken;

public class TRRecordType extends TRInvariantType
{
	private final static long serialVersionUID = 1L;

    private final TCNameToken name;
    private final TRFieldList fields;
    private final boolean composed; 

    private final static Map<TCNameToken, TRFieldList> recordMap = new HashMap<TCNameToken, TRFieldList>(); 

    public TRRecordType(TCNameToken name, TRFieldList fields, boolean composed)
    {
        super(name.getLocation());
        this.name = name;
        //@todo collect field's abstraction to see how to compare equals
        this.fields = fields;
        if (this.fields.size() == 0)
            report(10002, "Isabelle does not allow empty records for VDM record type " + name.toString());
        this.composed = composed;
        recordMap.put(name, fields); 
    }

    public static void reset()
    {
        recordMap.clear();
    }

    @Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
        if (varName != null)
        {
            // definition of the type for "inv_R x" itself
            sb.append("\n\t\t");
            sb.append(IsaToken.LPAREN.toString());
            //sb.append(IsaToken.INV.toString());
            //sb.append(name.toString());
            sb.append(fields.invTranslate(varName));
            sb.append("\n\t\t");
            sb.append(IsaToken.RPAREN.toString());
        }
        else
        {
            // definition for a reference to record, i.e. variable of its type
            sb.append(IsaToken.INV);
            sb.append(name.toString());
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
        StringBuilder sb = new StringBuilder();
        sb.append(isaToken().toString() + " "); 
        sb.append(name.toString() + " = \n\t");
        sb.append(fields.translate() + "\n\n");
        return sb.toString(); 
    }

    public TCNameToken getName()
    {
        return this.name;
    }

    public TRField findField(String tag)
	{
		for (TRField f: fields)
		{
			if (f.tagname.getName().equals(tag))
			{
				return f;
			}
		}
		return null;
	}

    public static TRFieldList fieldsOf(TCNameToken recordName)
    {
        return recordMap.get(recordName);
    }
}