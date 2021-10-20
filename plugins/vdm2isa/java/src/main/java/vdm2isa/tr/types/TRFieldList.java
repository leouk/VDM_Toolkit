package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCFieldList;
import com.fujitsu.vdmj.tc.types.TCField;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.TRMappedList;

public class TRFieldList extends TRMappedList<TCField, TRField>
{
	private static final long serialVersionUID = 1L;
	
	public TRFieldList()
	{
		super();
	}

	public TRFieldList(TCFieldList list) throws Exception
	{
		super(list);
	}

    public String invTranslate(String varName)
    {
        return "TODO";//IsaTemplates.listToString(list, separator)
    }

	public String translate()
	{
		return IsaTemplates.listToString(this, "\n\t");
	}
}