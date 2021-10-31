package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionListList;

import vdm2isa.tr.TRMappedList;

public class TRDefinitionListList extends TRMappedList<TCDefinitionList, TRDefinitionList>
{
	private static final long serialVersionUID = 1L;
	
	protected TRDefinitionListList() 
	{
		super();
	}  

	public TRDefinitionListList(TRDefinitionListList from)
	{
		this();
		addAll(from);
	}	
	
	public TRDefinitionListList(TCDefinitionListList list) throws Exception
	{
		super(list);
	}

    //TODO maybe make this a field called once given the structure never changes?
	public TRDefinitionList getFlatDefinitionList()
	{
		TRDefinitionList result = new TRDefinitionList();
		int concSize = 0;
		if (!isEmpty())
		{
			for (TRDefinitionList plist : this)
			{
				result.addAll(plist);
				concSize += plist.size();
			}
            // set local now we have defs within; and (spurious) default separators
            result.setup();
            // set separator according to the first on this list list 
            result.setSeparator(get(0).getSeparator());
			result.setFormattingSeparator(get(0).getFormattingSeparator());
        }
		assert result.size() == concSize;	
		return result; 
	}

	public TRDefinitionListList copy()
	{
		// this one don't create from this list as we want deep copy please
		TRDefinitionListList result = new TRDefinitionListList();
		for(TRDefinitionList d : this)
		{
			result.add(d.copy());
		}
		return result; 
	}

}
