package vdm2isa.tr.definitions;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;
import java.util.Vector;

import com.fujitsu.vdmj.tc.TCRecursiveLoops;
import com.fujitsu.vdmj.tc.TCRecursiveMap;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.tr.TRMappedMap;
import vdm2isa.tr.expressions.TRApplyExpression;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRFunctionInstantiationExpression;
import vdm2isa.tr.expressions.TRVariableExpression;
import vdm2isa.tr.modules.TRModuleList;

/**
 * Copy of TCRecursiveLoops. Not really suitable for class mapping, given the information needed gets reset early :-()
 */
public class TRRecursiveLoops extends TRMappedMap<TCNameToken, TCDefinitionList, TCNameToken, TRDefinitionList>
{
	private static final long serialVersionUID = 1L;
	private static TRRecursiveLoops INSTANCE = null;
	private static final int LOOP_SIZE_LIMIT = 8;
	
	//@NB don't think I need this for discovering the mutual recursion?
	//@NB these are calculated and put into TCApplyExpression, which would be useful if also present in TCExplicitDefs!
	//	  catch 22? either search for apply recurisve cycles visitor or have to redo what's in here? 
	// private static class Apply
	// {
	// 	public final TRApplyExpression apply;
	// 	public final TRDefinition calling;
		
	// 	public Apply(TRApplyExpression apply, TRDefinition calling)
	// 	{
	// 		this.apply = apply;
	// 		this.calling = calling;
	// 	}

	// 	public boolean isMutuallyRecursive(TRDefinition parent, TRDefinition called)
	// 	{
	// 		TRDefinitionListList cycles = TRRecursiveLoops.getInstance().getCycles(parent.name);
	// 		return false;
	// 		// if (cycles != null)
	// 		// {
	// 		// 	List<List<String>> cycleNames = new Vector<List<String>>();
	// 		// 	recursiveCycles = new TRDefinitionListList();
	// 		// 	boolean mutuallyRecursive = false;
	
	// 		// 	for (TCDefinitionList cycle: cycles)
	// 		// 	{
	// 		// 		if (cycle.size() >= 2)
	// 		// 		{
	// 		// 			if (cycle.get(1).equals(called))	// The parent cycle involves this next apply call
	// 		// 			{
	// 		// 				recursiveCycles.add(cycle);
	// 		// 				cycleNames.add(TCRecursiveLoops.getInstance().getCycleNames(cycle));
	// 		// 				mutuallyRecursive = mutuallyRecursive || cycle.size() > 2;	// eg. [f, g, f] not [f, f]
	// 		// 				checkCycleMeasures(cycle);
	// 		// 			}
	// 		// 		}
	// 		// 	}
				
	// 		// 	if (cycleNames.isEmpty())
	// 		// 	{
	// 		// 		// No recursion via this "called" apply
	// 		// 		return;
	// 		// 	}
				
	// 		// 	if (parent instanceof TCExplicitFunctionDefinition)
	// 		// 	{
	// 		// 		TCExplicitFunctionDefinition def = (TCExplicitFunctionDefinition)parent;
	// 		// 		  def.recursive = true;
					  
	// 		// 		  if (def.measureExp == null)
	// 		// 		  {
	// 		// 			  if (mutuallyRecursive)
	// 		// 			  {
	// 		// 				  def.warning(5013, "Mutually recursive cycle has no measure");
							  
	// 		// 				  for (List<String> cycleName: cycleNames)
	// 		// 				  {
	// 		// 					  def.detail("Cycle", cycleName);
	// 		// 				  }
	// 		// 			  }
	// 		// 			  else
	// 		// 			  {
	// 		// 				  def.warning(5012, "Recursive function has no measure");
	// 		// 			  }
	// 		// 		  }
	// 		// 	}
	// 		// 	else if (parent instanceof TRImplicitFunctionDefinition)
	// 		// 	{
	// 		// 		TRImplicitFunctionDefinition def = (TRImplicitFunctionDefinition)parent;
	// 		// 		   def.recursive = true;
					 
	// 		// 		  if (def.measureExp == null)
	// 		// 		  {
	// 		// 			  if (mutuallyRecursive)
	// 		// 			  {
	// 		// 				  def.warning(5013, "Mutually recursive cycle has no measure");
							  
	// 		// 				  for (List<String> cycleName: cycleNames)
	// 		// 				  {
	// 		// 					  def.detail("Cycle", cycleName);
	// 		// 				  }
	// 		// 			  }
	// 		// 			  else
	// 		// 			  {
	// 		// 				  def.warning(5012, "Recursive function has no measure");
	// 		// 			  }
	// 		// 		  }
	// 		// 	}
	// 		// }
	// 	}
	//}
	
	private Map<TRDefinition, List<String>> applymap = null;
	private TRRecursiveMap recursiveLoops = null;

	private TRRecursiveLoops()
	{
		super();
	}

	public TRRecursiveLoops(TRRecursiveMap recursiveLoops)
	{
		this.recursiveLoops = recursiveLoops;
		INSTANCE = this;
	}

	public static TRRecursiveLoops getInstance()
	{
		if (INSTANCE == null)
		{
			INSTANCE = new TRRecursiveLoops();
		}
		
		return INSTANCE;
	}

	public void reset()
	{
		recursiveLoops = new TRRecursiveMap();
		applymap = new HashMap<TRDefinition, List<String>>();
	}
	
