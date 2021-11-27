package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionListList;

import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRUnionContext;

public class TRDefinitionListList extends TRMappedList<TCDefinitionList, TRDefinitionList> implements TRUnionContext
{
	private static final long serialVersionUID = 1L;
	
	// no extended setup() for definition list list
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

	@Override
	public String toString()
	{
		return getFlatDefinitionList().toString();
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
            TRNode.setup(result);
            // set separator according to the first on this list list 
            //result.setSemanticSeparator(get(0).getSemanticSeparator());
			result.setFormattingSeparator(get(0).getFormattingSeparator());
        }
		assert result.size() == concSize;	
		TRNode.setup(result);
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
		TRNode.setup(result);
		return result; 
	}

	@Override
	public boolean hasUnionTypes() 
	{
        boolean result = false;
		for(int i = 0; i < size() && !result; i++)
		{
			result = get(i).hasUnionTypes();
		}
		return result;		
    }

	@Override
	public String unionTypesTranslate(TRExpression body)
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			// set the case projection
			String unionTranslate = get(0).unionTypesTranslate(body); 
			sb.append(unionTranslate);
			for (int i = 1; i < size(); i++)
			{
				if (!unionTranslate.isEmpty())
				{
					sb.append(getFormattingSeparator());
				}
				unionTranslate = get(i).unionTypesTranslate(body);
				sb.append(unionTranslate);
			}
		}
		return sb.toString();
	}



}
