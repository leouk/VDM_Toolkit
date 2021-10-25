/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/
package vdm2isa.tr;

import java.util.List;

import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.mapper.MappedList;

public class TRMappedList<FROM, TO> extends MappedList<FROM, TO>
{
	private static final long serialVersionUID = 1L;
	
	public TRMappedList(List<FROM> from) throws Exception
	{
		//super(TRNode.MAPPINGS, from);
		super();
		// to enable debugging
		ClassMapper mapper = ClassMapper.getInstance(TRNode.MAPPINGS);	
		
		for (FROM type: from)
		{
			try
			{
				add((TO)mapper.convert(type));
			}
			catch (Throwable t)
			{
				System.out.println("Exception when creating " + from.getClass().getName());
				t.printStackTrace();
			}
		}
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
