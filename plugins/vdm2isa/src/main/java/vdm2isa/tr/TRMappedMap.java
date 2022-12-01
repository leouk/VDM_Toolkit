package vdm2isa.tr;

import java.util.Map;

import com.fujitsu.vdmj.mapper.Mappable;
import com.fujitsu.vdmj.mapper.MappedMap;

abstract public class TRMappedMap<FROM_KEY extends Mappable, FROM extends Mappable,
	TO_KEY extends Mappable, TO extends Mappable> extends MappedMap<FROM_KEY, FROM, TO_KEY, TO>
	implements Mappable {

    private static final long serialVersionUID = 1L;

	public TRMappedMap(Map<FROM_KEY, FROM> from) throws Exception
	{
		super(TRNode.MAPPINGS, from);
	}
	
	public TRMappedMap()
	{
		super();
	}
	
	@Override
	public boolean equals(Object other)
	{
		if (other instanceof TRMappedMap)
		{
			return super.equals(other);
		}
		
		return false;
	}
}