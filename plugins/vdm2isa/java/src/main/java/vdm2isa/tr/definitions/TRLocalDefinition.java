package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.modules.ASTModule;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRType;

/**
 * VDM local definitions are useful to give context to the translation of named types.
 */
public class TRLocalDefinition extends TRDefinition {
    
    private TCNameToken name;
    private TRType type;

    // For exclusive use of TRDefinitionList test for all being LocalDefinition. OVerkill?
    protected TRLocalDefinition()
    {
        //this(LexLocation.ANY, new TCNameToken(LexLocation.ANY, ASTModule.defaultName(LexLocation.ANY).name, "default"), null);
        this(LexLocation.ANY, null, null);
    }

    public TRLocalDefinition(LexLocation location, TCNameToken name, TRType type)
    {
        super(location, null);
        this.name = name;
        this.type = type;
        this.local = true;
        //System.out.println(toString());
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

    @Override
    public String translate()
    {
        return IsaToken.parenthesise(name.toString() + IsaToken.TYPEOF.toString() + type.translate());
    }

    @Override
    public String invTranslate()
    {
        return type.invTranslate(name.toString());
    }
}
