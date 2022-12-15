package plugins;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;
import java.util.Vector;
import java.util.concurrent.atomic.AtomicBoolean;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.definitions.TCClassDefinition;
import com.fujitsu.vdmj.tc.definitions.TCClassList;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionSet;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCImportFromModule;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;
import com.fujitsu.vdmj.typechecker.NameScope;

/**
 * Heavily inspired by com.fujitsu.vdmj.util.DependencyOrder
 */
public class DependencyOrder
{
	private boolean sortCalled;
    private TCDefinitionList singleDefs;
    private TCModuleList modules;
    private final Stack<TCNameToken> stack;
	private final Map<String, LexLocation> nameToLoc;
	private final Map<TCNameToken, TCDefinitionSet> uses;
	private final Map<TCNameToken, TCDefinitionSet> usedBy;
    private final LexLocationComparator locationComparator;

    private final class LexLocationComparator implements Comparator<String> 
    {
        @Override
        public int compare(String o1, String o2) 
        {
            assert DependencyOrder.this.nameToLoc.containsKey(o1) && DependencyOrder.this.nameToLoc.containsKey(o2);
            LexLocation l1 = DependencyOrder.this.nameToLoc.get(o1);
            LexLocation l2 = DependencyOrder.this.nameToLoc.get(o2);
            return l1.compareTo(l2);
        }
    } 
	
	public DependencyOrder()
	{
		sortCalled = false;
        singleDefs = null;
        modules = null;
        stack = new Stack<TCNameToken>();
        nameToLoc = new HashMap<String, LexLocation>();
        uses = new HashMap<TCNameToken, TCDefinitionSet>();
        usedBy = new HashMap<TCNameToken, TCDefinitionSet>();
        locationComparator = new LexLocationComparator();
	}

	// public void moduleOrder(TCModuleList moduleList)
    // {
    //     modules = moduleList;
    //     singleDefs = null;
	// 	for (TCModule m: modules)
	// 	{
    //         TCNameToken t;
	//     	String myname = m.name.getName();
	//     	nameToLoc.put(myname, m.name.getLocation());
			
	// 		if (m.imports != null)
	// 		{
	// 	    	for (TCImportFromModule ifm: m.imports.imports)
	// 	    	{
    //                 add(myname, ifm.name.getName());
	// 	    	}
	// 		}
	// 		else
	// 		{
	// 			uses.put(myname, new TCDefinitionSet());
	// 		}
	//     }
    // }

    private void processImplicitDependencies(TCDefinition def, TCNameSet freevarsDep)
    {
        // for named types, chase dependent invariants
        if (!freevarsDep.isEmpty())
        {
            if (debug)
            {
                Console.out.println(def.name.getName() + " dep on " + freevarsDep.toString());
            }
            TCDefinition d;
            TCNameSet invDep = new TCNameSet();
            TCNameToken invN;
            TCNameToken dep;
            Iterator<TCNameToken> it = freevarsDep.iterator();
            while (it.hasNext())
            {
                dep = it.next();
                d =
            }
            // for(TCNameToken dep: freevarsDep)
            // {
            //     d = findDefinition(dep);
            //     if (d instanceof TCTypeDefinition)
            //     {
            //         invN = dep.getInvName(dep.getLocation());
            //         d = findDefinition(invN);
            //         if (d != null)
            //         {
            //             if (debug)
            //             {
            //                 Console.out.println("Adding implicit dependency " + invN.getName());
            //             }
            //             invDep.add(dep);
            //         }
            //     }
            // }
            // for(TCNameToken dep: invDep)
            // {
            //     freevarsDep.remove(dep);
            //     freevarsDep.add(dep.getInvName(dep.getLocation()));
            // }
        }
    }
	
	public void definitionOrder(TCDefinitionList definitions)
	{
        modules = null;
        singleDefs = definitions.singleDefinitions();
		for (TCDefinition def: singleDefs)
		{
	    	String myname = def.name.getName();
	    	nameToLoc.put(myname, def.location);

			TCNameSet freevars = def.getFreeVariables();
	    	
	    	for (TCNameToken dep: freevars)
	    	{
                add(myname, dep.getName());
	    	}
	    }		
	}
	
