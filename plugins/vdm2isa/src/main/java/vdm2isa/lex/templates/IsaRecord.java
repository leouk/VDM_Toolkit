package vdm2isa.lex.templates;

import java.util.List;

public class IsaRecord extends IsaNamedTemplate {

    public final List<IsaRecordField> field; 

    public IsaRecord(IsaIdentifier name, IsaRecordField... field)
    {
        super(name); 
        this.field = IsaAbstractTemplate.createList(field);
    }
}
