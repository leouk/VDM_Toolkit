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
	
	private int currentUnionContext;

	// no extended setup() for definition list list
	protected TRDefinitionListList() 
	{
		super();
		currentUnionContext = 0;
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
	public TRUnionContext getNextUnionContext()
	{
		assert currentUnionContext >= 0 && currentUnionContext < size();
		TRUnionContext result = null; 
		if (currentUnionContext < size()-1)
		{
			currentUnionContext++;
			result = get(currentUnionContext);
		}	
		return result;
	}

	@Override
	public String unionTypesTranslate(TRExpression body, TRUnionContext innerContext)
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			currentUnionContext = 0;
			//TODO should this ever be with innerContext != null? 
			sb.append(get(0).unionTypesTranslate(body, innerContext == null ? getNextUnionContext() : innerContext));
		}
		return sb.toString();
	}
}
