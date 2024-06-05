package vdm2isa.tr.types;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCRecordType;

import plugins.commands.IsabelleCommand;
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

    public static final Map<String, Map<TCNameToken, TRRecordType>> recordMap = new HashMap<String, Map<TCNameToken, TRRecordType>>(); 
    
    private TRRecordType(TCRecordType vdmType, TCNameToken name, TRDefinitionList definitions, TRFieldList fields, boolean composed, TRExplicitFunctionDefinition invdef, TRExplicitFunctionDefinition eqdef, TRExplicitFunctionDefinition orddef, boolean copying)
    {
        super(vdmType, name, definitions, invdef, eqdef, orddef);
        //this.name = name;
        this.fields = fields;
        this.composed = composed;
        // should this be in setup? 
        if (!copying && name != null)
            TRRecordType.addRecord(name, this);
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
    protected TRType doCopy(boolean atTLD)
    {
        TRType result = new TRRecordType((TCRecordType)getVDMType(), typename, definitions, (TRFieldList)fields.copy(true), composed, getInvDef(), getEqDef(), getOrdDef(), true);
        TRNode.setup(result);
        result.setAtTopLevelDefinition(atTLD);
        return result;
    }

    @Override 
    public String invTranslate()
    {
        return this.typename != null ? invTranslate(getName()) : super.invTranslate();
    }

    @Override
    public Set<String> doGetDefLemmas()
    {
        Set<String> result = super.doGetDefLemmas();
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

    /**
     * TLD record translation considers not only its name but it's fields too. This will be called at type and state definition time
     * @return
     */
    public String translateTypeTLD()
    {
        StringBuilder sb = new StringBuilder();

        // make sure no union types at TLD
        checkForUnionTypes();

        // translate record definition 
        sb.append(isaToken().toString());
        sb.append(IsaToken.SPACE.toString()); 
        sb.append(translate());
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.EQUALS.toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(getFormattingSeparator());
        sb.append(getFields().translate());
        sb.append(getFormattingSeparator());
        sb.append("\n");
        
        return sb.toString();
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

    /**
     * Records TRRecordType instances for field search. Has to be module-dependant to avoid duplicate names across modules confusing
     * the map keys! i.e. two TCNameTokens called Rec in two different modules might not be at the same location (and be different)!
     * @param name
     * @param r
     */
    private static final void addRecord(TCNameToken name, TRRecordType r)
    {
        assert name != null && name.getLocation() != null;
        LexLocation loc = name.getLocation();
        Map<TCNameToken, TRRecordType> rmap;
        if (recordMap.containsKey(loc.module))
        {
            rmap = recordMap.get(loc.module);
        }
        else 
        {
            rmap = new HashMap<TCNameToken, TRRecordType>();
            recordMap.put(loc.module, rmap);
        }
        rmap.put(name, r);
    }

    public static final void reset()
    {
        recordMap.clear();
    }

    public static final TRRecordType recordTypeFor(TCNameToken recordName)
    {
        Map<TCNameToken, TRRecordType> map = recordMap.get(recordName.getLocation().module);
        TRRecordType result = null; 
        if (map != null)
            result = map.get(recordName);
        if (result == null)
            IsabelleCommand.report(IsaErrorMessage.ISA_INVALID_RECORDNAME_1P, recordName.getLocation(), recordName.toString());
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
