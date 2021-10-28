package vdm2isa.tr.definitions;

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

    public TRLocalDefinition(LexLocation location, TCNameToken name, TRType type)
    {
        super(location, null);
        this.name = name;
        this.type = type;
    }

    public String translate()
    {
        return IsaToken.parenthesise(name.toString() + IsaToken.TYPEOF.toString() + type.translate());
    }

    public String invTranslate()
    {
        return type.invTranslate(name.toString());
    }
}
