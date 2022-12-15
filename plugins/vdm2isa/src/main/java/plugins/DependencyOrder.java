package plugins;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.Stack;
import java.util.concurrent.atomic.AtomicBoolean;

import java.util.Iterator;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionSet;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.tc.types.TCFunctionType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;
import com.fujitsu.vdmj.typechecker.ModuleEnvironment;
import com.fujitsu.vdmj.typechecker.NameScope;

/**
 * Heavily inspired by com.fujitsu.vdmj.util.DependencyOrder
 */
public class DependencyOrder
{
	private boolean sortCalled;
    public boolean debug;
    private final Stack<TCNameToken> stack;
    
    protected TCDefinitionList singleDefs;
    protected TCModuleList modules;
    // these might end up being TCIdentifierToken x TCNameToken dependeing on module or definition order? 
	protected final Map<TCNameToken, LexLocation> nameToLoc;
	protected final Map<TCNameToken, TCDefinitionSet> uses;
	protected final Map<TCNameToken, TCDefinitionSet> usedBy;
    protected final LexLocationComparator locationComparator;

    private final class LexLocationComparator implements Comparator<TCNameToken> 
    {
        @Override
        public int compare(TCNameToken o1, TCNameToken o2) 
        {
            assert DependencyOrder.this.nameToLoc.containsKey(o1) && DependencyOrder.this.nameToLoc.containsKey(o2);
            LexLocation l1 = DependencyOrder.this.nameToLoc.get(o1);
            LexLocation l2 = DependencyOrder.this.nameToLoc.get(o2);
            return l1.compareTo(l2);
        }
    } 
	
