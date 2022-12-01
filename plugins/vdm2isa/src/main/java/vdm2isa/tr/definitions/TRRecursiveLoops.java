package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.tr.TRMappedMap;

public class TRRecursiveLoops extends TRMappedMap<TCNameToken, TRDefinitionList, TCNameToken, TRDefinitionList>
{
	private static final long serialVersionUID = 1L;
	private static TRRecursiveLoops INSTANCE = null;
	private TRRecursiveMap recursiveLoops = null;
	
	public TRRecursiveLoops(TRRecursiveMap recursiveLoops)
	{
		this.recursiveLoops = recursiveLoops;
		INSTANCE = this;
	}

	public static TRRecursiveLoops getInstance()
	{
		return INSTANCE;
	}

	public TRDefinitionListList get(TCNameToken name)
	{
		return recursiveLoops.get(name);
	}
}
// public class TRRecursiveLoops extends TCRecursiveLoops {

//     public void typeCheck(TCModuleList modules)
// 	{
// 		Map<TCNameToken, TCNameSet> callmap = getCallMap();
// 		recursiveLoops.clear();
		
// 		for (TCNameToken name: callmap.keySet())
// 		{
// 			for (Stack<TCNameToken> cycle: reachable(name, callmap))
// 			{
// 				addCycle(name, modules.findDefinitions(cycle));
// 			}
// 		}

// 		for (TCDefinition parent: applymap.keySet())
// 		{
// 			for (Apply pair: applymap.get(parent))
// 			{
// 				pair.apply.typeCheckCycles(parent, pair.calling);
// 			}
// 		}
		
// 		reset();	// save space!
// 	}
// }
