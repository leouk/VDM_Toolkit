package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCFieldList;
import com.fujitsu.vdmj.tc.types.TCField;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRFieldList extends TRMappedList<TCField, TRField>
{
	private static final long serialVersionUID = 1L;
	
	public TRFieldList()
	{
		super();
		separator = "\n\t";
	}

	public TRFieldList(TCFieldList list) throws Exception
	{
		super(list);
		separator = "\n\t";
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

    public String invTranslate(String varName)
    {
        StringBuilder sb = new StringBuilder();

		if (!this.isEmpty())
		{
			sb.append(this.get(0).invTranslate(varName));

			for (int i = 1; i < this.size(); i++)
			{
				sb.append(" ");
                sb.append(IsaToken.AND.toString());
                sb.append("\n\t\t ");
				sb.append(this.get(i).invTranslate(varName));
			}
		}

		return sb.toString();  
    }
}