	public DependencyOrder(boolean debug)
	{
		this.sortCalled = false;
        this.debug = debug;
        this.singleDefs = null;
        this.modules = null;
        this.stack = new Stack<TCNameToken>();
        this.nameToLoc = new HashMap<TCNameToken, LexLocation>();
        this.uses = new HashMap<TCNameToken, TCDefinitionSet>();
        this.usedBy = new HashMap<TCNameToken, TCDefinitionSet>();
        this.locationComparator = new LexLocationComparator();
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
                d = findDefinition(dep);
                if (d instanceof TCTypeDefinition)
                {
                    invN = dep.getInvName(dep.getLocation());
                    d = findDefinition(invN);
                    if (d != null)
                    {
                        if (debug)
                        {
                            Console.out.println("Adding implicit dependency " + invN.getName());
                        }
                        // remove current dep and add invN instead
                        invDep.add(invN);
                        it.remove();
                    }
                }                
            }
            freevarsDep.addAll(invDep);
        }
    }
	
	public void definitionOrder(TCDefinitionList definitions)
	{
        modules = null;
        singleDefs = definitions.singleDefinitions();
        TCDefinitionList needsImplicitInvDef = new TCDefinitionList();
		for (TCDefinition def: singleDefs)
		{
	    	//String myname = def.name.getName();
	    	nameToLoc.put(def.name, def.location);

			TCNameSet freevars = def.getFreeVariables();

            // ignore recursive calls; recursion will be handled differently
            freevars.remove(def.name);

            Environment globals = new FlatEnvironment(new TCDefinitionList());
    		Environment empty = new FlatEnvironment(new TCDefinitionList());
			TCNameSet freevarsDep = def.getDependencies(globals, empty, new AtomicBoolean(false));

            //TLD-type definition dependencies
            processImplicitDependencies(def, freevarsDep);
            
            // see if need to add implicit type invariants
            if (def instanceof TCTypeDefinition)
            {
                TCTypeDefinition tdef = (TCTypeDefinition)def;
                TCNameToken tdefInv = tdef.name.getInvName(tdef.location);
                TCDefinition tInv = findDefinition(tdefInv); 
                if (tInv == null)
                {
                    needsImplicitInvDef.add(tdef);
                }
                else 
                {
                    freevarsDep.add(tdefInv);
                }
            } 

            // combine both dependencies
            freevars.addAll(freevarsDep);
	    	for (TCNameToken dep: freevars)
	    	{
                add(def.name, dep);
	    	}
	    }
        // update the singleDefs with the synthetic inv_T to help topological sorting 
        for(TCDefinition def : needsImplicitInvDef)
        {
            assert def instanceof TCTypeDefinition;
            
            TCTypeDefinition tdef = (TCTypeDefinition)def;
            tdef.type.getFunction();
            //TCFunctionType invDefType = tdef.type.getInvariantType()
            // T = Expr inv x == P(x)
            // inv_T: Expr +> bool 
            // inv_T(t) == true
            // new TCExplicitFunctionDefinition(null, 
            //     null, 
            //     null, 
            //     null, 
            //     null, 
            //     null, 
            //     null, 
            //     null, 
            //     null, 
            //     false, 
            //     null)
        }   
	}
	
    /**
     * Create a "dot" language version of the graph for the graphviz tool.
     * @throws IOException 
     */
    public void graphOf(File filename) throws IOException
	{
    	Map<TCNameToken, TCDefinitionSet> map = uses;
    	
		FileWriter fw = new FileWriter(filename); 
		StringBuilder sb = new StringBuilder();
		sb.append("digraph G {\n");

		for (TCNameToken key: map.keySet())
		{
			TCDefinitionSet nextSet = map.get(key);
			
			for (TCDefinition next: nextSet)
			{
				sb.append("\t");
				sb.append(key.getName());
				sb.append(" -> ");
				sb.append(next.name.getName());
				sb.append(";\n");
			}
		}
		
		sb.append("}\n");
		fw.write(sb.toString());
		fw.close();
	}
    
    public TCNameList getStartpoints()
    {
		/*
		 * The startpoints are where there are no incoming links to a node. So
		 * the usedBy entry is blank (removed cycles) or null.
		 */
		TCNameList startpoints = new TCNameList();

		for (TCNameToken name: nameToLoc.keySet())
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
    public TCNameList topologicalSort()
    {
    	return topologicalSort(getStartpoints());
    }
    
    public TCNameList topologicalSort(TCNameList startpoints)
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

        TCNameList ordering = new TCNameList();

		while (!startpoints.isEmpty())
		{
		    TCNameToken n = startpoints.remove(0);
		    ordering.add(n);
		    TCDefinitionSet usesSet = uses.get(n);
	    	
		    if (usesSet != null)
		    {
		    	TCDefinitionSet copy = new TCDefinitionSet();
                copy.addAll(usesSet);
		    	
		    	for (TCDefinition m: copy)
		    	{	
	    			if (delete(n, m.name) == 0)
			    	{
						startpoints.add(m.name);
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

    protected TCDefinition findDefinition(TCNameToken name)
    {
        // if (modules != null)
        // {
        //     assert singleDefs == null;
        //     stack.clear();
        //     stack.push(name);
        //     modules.findDefinitions(stack);
        // }
        //else 
        if (singleDefs != null) 
        {
            //assert modules == null;
            TCDefinition d = singleDefs.findName(name, NameScope.ANYTHING);
            if (d == null) 
            {
                d = singleDefs.findType(name, name.getModule());
            }
            return d;
        }
        else
             throw new IllegalStateException("Invalid dependency ordering: call moduleOrder or definitionOrder first");
    }

    protected boolean updateSet(TCDefinitionSet s, TCNameToken name, boolean add)
    {
        TCDefinition d = findDefinition(name);
        if (d != null)
        {
            if (add) 
                return s.add(d); 
            else 
                return s.remove(d);
        }
        else 
            throw new IllegalStateException("Could not find linked definition " + name.toString());
    }

	protected void add(TCNameToken from, TCNameToken to)
    {
    	if (!from.equals(to))
    	{
	    	TCDefinitionSet set = uses.get(from);
	    	
	    	if (set == null)
	    	{
	    		set = new TCDefinitionSet();
	    		uses.put(from, set);
	    	}
	    	
            updateSet(set, to, true);
    		set = usedBy.get(to);
	    	
	    	if (set == null)
	    	{
	    		set = new TCDefinitionSet();
	    		usedBy.put(to, set);
	    	}
	    	
            updateSet(set, from, true);
    	}
    }
	
	protected int delete(TCNameToken from, TCNameToken to)
	{
    	updateSet(uses.get(from), to, false);   // uses.get(from).remove(to);
        updateSet(usedBy.get(to), from, false); // usedBy.get(to).remove(from);
    	return usedBy.get(to).size();	// remaining size
	}
}
