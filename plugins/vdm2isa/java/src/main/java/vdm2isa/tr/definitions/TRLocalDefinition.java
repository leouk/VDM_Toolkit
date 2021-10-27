package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.tr.types.TRType;

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
        warning(11111, "Local definitions ought not be translated!");
        return "LOCAL = " + name.toString() + " : " + type.translate();
    }
}
