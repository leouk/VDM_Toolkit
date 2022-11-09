package util;

import java.util.Iterator;
import java.util.List;

import com.fujitsu.vdmj.runtime.Context;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ValueException;
import com.fujitsu.vdmj.values.FieldMap;
import com.fujitsu.vdmj.values.FieldValue;
import com.fujitsu.vdmj.values.NameValuePair;
import com.fujitsu.vdmj.values.RecordValue;
import com.fujitsu.vdmj.values.SeqValue;
import com.fujitsu.vdmj.values.Value;
import com.fujitsu.vdmj.values.ValueFactory;
import com.fujitsu.vdmj.values.ValueList;

public class ValueFactoryHelper {
    
    public static Context initialContext()
    {
        return Interpreter.getInstance().getInitialContext();
    }

    public static Value mkString(String s)
    {
        return new SeqValue(s);
    }

    public static ValueList mkValueList(Value... values)
    {
        return new ValueList(values);
    }

    protected static boolean fieldValueCompatible(FieldMap original, FieldValue mapped)
    {
        //@NB too simplistic as the field value abstraction must also agree?
        // if field is known in the record field map
        //boolean result = original.get(mapped.name) != null;        
        
        for (FieldValue fv: original)
		{
			if (fv.name.equals(mapped.name))
			{
                // compatible if names equal and they are both comparable
                // (i.e. keep record equality abstraction intact in case of bad FieldMap)
				return (fv.comparable == mapped.comparable);
			}
		}
        return false;
    }

    protected static boolean fieldMapCompatible(FieldMap original, FieldMap mappedValues)
    {
        boolean result = original.size() >= mappedValues.size() && mappedValues.size() > 0;
        if (result)
        {
            Iterator<FieldValue> it = mappedValues.iterator();
            FieldValue fv = it.next();
            result = fieldValueCompatible(original, fv);
            while (it.hasNext() && result)
            {
                // get next field and check again
                fv = it.next();
                result = fieldValueCompatible(original, fv);
            }
            // all fields are within the map, then result = true
        }
        return result;
    }

    protected static FieldMap updateFieldMap(FieldMap original, FieldMap mappedValues)
    {
        assert fieldMapCompatible(original, mappedValues);
        FieldMap map = new FieldMap(original);
        for(FieldValue fv : mappedValues)
        {
            //@NB from my understanding of add(String, Value, Boolean), 
            //    it will update the field map's underlying value with new one?
            map.add(fv);
        }
        return map;
    }

    public static FieldMap mkFieldMap(List<String> names, ValueList values, List<Boolean> comparable, Context ctxt)
        throws ValueException 
    {
        if (names.size() == values.size() && names.size() == comparable.size())
        {
            FieldMap result = new FieldMap();
            for(int i = 0; i < names.size(); i++)
            {
                result.add(names.get(i), values.get(i), comparable.get(i));
            }
            return result;
        }
        else 
            throw new ValueException(4080, "Incompatible field map for record update", ctxt);
    }

    /**
     * @NB wanted here a "simple" mu expression on a single field, or possibly multiple fields
     *     but then it would require matching sizes and such. Or NameValuePair ... 
     *     but then that would require unwrapping/creating TCNameToken for string Field name :-(.
     * 
     * @NB wasn't sure, but also sounded that an UpdateableValue with proper invariant listener for
     *     field type invariant being checked as you update it? Wasn't sure there. 
     * @param record
     * @param fieldName
     * @param expr
     * @return
     */
    public static RecordValue muRecord(Value record, FieldMap mappedValues, Context ctxt)
        throws ValueException
    {
        //@NB complicated given changing only few fields
        //ValueFactory.mkRecord(r.type.name.getModule(), r.type.name.getName(), null)
        RecordValue r = record.recordValue(ctxt);
        RecordValue result = r; 
        if (fieldMapCompatible(r.fieldmap, mappedValues))
        {
            result = new RecordValue(r.type, updateFieldMap(r.fieldmap, mappedValues), ctxt);
        }
        else 
        {
            r.abort(4080, "Incompatible field map for record update of " + r.type.name.toString(), ctxt);
        }        
        return result;
    }
}
