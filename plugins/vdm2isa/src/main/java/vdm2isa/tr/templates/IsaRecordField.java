package vdm2isa.tr.templates;

import com.fujitsu.vdmj.lex.LexLocation;

/**
 * Represents an Isabelle record field. This is used for VDM record fields.
 */
public class IsaRecordField extends IsaAbstractTemplate {
    
    public final IsaIdentifier name; 
    public final String type; 

    protected IsaRecordField(IsaIdentifier name, String type)
    {
        super(null);
        this.name = name;
        this.type = type;
    }

    public static final IsaRecordField valueOf(LexLocation location, String name, String type) 
    {
        return new IsaRecordField(IsaIdentifier.valueOf(location, name), type);
    }
}
