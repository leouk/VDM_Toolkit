package util;

import java.util.Iterator;
import java.util.List;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.runtime.Context;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.runtime.ValueException;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCNamedType;
import com.fujitsu.vdmj.tc.types.TCRecordType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.values.FieldMap;
import com.fujitsu.vdmj.values.FieldValue;
import com.fujitsu.vdmj.values.InvariantValue;
import com.fujitsu.vdmj.values.RecordValue;
import com.fujitsu.vdmj.values.SeqValue;
import com.fujitsu.vdmj.values.SetValue;
import com.fujitsu.vdmj.values.UpdatableValue;
import com.fujitsu.vdmj.values.Value;
import com.fujitsu.vdmj.values.ValueList;
import com.fujitsu.vdmj.values.ValueSet;

public class ValueFactoryHelper {
    
    public static Context initialContext()
    {
        return Interpreter.getInstance().getInitialContext();
    }

    public static Value mkString(String s)
    {
        return new SeqValue(s);
    }

    public static Value mkEmptySeqValue()
    {
        //@NB ValueFactory.mkSeqValue(null) would fail?
        //return new ValueFactory.mkSeqValue(ValueFactoryHelper.mkValueList(null)));
        return new SeqValue();
    }

    /**
     * UpdatableValues come in as parameters to native calls (@NB?).
     * This gets the underlying reference if an updatable or else just
     * the value given. 
     * @param value
     * @return
     */
    public static Value deref(Value value)
    {
        return (value instanceof UpdatableValue) ?
            ((UpdatableValue)value).deref() : value;           
    }

    //@NB result of seqValue as SeqValue instead of ValueList?
    public static SeqValue seqValue(Value v, Context ctxt)
        throws ValueException
    {
        //return ValueFactory.mkSeq(v.seqValue(ctxt));
        return new SeqValue(v.seqValue(ctxt));
    }

    public static Value mkSeq(ValueList values)
    {
        return new SeqValue(values);
    }

    public static Value mkSet(ValueSet values)
    {
        return new SetValue(values);
    }

    public static Value mkEmptySetValue()
    {
        return new SetValue();
    }

    public static ValueList mkValueList(Value... values)
    {
        // guards against empty list problem
        return values == null ? new ValueList() : new ValueList(values);
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

    /**
     * VDMJ ValueFactory.getType seems to impose that a natively required type (e.g. CSVLib`Error) *must* be part of the 
     * imported definitions of where it's used (e.g. CSVExample`loadCSV). Given the module name on the native call (CSVLib)
     * is loaded, I think this is too strict a requirement? If module name is available, choose that, instead of default one.
     * 
     * Both mkRecord and mkInvariant are the save as ValueFactory, only getType differs. 
     * @param module
     * @param name
     * @param args
     * @return
     * @throws ValueException
     */
    public static RecordValue mkRecord(String module, String name, Value ...args) throws ValueException
	{
		TCType type = getType(module, name);
		
		if (type instanceof TCRecordType)
		{
    		TCRecordType r = (TCRecordType)type;
    		ValueList l = new ValueList();
    		
    		for (int a=0; a<args.length; a++)
    		{
    			l.add(args[a]);
    		}
    		
    		return new RecordValue(r, l, Interpreter.getInstance().getInitialContext());
		}
		else
		{
			throw new ValueException(69, "Definition " + module + "`" + name +
				" is " + type.getClass().getSimpleName() + " not TCRecordType", Context.javaContext());
		}
	}

	public static InvariantValue mkInvariant(String module, String name, Value x) throws ValueException
	{
		TCType type = getType(module, name);
		
		if (type instanceof TCNamedType)
		{
			TCNamedType r = (TCNamedType)type;
			return new InvariantValue(r, x, Interpreter.getInstance().getInitialContext());
		}
		else
		{
			throw new ValueException(69, "Definition " + module + "`" + name +
				" is " + type.getClass().getSimpleName() + " not TCNamedType", Context.javaContext());
		}
	}
    
    private static TCType getType(String module, String name) throws ValueException
	{
		Interpreter i = Interpreter.getInstance();
        Environment env = i.getGlobalEnvironment();
		TCNameToken tcname = new TCNameToken(LexLocation.ANY, module, name);

        TCDefinition def = env.findType(tcname, i.getDefaultName());
		
		if (def == null)
		{
            // attempt the given module as well as the one set to default! 
            ModuleInterpreter mi = (ModuleInterpreter)i;
            try
            {
                mi.setDefaultName(module);
            } catch (Exception e)
            {
                // ignore; couldn't change module; fintType will fail
            }
            env = mi.getGlobalEnvironment();
            def = env.findType(tcname, module);		

            if (def == null)
            {
               throw new ValueException(70, "Definition " + tcname.getExplicit(true) + " not found", Context.javaContext());
            }
		}
		return def.getType();
	}

}
