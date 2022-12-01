package vdm2isa.tr.definitions;

import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import plugins.GeneralisaPlugin;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRMappedMap;
import vdm2isa.tr.expressions.TRApplyExpression;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRFunctionInstantiationExpression;
import vdm2isa.tr.expressions.TRVariableExpression;

/**
 * Copy of TCRecursiveLoops. Not really suitable for class mapping, given the information needed gets reset early :-()
 */
public class TRRecursiveLoops extends TRMappedMap<TCNameToken, TCDefinitionList, TCNameToken, TRDefinitionList>
{
	private static final long serialVersionUID = 1L;
	private static TRRecursiveLoops INSTANCE = null;
	
	//@NB don't think I need this for discovering the mutual recursion?
	//@NB these are calculated and put into TCApplyExpression, which would be useful if also present in TCExplicitDefs!
	//	  catch 22? either search for apply recurisve cycles visitor or have to redo what's in here? 
	//private static class Apply
	//private Map<TRDefinition, List<String>> applymap = null;

	private final TRRecursiveMap recursiveLoops;

	private TRRecursiveLoops()
	{
		super();
		this.recursiveLoops = new TRRecursiveMap();
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

	public static void reset()
	{
		if (INSTANCE != null)
		{
			INSTANCE.recursiveLoops.clear();
		}
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
			else 
			{
				GeneralisaPlugin.report(IsaErrorMessage.VDMSL_INVALID_MUTUALLY_RECURSIVE_CYCLE, root.getLocation(), root.toString());
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
}
