package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.TCRecursiveMap;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionListList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.tr.TRMappedMap;

public class TRRecursiveMap extends TRMappedMap<TCNameToken, TCDefinitionListList, TCNameToken, TRDefinitionListList>
{
	private static final long serialVersionUID = 1L;
	
	public TRRecursiveMap(TCRecursiveMap from) throws Exception
	{
		super(from);
	}

	public TRRecursiveMap()
	{
		super();
	}
}