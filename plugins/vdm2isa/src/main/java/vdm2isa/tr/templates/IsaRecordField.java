package vdm2isa.tr.templates;

/**
 * Represents an Isabelle record field. This is used for VDM record fields.
 */
public class IsaRecordField extends IsaAbstractTemplate {
    
    public final IsaIdentifier name; 
    public final String type; 

    public IsaRecordField(IsaIdentifier name, String type)
    {
        this.name = name;
        this.type = type;
    }

    public static final IsaRecordField valueOf(String name, String type) 
    {
        return new IsaRecordField(IsaIdentifier.valueOf(name), type);
    }
}
