package plugins;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.Map;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupFile;

import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionSet;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;

public class ExuOrder extends DependencyOrder
{
    private enum ExuState { CREATED, PROCESSED, SORTED };

    private enum ExuTemplate {
        printList("list"),
        printMap("map"),
        printLocs("locs"),
        exuOrder(null),
        exuResult(null);

        public final String arg;

        private ExuTemplate(String arg) 
        {
            this.arg = arg;
        }

        @Override
        public final String toString()
        {
            return name();
        }
    }

    private final static STGroup group = new STGroupFile(ResourceUtil.loadURL("templates/exu.stg"), ResourceUtil.DEFAULT_ENCODING, '$', '$');

    final static String defListString(TCDefinitionList s) 
    {
        ST st = new ST(ExuTemplate.printList.name());
        st.add(ExuTemplate.printList.arg, s);
        return st.render();
        // StringBuilder sb = new StringBuilder();
        // Iterator<TCDefinition> it = s.iterator();
        // TCDefinition d;
        // if (it.hasNext())
        // {
        //     d = it.next();
        //     sb.append(String.format("%1$s", d.name.getName()));//d.nameScope
        // }
        // while (it.hasNext())
        // {
        //     d = it.next();
        //     sb.append(String.format(", %1$s", d.name.getName()));//d.nameScope
        // }
        // return sb.toString();
    }

    final static String defSetString(TCDefinitionSet s) 
    {
        ST st = group.getInstanceOf(ExuTemplate.printList.name());
        st.add(ExuTemplate.printList.arg, s);
        return st.render();
        // StringBuilder sb = new StringBuilder();
        // Iterator<TCDefinition> it = s.iterator();
        // TCDefinition d;
        // if (it.hasNext())
        // {
        //     d = it.next();
        //     sb.append(String.format("%1$s", d.name.getName()));//d.nameScope
        // }
        // while (it.hasNext())
        // {
        //     d = it.next();
        //     sb.append(String.format(", %1$s", d.name.getName()));//d.nameScope
        // }
        // return sb.toString();
    }

    final static String defMapString(Map<TCNameToken, TCDefinitionSet> m)
    {
        ST st = group.getInstanceOf(ExuTemplate.printMap.name());
        st.add(ExuTemplate.printMap.arg, m.entrySet());
        return st.render();
        // StringBuilder sb = new StringBuilder();
        // Iterator<TCNameToken> it = m.keySet().iterator();
        // TCNameToken d;
        // while (it.hasNext())
        // {
        //     d = it.next();
        //     sb.append(String.format("\n%1$s \t\t={%2$s}", d.getName(), defSetString(m.get(d))));
        // }
        // return sb.toString();
    }

    private TCNameList savedStartPoints;
    private TCNameList savedTopologicalSort;
    private TCDefinitionList savedModuleDefs;
    private final TCModule module;
    private ExuState state; 
    private final File saveURI;

    public ExuOrder(TCModule m, File saveURI, boolean debug)
    {
        super(m, debug);
        savedStartPoints = null;
        savedTopologicalSort = null;
        savedModuleDefs = null;
        module = m;
        this.saveURI = saveURI;
        state = ExuState.CREATED; 
    }

    private void fail()
    {
        switch (state)
        {
            case CREATED:
                throw new IllegalStateException("Exu needs to process modules first for module " + module.name.getName());
            case PROCESSED:
                throw new IllegalStateException("Exu has already processed module " + module.name.getName());
            case SORTED: 
                throw new IllegalStateException("Exu has already sorted module " + module.name.getName());
            default: 
                throw new IllegalStateException("Invalid Exu state " + state.name().toLowerCase() + " for module " + module.name.getName());
        }
    }

    public void processModule()
    {
        switch (state)
        {
            case CREATED: 
                if (debug)
                {
                    Console.out.println(String.format("Calculating declaration dependencies for module `%1$s`...", module.name.getName()));
                }
                savedModuleDefs = new TCDefinitionList();
                savedModuleDefs.addAll(module.defs);
                definitionOrder();
                if (Settings.verbose)
                {
                    Console.out.println(toString(true, false));
                }
                state = ExuState.PROCESSED;
                break;
            case PROCESSED:
            case SORTED:
                if (debug) 
                    Console.out.println("Exu has already " + state.name().toLowerCase() + " module " + module.name.getName());
                break;
            default:
                fail();
                break;
        }
    }

    protected void graphIt(String namePrefix)
    {
        // if no saveURI is set, then use the "default" 
        try 
        {
            Path dir = GeneralisaPlugin.createOutputDirectory(saveURI, "exu"); 
            String name = namePrefix + module.name.getName() + ".dot";
            File outfile = new File(dir.toFile(), name);
            graphOf(outfile);
            Console.out.println("Printed dependencies for module " + name + " at " + outfile.getPath());
        } 
        catch (IOException e) {
            Console.err.println("I/O error whilst attempting to write dependency graph for " + e.getMessage());
            //e.printStackTrace();
            
        }   
    }

