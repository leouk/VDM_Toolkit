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
	}

	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		Class<?> last = null;
		
		for (TRDefinition def: this)
		{
			if (last != null && def.getClass() != last) sb.append("\n");
			sb.append(def.translate());
			last = def.getClass();
		}
		
		return sb.toString();
	}
}
