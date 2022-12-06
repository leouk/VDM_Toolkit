package vdm2isa.tr.templates;

import java.util.ArrayList;
import java.util.List;

/**
 * Represents an Isabelle record. This is used mostly for VDM record definitions.
 */
public class IsaRecord extends IsaNamedTemplate {

    public final List<IsaRecordField> fields; 


    protected IsaRecord(IsaIdentifier name, IsaRecordField... fields)
    {
        this(null, name, fields);
    }

    protected IsaRecord(String comment, IsaIdentifier name, IsaRecordField... fields)
    {
        super(comment, name); 
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
