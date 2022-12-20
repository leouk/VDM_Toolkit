package plugins;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupFile;

import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionSet;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;

public class ExuOrder extends DependencyOrder
{
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

    private final static STGroup group = new STGroupFile(ExuOrder.class.getResource("/templates/exu.stg"), "UTF-8", '$', '$');

    final static String defListString(TCDefinitionList s) 
    {
        // ST st = new ST(ExuTemplate.printList.name());
        // st.add(ExuTemplate.printList.arg, s);
        // return st.render();
        StringBuilder sb = new StringBuilder();
        Iterator<TCDefinition> it = s.iterator();
        TCDefinition d;
        if (it.hasNext())
        {
            d = it.next();
            sb.append(String.format("%1$s", d.name.getName()));//d.nameScope
        }
        while (it.hasNext())
        {
            d = it.next();
            sb.append(String.format(", %1$s", d.name.getName()));//d.nameScope
        }
        return sb.toString();
    }

    final static String defSetString(TCDefinitionSet s) 
    {
        // ST st = group.getInstanceOf(ExuTemplate.printList.name());
        // st.add(ExuTemplate.printList.arg, s);
        // return st.render();
        StringBuilder sb = new StringBuilder();
        Iterator<TCDefinition> it = s.iterator();
        TCDefinition d;
        if (it.hasNext())
        {
            d = it.next();
            sb.append(String.format("%1$s", d.name.getName()));//d.nameScope
        }
        while (it.hasNext())
        {
            d = it.next();
            sb.append(String.format(", %1$s", d.name.getName()));//d.nameScope
        }
        return sb.toString();
    }

    final static String defMapString(Map<TCNameToken, TCDefinitionSet> m)
    {
        // ST st = group.getInstanceOf(ExuTemplate.printMap.name());
        // st.add(ExuTemplate.printMap.arg, m.entrySet());
        // return st.render();
        StringBuilder sb = new StringBuilder();
        Iterator<TCNameToken> it = m.keySet().iterator();
        TCNameToken d;
        while (it.hasNext())
        {
            d = it.next();
            sb.append(String.format("\n%1$s \t\t={%2$s}", d.getName(), defSetString(m.get(d))));
        }
        return sb.toString();
    }

    private TCNameList savedStartPoints;
    private TCNameList savedTopologicalSort;
    private TCDefinitionList savedModuleDefs;

    public ExuOrder(boolean debug)
    {
        super(debug);
        savedStartPoints = null;
        savedTopologicalSort = null;
        savedModuleDefs = null;
    }

    @Override
    public String toString()
    {
        return toString(true, this.sortCalled);
    }

    public String toString(boolean printMaps, boolean printResult)
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

    public TCNameList processModule(TCModule m)
    {
        TCNameList result = null;
        if (debug)
        {
            Console.out.println(String.format("Calculating declaration dependencies for module `%1$s`...", m.name.getName()));
        }
        this.definitionOrder(m);
        if (Settings.verbose)
        {
            Console.out.println(toString(true, false));
            this.graphIt(m);
        }
        int outOrderCount = this.needsSorting();
        if (outOrderCount > 0)
        {
            result = topologicalSort(); 
            if (debug)
            {
                Console.out.println("Found " + outOrderCount + " definition use before declaration. Topological sorted required.");
                Console.out.println(toString(false, true));
            }    
        }
        return result;
    }

    @Override
    public void definitionOrder(TCModule m)
    {
        savedModuleDefs = new TCDefinitionList();
        savedModuleDefs.addAll(m.defs);
        super.definitionOrder(m);
    }

    public TCNameList getOriginalDefNames()
    {
        if (savedModuleDefs == null)
            throw new IllegalStateException("You must call definitionOrder first");
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
        TCNameList result = super.getStartpoints();
        savedStartPoints = new TCNameList();
        savedStartPoints.addAll(result);
        return result;
    }

    @Override
    public TCNameList topologicalSort(TCNameList startPoints)
    {
        TCNameList result = super.topologicalSort(startPoints);
        savedTopologicalSort = new TCNameList();
        savedTopologicalSort.addAll(result);
        return result;
    }

    public String oldToString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("\nName locations:");
        for(Map.Entry<TCNameToken, LexLocation> e : nameToLoc.entrySet())
        {
            sb.append(String.format("\n%1$s \t\t@ %2$s[L%3$s,C%4$s]", e.getKey().getName(), e.getKey().getModule(), e.getValue().startLine, e.getValue().startPos));
        }
        sb.append("\n\nUses map:");
        sb.append(defMapString(uses));
        sb.append("\n\nUsed by map:");
        sb.append(defMapString(usedBy));
        sb.append("\n\nStart points :");
        for(TCNameToken n : getStartpoints())
        {
            sb.append(String.format("\n%1$s", n.getName()));
        }
        return sb.toString();
    }

    public void graphIt(TCModule m)
    {
        graphIt(m, "");
    }

    public void graphIt(TCModule m, String namePrefix)
    {
        try {
            if (m.files.size() > 0)
            {
                String name = namePrefix + m.name.getName();//m.files.get(0).getName();
                String parent = m.files.get(0).getParent();
                File depFile = new File(parent, ".generated/" +name + ".dot");
                graphOf(depFile);
                Console.out.println("Printed dependencies for module " + name + " at " + depFile.getAbsolutePath() + "\n");
            } 
        } catch (IOException e) {
            Console.err.println("I/O error whilst attempting to write dependency graph");
            e.printStackTrace();
        }    
    }
}