package vdm2isa.tr.definitions.templates;

import vdm2isa.tr.templates.IsaAbstractTemplate;
import vdm2isa.tr.templates.IsaIdentifier;

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
