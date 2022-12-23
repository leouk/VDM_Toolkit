package plugins;

import java.util.HashMap;
import java.util.Map;

import com.fujitsu.vdmj.ExitStatus;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.typechecker.ModuleTypeChecker;
import com.fujitsu.vdmj.typechecker.TypeChecker;

/**
 * Brings into the module typechecker what VDMSL.java does in its typeCheck method. 
 * This is needed so as to typecheck reordered modules. 
 */
public class ExuTypeChecker {
    
    private final boolean warnings; 
    private final boolean debug;
    private TCModuleList sorted_list;
    private final Map<String, ExuOrder> exuMap;

    // private static final List<VDMSpecificationKind> IGNORE_KINDS = 
    //     Arrays.asList(VDMSpecificationKind.MEASURE, VDMSpecificationKind.PRE,
    //         VDMSpecificationKind.POST, VDMSpecificationKind.);
    
    public ExuTypeChecker(boolean debug, boolean warnings)
    {
        super();
        this.exuMap = new HashMap<String, ExuOrder>();
        this.sorted_list = null;
        this.warnings = warnings; 
        this.debug = debug;
    }

    private TCNameToken find(TCNameList list, String name)
    {
        for(TCNameToken n : list)
        {
            if (n.getName().equals(name))
                return n;
        }
        return null;
    }

    private TCNameList organise(TCNameList ts)
    {
        TCNameList result = new TCNameList();
        for(TCNameToken n : ts)
        {
            VDMSpecificationKind kind = VDMSpecificationKind.figureOutSpecificationKind(n);
            switch (kind)
            {
                // get the T from inv_T
                case INV:
                    String name = n.getName().substring(kind.name().length()+1);
                    TCNameToken type = find(ts, name);
                    if (type == null)
                        throw new IllegalStateException("Couldn't find type " + name + " for known invariant name? " + n.getName());
                    else if (!result.contains(type))
                        result.add(type);
                    break;

                // get normal names
                case NONE: 
                    if (!result.contains(n))
                       result.add(n);
                    break;

                // ignore other specifications (pre/post/measure/min/max/ord/eq)
                default: 
                    break;                    
            }
        }
        return result;
    }

    protected ExuOrder processModule(TCModule m)
    {
        ExuOrder result;
        if (!exuMap.containsKey(m.name.getName()))
        {
            result = new ExuOrder(m, debug);
            exuMap.put(m.name.getName(), result);
        }
        else 
            result = exuMap.get(m.name.getName());
        return result;
    }

    public void processModules(TCModuleList tclist)
    {
        for(TCModule m : tclist)
        {
            processModule(m);
        }
    } 

    public void graphModules(TCModuleList tclist)
    {
        for(TCModule m : tclist)
        {
            ExuOrder order = processModule(m);
            order.graphModule();
        }
    }

    protected TCModule sortModule(TCModule m)
    {
        ExuOrder order = processModule(m);
        TCModule result = m;
        TCNameList ts = order.sortModule();
        // Original: Rec, R, S, T, tail, sum_elems, head
        // Sorted  : tail, head, inv_T, sum_elems, inv_S, T, inv_R, inv_Rec, pre_head, measure_sum_elems, S, R, Rec
        // Organised: tail, head, T, sum_elems, S, R, Rec 
        if (ts != null)
        {
            TCNameList original = order.getOriginalDefNames();
            TCNameList organised = organise(ts);
            if (debug)
            {
                Console.out.println("Organised names : " + organised.toString() + "\n");
            }
    
            // topological sorting must contain all original
            // set-view of organised must equal original (just their order is different)  
            assert ts.containsAll(original) && organised.containsAll(original) && original.containsAll(organised);
    
            // reorder module definition according to organised name list order
            TCDefinitionList moduleDefs = new TCDefinitionList();
            for(TCNameToken n : organised)
            {
                moduleDefs.add(order.findDefinition(n));
            }
    
            // recreate the module with the ordered definitions; set TC calculated fields to avoid retypechecking
            result = new TCModule(m.annotations, m.name, 
                m.imports, m.exports, moduleDefs, m.files, m.isFlat);
            result.comments = (m.comments);
            result.importdefs = (m.importdefs);
            result.exportdefs = (m.exportdefs);
            // result.comments.addAll(m.comments);
            // result.importdefs.addAll(m.importdefs);
            // result.exportdefs.addAll(m.exportdefs);    

            Console.out.println("Exu successfully sorted module " + m.name.getName() + " definitions");
        }
        return result;
    }

    /**
     * Returns whether the resulting computation entailed sorting occured.
     * That is, given list is different to sorted one, then sorting occurred.  
     * @param tclist
     * @return
     */
    public boolean sortModules(TCModuleList tclist)
    {
        sorted_list = new TCModuleList();
        for(TCModule m : tclist)
        {
            TCModule sorted_m = sortModule(m);
            sorted_list.add(sorted_m);
        }
        return !tclist.equals(sorted_list);
    }

    public TCModuleList getSortedModules()
    {
        if (sorted_list == null)
            throw new IllegalStateException("Cannot get sorted modules; call sortModules first!");
        return sorted_list;       
    }

    /**
     * (Mostly) reproduces what VDMSL.typeCheck does. 
     * @param tclist
     * @return
     */
    public ExitStatus typeCheck(TCModuleList tclist)
    {
        long before = System.currentTimeMillis();

        int terrs = 0;
        TypeChecker.clearErrors();
        TypeChecker mtc = new ModuleTypeChecker(sorted_list);
   		try
   		{
   			mtc.typeCheck();
   		}
		catch (InternalException e)
		{
			Console.out.println(e.toString());
		}
		catch (Throwable e)
		{
			Console.out.println(e.toString());
			terrs++;
		}

   		long after = System.currentTimeMillis();
		terrs += TypeChecker.getErrorCount();

		if (terrs > 0)
		{
            TypeChecker.printErrors(Console.out);
		}

  		int twarn = TypeChecker.getWarningCount();

		if (twarn > 0 && warnings)
		{
			TypeChecker.printWarnings(Console.out);
		}
        
        Console.out.print("Exu re-type checked sorted " + ExuPlugin.plural(sorted_list.size(), "module", "s") +
        " in " + (double)(after-before)/1000 + " secs. ");
        Console.out.print(terrs == 0 ? "No type errors" :
            "Found " + ExuPlugin.plural(terrs, "type error", "s"));
        Console.out.println(twarn == 0 ? "" : " and " +
            (warnings ? "" : "suppressed ") + ExuPlugin.plural(twarn, "warning", "s"));
    
        return terrs == 0 ? ExitStatus.EXIT_OK : ExitStatus.EXIT_ERRORS;
    }
}
