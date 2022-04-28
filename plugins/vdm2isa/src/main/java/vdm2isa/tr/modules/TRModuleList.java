/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.modules;

import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.tr.TRMappedList;

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
}
