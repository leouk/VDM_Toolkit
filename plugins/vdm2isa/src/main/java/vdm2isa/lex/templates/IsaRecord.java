package vdm2isa.lex.templates;

import java.util.ArrayList;
import java.util.List;

public class IsaRecord extends IsaNamedTemplate {

    public final List<IsaRecordField> fields; 

    public IsaRecord(IsaIdentifier name, IsaRecordField... fields)
    {
        super(name); 
        this.fields = IsaAbstractTemplate.createList(fields);
    }

    public final List<String> getFieldName()
    {
        List<String> result = new ArrayList<String>();
        for(IsaRecordField f : fields)
        {
            result.add(f.name.toString());
        }
        return result;
    }

    public final List<String> getFieldType()
    {
        List<String> result = new ArrayList<String>();
        for(IsaRecordField f : fields)
        {
            result.add(f.type.toString());
        }
        return result;
    }
}
