package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.typechecker.TCRecursiveCycles;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionListList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.tr.TRMappedMap;

public class TRRecursiveMap extends TRMappedMap<TCNameToken, TCDefinitionListList, TCNameToken, TRDefinitionListList>
{
	private static final long serialVersionUID = 1L;
	
	public TRRecursiveMap(TCRecursiveCycles from) throws Exception
	{
		super();
		throw new Exception("Not implemented yet: was passing TCRecursiveMap!");
	}

	public TRRecursiveMap()
	{
		super();
	}
}