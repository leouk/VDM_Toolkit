package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCFieldList;

import java.util.Set;
import java.util.TreeSet;

import com.fujitsu.vdmj.tc.types.TCField;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;

public class TRFieldList extends TRMappedList<TCField, TRField>
{
	private static final long serialVersionUID = 1L;
	
	protected TRFieldList()
	{
		super();
	}

	public TRFieldList(TRFieldList from)
	{
		this();
		addAll(from);
	}

	public TRFieldList(TCFieldList list) throws Exception
	{
		super(list);
	}

	@Override
	public void setup()
	{
		super.setup();
		setFormattingSeparator("\n\t\t ");
		setInvTranslateSeparator(IsaToken.SPACE.toString() + IsaToken.AND.toString() + IsaToken.SPACE.toString());
	}

	@Override
	protected TRMappedList<TCField, TRField> doCopy(boolean atTLD)
	{
		TRFieldList result = new TRFieldList();
		for(TRField f : this)
		{
			TRField newf = (TRField)f.copy(true);
			result.add(newf);
		}
		TRNode.setup(result);
		result.setAtTopLevelDefinition(atTLD);
		return result;
	}
	
	public void setRecordType(TRRecordType rtype)
	{
		for (TRField f : this)
		{
			f.record = rtype;
		}
	}

	/**
	 * Returns true if any field requires equality abstraction
	 * @return
	 */
	public boolean equalityAbstraction()
	{
		boolean result = false;
		for (int i = 0; i < size() && !result; i++)
		{
			result = get(i).equalityAbstraction;
		}
		return result;
	}

    public Set<String> getDefLemmas()
    {
        TreeSet<String> result = new TreeSet<String>();
		for(TRField f : this)
		{
			result.addAll(f.getDefLemmas());
		}
        return result;
    }

    public String invTranslate(String varName)
    {
        StringBuilder sb = new StringBuilder();

		if (!this.isEmpty())
		{
			sb.append(this.get(0).invTranslate(varName));

			for (int i = 1; i < this.size(); i++)
			{
				sb.append(getInvTranslateSeparator());
				sb.append(getFormattingSeparator());
				sb.append(this.get(i).invTranslate(varName));
			}
		}

		return sb.toString();  
    }

	public void checkForUnionTypes()
	{
		for(TRField f : this)
		{
			f.checkForUnionTypes();
		}
	}

    public void setAtTopLevelDefinition(boolean b)
    {
        for(TRField f : this)
		{
			f.setAtTopLevelDefinition(b);
		}
    }	
}