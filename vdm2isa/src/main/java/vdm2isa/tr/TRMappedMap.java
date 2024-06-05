package vdm2isa.tr;

import java.util.Map;

import com.fujitsu.vdmj.mapper.Mappable;
import com.fujitsu.vdmj.mapper.MappedMap;

abstract public class TRMappedMap<FROM_KEY extends Mappable, FROM extends Mappable,
	TO_KEY extends Mappable, TO extends MappableNode> extends MappedMap<FROM_KEY, FROM, TO_KEY, TO>
	implements Mappable/*Node*/ {

	//TODO for now stick to Mappable rather MappableNode implementation, as this map won't be translated directly?

    private static final long serialVersionUID = 1L;

	private boolean alreadySetup = false; 

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

	//@Override
	public void setup()
	{
		TRMappedMap.setupElements(this);
		alreadySetup = true;
	}

	//@Override 
	public final boolean setupDone()
	{
		return this.alreadySetup;
	}

	public static <FROM_KEY extends Mappable, FROM extends Mappable,
					TO_KEY extends Mappable, TO extends MappableNode> void setupElements(MappedMap<FROM_KEY, FROM, TO_KEY, TO> map)
	{
		for(TO_KEY t : map.keySet())
		{
			if (t != null && !map.get(t).setupDone()) 
				map.get(t).setup();
		}
	}
}