    public void graphModule()
    {
        switch (state) 
        {
            case CREATED:
                fail();
                break;
            case PROCESSED: 
            case SORTED:
                graphIt("");
                break; 
            default: 
                fail();
                break;        
        }  
    }

    /**
     * Sorts the module associated with this Exu order. Null result means no sort is needed. 
     * @return the sorted list of definition names
     */
    public TCNameList sortModule()
    {
        TCNameList result;
        switch (state)
        {
            case CREATED:
                result = null;
                fail();
                break;
            case PROCESSED: 
                int outOrderCount = needsSorting();
                if (outOrderCount > 0)
                {
                    result = topologicalSort(getStartpoints()); 
                    if (debug)
                    {
                        Console.out.println("Found " + outOrderCount + " definition use before declaration. Topological sorted required.");
                        Console.out.println(toString(false, true));
                    }    
                }
                else 
                {
                    result = null;
                    if (debug) 
                        Console.out.println("No definitions sorting required for " + module.name.getName());
                }
                state = ExuState.SORTED;
                break; 
            case SORTED: 
                if (debug) 
                    Console.out.println("Exu has already " + state.name().toLowerCase() + " module " + module.name.getName());
                // if sorting wasn't needed, then savedTopologicalSort will be null  
                result = savedTopologicalSort;
                break;
            default: 
                result = null;
                fail();
                break;
        }   
        return result;
    }

    /**
     * Original module definition name order (before sorting)
     * @return
     */
    protected TCNameList getOriginalDefNames()
    {
        if (savedModuleDefs == null)
            throw new IllegalStateException("You must call processModule first for " + module.name.getName());
        TCNameList result = new TCNameList();
        for (TCDefinition d : savedModuleDefs)
        {
            result.add(d.name);
        }
        assert result.size() == savedModuleDefs.size();
        return result;
    }

    /**
     * Must include specification starting points, in case of dependencies there.
     * Later, these specification names will be removed, as they get processed 
     * separately by the vdm2isa plugin itself. 
     */
    @Override 
    public TCNameList getStartpoints()
    {
        TCNameList result = null;
        switch (state)
        {
            case CREATED:
                fail(); 
                break;
            case PROCESSED:
                // if called multiple times after processing is fine. 
                result = super.getStartpoints();
                savedStartPoints = new TCNameList();
                savedStartPoints.addAll(result);
                break;
            case SORTED: 
                // gets previously saved 
                result = savedStartPoints;
                break; 
            default:
                fail();
                break;
        }
        return result;
    }

    @Override
    public TCNameList topologicalSort(TCNameList startPoints)
    {
        TCNameList result; 
        switch (state)
        {
            case CREATED: 
                result = null;
                fail();
                break;
            case PROCESSED: 
                // if called multiple times after sorting gets the saved one. 
                if (savedTopologicalSort == null)
                {
                    result = super.topologicalSort(startPoints);
                    savedTopologicalSort = new TCNameList();
                    savedTopologicalSort.addAll(result);
                } 
                else 
                {
                    result = savedTopologicalSort;
                    if (debug)
                        Console.out.println("Exu has already called topological sort for module " + module.name.getName());
                }
                break; 
            case SORTED:    
                // if called multiple times, get the saved topological sort 
                if (savedTopologicalSort != null)
                {
                    result = savedTopologicalSort;
                }
                else 
                {
                    result = null; 
                    fail();
                }
                break;
            default:
                result = null; 
                break; 
        }        
        return result;
    }

    @Override
    public String toString()
    {
        return toString(true, this.sortCalled);
    }

    protected String toString(boolean printMaps, boolean printResult)
    {
        StringBuilder sb = new StringBuilder();
        if (printMaps)
        {
            ST st = group.getInstanceOf(ExuTemplate.exuOrder.name());
            //locs, uses, usebBy, original, start, sorted
            st.add("locs", nameToLoc.entrySet());
            st.add("uses", uses.entrySet());
            st.add("usedBy", usedBy.entrySet());
            sb.append(st.render());
            sb.append("\n");
        }
        if (printResult)
        {
            ST st = group.getInstanceOf(ExuTemplate.exuResult.name());
            st.add("original", savedModuleDefs);
            st.add("start", savedStartPoints);
            st.add("sorted", savedTopologicalSort);
            sb.append(st.render());
        }
        return sb.toString();
    }

    // private String oldToString()
    // {
    //     StringBuilder sb = new StringBuilder();
    //     sb.append("\nName locations:");
    //     for(Map.Entry<TCNameToken, LexLocation> e : nameToLoc.entrySet())
    //     {
    //         sb.append(String.format("\n%1$s \t\t@ %2$s[L%3$s,C%4$s]", e.getKey().getName(), e.getKey().getModule(), e.getValue().startLine, e.getValue().startPos));
    //     }
    //     sb.append("\n\nUses map:");
    //     sb.append(defMapString(uses));
    //     sb.append("\n\nUsed by map:");
    //     sb.append(defMapString(usedBy));
    //     sb.append("\n\nStart points :");
    //     for(TCNameToken n : getStartpoints())
    //     {
    //         sb.append(String.format("\n%1$s", n.getName()));
    //     }
    //     return sb.toString();
    // }
}