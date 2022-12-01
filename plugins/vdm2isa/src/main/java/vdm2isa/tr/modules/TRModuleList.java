/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.modules;

import java.util.Stack;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRDefinitionList;

public class TRModuleList extends TRMappedList<TCModule, TRModule>
{
	private static final long serialVersionUID = 1L;
	
	/**
	 * Allow this top top level list to be public empty
	 */
	public TRModuleList()
	{
		super();
	}

	public TRModuleList(TRModuleList from)
	{
		this();
		addAll(from);
	}
	
	public TRModuleList(TCModuleList list) throws Exception
	{
		super(list);
	}

	public TRDefinitionList findDefinitions(Stack<TCNameToken> stack)
	{
		TRDefinitionList list = new TRDefinitionList();
		
		for (TCNameToken name: stack)
		{
			list.add(findDefinition(name));
		}
		
		return list.contains(null) ? null : list;	// Usually local func definitions
	}

	private TRDefinition findDefinition(TCNameToken sought)
	{
		for (TRModule module: this)
		{
			for (TRDefinition def: module.definitions)
			{
				if (def.name != null && def.name.equals(sought))
				{
					return def;
				}
			}
		}
		
		return null;
	}
}
