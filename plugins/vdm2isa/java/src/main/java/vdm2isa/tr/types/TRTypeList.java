/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeList;

import vdm2isa.tr.TRMappedList;

public class TRTypeList extends TRMappedList<TCType, TRType>
{
	private static final long serialVersionUID = 1L;
	
	public TRTypeList(TCTypeList list) throws Exception
	{
		super(list);
	}

	public String translate()
	{
		StringBuilder sb = new StringBuilder();
 		for(TRType type : this)
		{
			sb.append(type.translate());
		}
 		return sb.toString();
	}
}
