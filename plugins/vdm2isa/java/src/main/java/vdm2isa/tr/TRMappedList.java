/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/
package vdm2isa.tr;

import java.util.List;

import com.fujitsu.vdmj.mapper.MappedList;

public class TRMappedList<FROM, TO> extends MappedList<FROM, TO>
{
	private static final long serialVersionUID = 1L;
	
	public TRMappedList(List<FROM> from) throws Exception
	{
		super(TRNode.MAPPINGS, from);
	}
	
	public TRMappedList()
	{
		super();
	}
	
	@Override
	public boolean equals(Object other)
	{
		if (other instanceof TRMappedList)
		{
			return super.equals(other);
		}
		
		return false;
	}
}
