/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;


import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;

import vdm2isa.tr.TRMappedList;

public class TRDefinitionList extends TRMappedList<TCDefinition, TRDefinition>
{
	private static final long serialVersionUID = 1L;
	
	public TRDefinitionList(TCDefinitionList list) throws Exception
	{
		super(list);
		separator = "\n";
		if (allAreLocalDefinition())
			setLocal(true);
	}

	public void setLocal(boolean local)
	{
		for (TRDefinition def : this)
		{
			def.local = local;
		}
	}

	public  boolean allAreLocalDefinition()
	{
		return allAre(new TRLocalDefinition());
	}

	public <T extends TRDefinition> boolean allAre(T def)
	{
		boolean result = !isEmpty(); 
		for(int i = 0; i < size(); i++)
		{
			result = result && def.getClass().isInstance(get(i));
		}
		return result;
	}
}