    /**
     * Create a "dot" language version of the graph for the graphviz tool.
     * @throws IOException 
     */
    public void graphOf(File filename) throws IOException
	{
    	Map<String, TCDefinitionSet> map = uses;
    	
		FileWriter fw = new FileWriter(filename); 
		StringBuilder sb = new StringBuilder();
		sb.append("digraph G {\n");

		for (String key: map.keySet())
		{
			TCDefinitionSet nextSet = map.get(key);
			
			for (TCDefinition next: nextSet)
			{
				sb.append("\t");
				sb.append(key);
				sb.append(" -> ");
				sb.append(next.name.getName());
				sb.append(";\n");
			}
		}
		
		sb.append("}\n");
		fw.write(sb.toString());
		fw.close();
	}
    
    public List<String> getStartpoints()
    {
		/*
		 * The startpoints are where there are no incoming links to a node. So
		 * the usedBy entry is blank (removed cycles) or null.
		 */
		List<String> startpoints = new Vector<String>();

		for (String name: nameToLoc.keySet())
		{
			if (usedBy.get(name) == null || usedBy.get(name).isEmpty())
			{
				startpoints.add(name);
				usedBy.put(name, new TCDefinitionSet());
			}
		}
        startpoints.sort(locationComparator);

		return startpoints;
    }
    
    /**
     * Note that the graph must be acyclic!
     * @return the initialization order of the names
     */
    public List<String> topologicalSort()
    {
    	return topologicalSort(getStartpoints());
    }
    
    public List<String> topologicalSort(List<String> startpoints)
    {
    	if (sortCalled)
    	{
    		throw new IllegalStateException("topologicalSort already called");
    	}
    	
		//	See https://en.wikipedia.org/wiki/Topological_sorting#Kahn's_algorithm
		//
		//	L <- Empty list that will contain the sorted elements
		//	S <- Set of all nodes with no incoming edge
		//
		//	while S is not empty do
		//	    remove a node n from S
		//	    add n to L
		//	    for each node m with an edge e from n to m do
		//	        remove edge e from the graph
		//	        if m has no other incoming edges then
		//	            insert m into S
		//
		//	if graph has edges then
		//	    return error   (graph has at least one cycle)
		//	else 
		//	    return L   (a topologically sorted order)

		List<String> ordering = new Vector<String>();

		while (!startpoints.isEmpty())
		{
		    String n = startpoints.remove(0);
		    ordering.add(n);
		    TCDefinitionSet usesSet = uses.get(n);
	    	
		    if (usesSet != null)
		    {
		    	TCDefinitionSet copy = new TCDefinitionSet();
                copy.addAll(usesSet);
		    	
		    	for (TCDefinition m: copy)
		    	{	
	    			if (delete(n, m.name.getName()) == 0)
			    	{
						startpoints.add(m.name.getName());
				    }
		    	}
		    }
		}
		
		if (edgeCount() > 0)
		{
			throw new IllegalStateException("Dependency graph has cycles");
		}
		else
		{
			Collections.reverse(ordering);	// the init order
			sortCalled = true;
			return ordering;
		}
    }

	private int edgeCount()
	{
		int count = 0;
		
		for (TCDefinitionSet set: uses.values())
		{
			count += set.size();
		}
		
		for (TCDefinitionSet set: usedBy.values())
		{
			count += set.size();	// include reverse links too?
		}
		
		return count;
	}

    protected void addToDefSet(TCDefinitionSet s, String name)
    {
        if (modules != null)
        {
            assert singleDefs == null;
            stack.clear();
            stack.push(name);
            modules.findDefinitions(stack);
        }
        else if (singleDefs != null) 
        {
            assert modules == null;
            singleDefs.findName(name, NameScope.ANYTHING);
        }
        else
            throw new IllegalStateException("Invalid dependency ordering: call moduleOrder or definitionOrder first");
    }

	protected void add(String from, String to)
    {
    	if (!from.equals(to))
    	{
	    	TCDefinitionSet set = uses.get(from);
	    	
	    	if (set == null)
	    	{
	    		set = new TCDefinitionSet();
	    		uses.put(from, set);
	    	}
	    	
            addToDefSet(set, to);
    		set = usedBy.get(to);
	    	
	    	if (set == null)
	    	{
	    		set = new TCDefinitionSet();
	    		usedBy.put(to, set);
	    	}
	    	
            addToDefSet(set, from);
    	}
    }
	
	protected int delete(String from, String to)
	{
    	uses.get(from).remove(to);
    	usedBy.get(to).remove(from);
    	return usedBy.get(to).size();	// remaining size
	}
}
