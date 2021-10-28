package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.ast.modules.ASTModule;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

/**
 * VDM local definitions are useful to give context to the translation of named types. 
 * Given these named types have to be translated with the same set of considerations irrespective of 
 * context, TRValueDefinition derives from TRLocalDefinition, where extra top-level considerations 
 * are added for the TLD value. This normalises the named type handling at the cost of possibly 
 * confusing/complicating the hierarchy slightly.  
 */
public class TRLocalDefinition extends TRDefinition {
    
    private TCNameToken name;
    private TRType type;

    // For exclusive use of TRDefinitionList test for all being LocalDefinition. OVerkill?
    protected TRLocalDefinition()
    {
        //this(LexLocation.ANY, new TCNameToken(LexLocation.ANY, ASTModule.defaultName(LexLocation.ANY).name, "default"), null);
        this(LexLocation.ANY, null, null, null);
    }

    public TRLocalDefinition(LexLocation location, LexCommentList comments, TCNameToken name, TRType type)
    {
        super(location, comments);
        this.name = name;
        this.type = type;
        // TRValueDefinition have patterns hence can pass name as null; it will have to change its own locality further
        this.local = name != null;
    }

    @Override
	public String toString()
	{
		return "TRLocalDef for \"" + String.valueOf(name) + "\" type = " + String.valueOf(type);
	}

    @Override
    public IsaToken isaToken()
	{
		return IsaToken.LOCAL;
	}

    protected String getDeclaredName()
    {
        // make sure it doesn't fall on null; but TRValueDefinition ought to override this method to consider its bindings!
        return String.valueOf(name);
    }

    protected String getTypeString()
    {
        // type string depends on TRType class
        String typeStr;
        if (type instanceof TRRecordType)
            // "v : R = mk_R(...)", the type name is the actual name, rather than the type translation 
            typeStr = ((TRRecordType)type).getName().toString();
        else
            // other types, translate it directly
            typeStr = type.translate();
        return typeStr;
    }

    protected String getInvariantString(String varName)
    {
        // invariant type string depends on the TRType class
		String invStr;

        if (type instanceof TRRecordType)
        {
			// records have to apply to the varName rather than use it as part of the type-inv-translate string
			invStr = type.invTranslate(null) + varName;
        }
        else
        {
            invStr = type.invTranslate(varName);
        }
        //System.out.println("getInvariantString(" + String.valueOf(varName) + ") = " + invStr);
        return invStr;
    }

    protected String dummyVarNames()
    {
        String dummyNames = "";
        if (type instanceof TRFunctionType)
        {   
            // function types require dummy names for invariant string translation
            dummyNames = IsaToken.dummyVarNames(((TRFunctionType)type).parameters.size(), type.location);
        }
        return dummyNames;
    }

    @Override
    public String translate()
    {
		// translate the "v: T"
		StringBuilder sb = new StringBuilder();

		// add any annotations or comments
		sb.append(translatePreamble());
		sb.append(IsaToken.parenthesise(getDeclaredName() + IsaToken.TYPEOF.toString() + getTypeString()));
		//System.out.println(toString());
        return sb.toString();
    }

    @Override
    public String invTranslate()
    {
		// get invariant variable name
		String varName = getDeclaredName();//.toLowerCase();
		String dummyNames = dummyVarNames();
        
        // translate the type invariant definition calss as (inv_T v), possibly with dummy names for lambdas
		return IsaToken.parenthesise(getInvariantString(varName) + (dummyNames.isEmpty() ? "" : " " + dummyNames));
    }
}