	public void addApplyExp(TRDefinition parent, TRApplyExpression apply, TRDefinition calling)
	{
		if (calling instanceof TRExplicitFunctionDefinition ||
			calling instanceof TRImplicitFunctionDefinition)
		{
			if (!applymap.containsKey(parent))
			{
				applymap.put(parent, new Vector<String>());
			}
			
			applymap.get(parent).add("OXENTE!");//new Apply(apply, calling));
		}
	}
		
	private Map<TCNameToken, Map<TRSpecificationKind, TCNameSet>> getCallMap()
	{
		Map<TCNameToken, Map<TRSpecificationKind, TCNameSet>> callmap = new HashMap<TCNameToken, Map<TRSpecificationKind, TCNameSet>>();
		
		for (TRDefinition def: applymap.keySet())
		{
			callmap.put(def.name, def.getCallMap());
		}
		
		return callmap;
	}
	
	public void discoverMutualRecursion(TRModuleList modules)
	{
		Map<TCNameToken, Map<TRSpecificationKind, TCNameSet>> callmap = getCallMap();
		recursiveLoops.clear();
		
		for (TCNameToken name: callmap.keySet())
		{
			for (Stack<TCNameToken> cycle: reachable(name, callmap))
			{
				addCycle(name, modules.findDefinitions(cycle));
			}
		}

		// for (TRDefinition parent: applymap.keySet())
		// {
		// 	for (Apply pair: applymap.get(parent))
		// 	{
		// 		//TODO
		// 		pair.isMutuallyRecursive(parent, pair.calling);
		// 	}
		// }
		
		//reset();	// save space!
	}

	/**
	 * Taking inspiration from a combination of TCApplyExpression.recursiveCycles (where the TCRecursiveLoops info goes),
	 * and TCApplyExpression.getRecursiveDefinition, to figure out what kind of root is being added here.
	 * @param root
	 * @param recursiveCycles
	 */
	public void addCycle(TRExpression root, TRDefinitionListList recursiveCycles)
	{
		if (recursiveCycles != null)
		{
			TCNameToken fname = null;
			
			if (root instanceof TRApplyExpression)
			{
				TRApplyExpression aexp = (TRApplyExpression)root;
				addCycle(aexp.root, aexp.recursiveCycles);
			}
			else if (root instanceof TRVariableExpression)
			{
				TRVariableExpression var = (TRVariableExpression)root;
				fname = var.name;
			}
			else if (root instanceof TRFunctionInstantiationExpression)
			{
				TRFunctionInstantiationExpression fie = (TRFunctionInstantiationExpression)root;
	
				if (fie.expdef != null)
				{
					fname = fie.expdef.name;
				}
				else if (fie.impdef != null)
				{
					fname = fie.impdef.name;
				}
			}
			
			if (fname != null)
			{
				TRDefinitionListList existing = getCycles(fname);
				
				if (existing == null)
				{
					TRDefinitionListList list = new TRDefinitionListList();
					list.addAll(recursiveCycles);
					recursiveLoops.put(fname, list);
				}
				else
				{
					existing.addAll(recursiveCycles);
				}
			}
		}
	}

	private void addCycle(TCNameToken name, TRDefinitionList defs)
	{
		if (defs != null)
		{
			TRDefinitionListList existing = getCycles(name);
			
			if (existing == null)
			{
				TRDefinitionListList list = new TRDefinitionListList();
				list.add(defs);
				recursiveLoops.put(name, list);
			}
			else
			{
				existing.add(defs);
			}
		}
	}

	public TRDefinitionListList getCycles(TCNameToken name)
	{
		return recursiveLoops.get(name);
	}
	
	public List<String> getCycleNames(TRDefinitionList cycle)
	{
		List<String> calls = new Vector<String>();

		for (TRDefinition d: cycle)
		{
			calls.add(d.name.toString());	// ie. include PP param types
		}
		
		return calls;
	}

	/**
	 * Return true if the name sought is reachable via the next set of names passed using
	 * the dependency map. The stack passed records the path taken to find a cycle.
	 */
	private Set<Stack<TCNameToken>> reachable(TCNameToken sought,
			Map<TCNameToken, Map<TRSpecificationKind, TCNameSet>> dependencies)
	{
		Stack<TCNameToken> stack = new Stack<TCNameToken>();
		Set<Stack<TCNameToken>> loops = new HashSet<Stack<TCNameToken>>();
		stack.push(sought);
		
		reachable(sought, dependencies.get(sought), dependencies, stack, loops);
		
		return loops;
	}

	private boolean reachable(TCNameToken sought, Map<TRSpecificationKind, TCNameSet> nextset_map,
		Map<TCNameToken, Map<TRSpecificationKind, TCNameSet>> dependencies, Stack<TCNameToken> stack,
		Set<Stack<TCNameToken>> loops)
	{
		if (nextset_map == null)
		{
			return false;
		}

		boolean found = false;

		//TODO discern between specification kinds?
		TCNameSet nextset = new TCNameSet();
		for (Map.Entry<TRSpecificationKind, TCNameSet> k : nextset_map.entrySet())
		{
			nextset.addAll(k.getValue());
		}

		if (nextset.contains(sought))
		{
			stack.push(sought);
			Stack<TCNameToken> loop = new Stack<TCNameToken>();
			loop.addAll(stack);
			loops.add(loop);
			stack.pop();
			found = true;
		}
		
		if (stack.size() < LOOP_SIZE_LIMIT)
		{
			for (TCNameToken nextname: nextset)
			{
				if (!stack.contains(nextname))	// Been here before!
				{
					stack.push(nextname);
					
					if (reachable(sought, dependencies.get(nextname), dependencies, stack, loops))
					{
						found = true;
					}
					
					stack.pop();
				}
			}
		}
		
		return found;
	}
}
