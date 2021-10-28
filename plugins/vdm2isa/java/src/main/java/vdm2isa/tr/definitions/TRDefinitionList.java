/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.TRMappedList;

public class TRDefinitionList extends TRMappedList<TCDefinition, TRDefinition>
{
	private static final long serialVersionUID = 1L;
	
	public TRDefinitionList(TCDefinitionList list) throws Exception
	{
		super(list);
		separator = "\n";
	}

	public void setLocal(boolean local)
	{
		for (TRDefinition def : this)
		{
			def.local = local;
		}
	}
}
