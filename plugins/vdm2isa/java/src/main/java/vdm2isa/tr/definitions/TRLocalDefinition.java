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

    public String getDeclaredName()
    {
        return name.toString();
    }

    @Override
    public String translate()
    {
		// translate the "v: T"
		StringBuilder sb = new StringBuilder();

		// add any annotations or comments
		sb.append(super.translate());

		// get declared and invariant variable names
		String declName = getDeclaredName();

		// type string depends on TRType class
		String typeStr;
		if (type instanceof TRRecordType)
			// "v : R = mk_R(...)", the type name is the actual name, rather than the type translation 
			typeStr = ((TRRecordType)type).getName().toString();
		else
			// other types, translate it directly
			typeStr = type.translate();

		sb.append(IsaToken.parenthesise(declName + IsaToken.TYPEOF.toString() + typeStr));
		System.out.println(toString());
        return sb.toString();
    }

    @Override
    public String invTranslate()
    {
		// get declared and invariant variable names
		String declName = getDeclaredName();
		String varName = declName.toLowerCase();

		// translate the type invariant definition as inv_v definition, possibly with dummy names for lambdas
        String inType = null;
		String dummyNames = "";
        
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
            // function typed abbreviations (i.e. lambdas) need different input signature for invariant! 
            if (type instanceof TRFunctionType)
            {
                inType = ((TRFunctionType)type).parameters.translate();
                dummyNames = IsaToken.dummyVarNames(((TRFunctionType)type).parameters.size(), type.location);
            }
        }

        return IsaToken.parenthesise(invStr + " " + dummyNames);
    }
}
