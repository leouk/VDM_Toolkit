package vdm2isa.tr.definitions.templates;

import java.util.ArrayList;
import java.util.List;

import vdm2isa.tr.templates.IsaAbstractTemplate;
import vdm2isa.tr.templates.IsaIdentifier;
import vdm2isa.tr.templates.IsaNamedTemplate;

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
