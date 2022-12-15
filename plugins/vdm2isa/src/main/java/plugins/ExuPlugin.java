package plugins;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionSet;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRSpecificationKind;
import vdm2isa.tr.expressions.visitors.TCRFunctionCallFinder;

public class ExuPlugin extends GeneralisaPlugin {

    // accepts invariant checks over compatible/equal types as unnecessary
    public static boolean linientInvCheck;
    
    private static class ExuOrder extends DependencyOrder
    {
        public ExuOrder(boolean debug)
        {
            super(debug);
        }

        final static String defListString(TCDefinitionList s) 
        {
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

        @Override
        public String toString()
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
            sb.append("\n\nStart points:");
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
                    File depFile = new File(parent, name + ".dot");
                    graphOf(depFile);
                    Console.out.println("Printed dependencies for module " + name + " at " + depFile.getAbsolutePath());
                } 
            } catch (IOException e) {
                Console.err.println("I/O error whilst attempting to write dependency graph");
                e.printStackTrace();
            }    
        }
    }
    
	public ExuPlugin(Interpreter interpreter)
	{
		super(interpreter);
	}

    @Override
    public boolean isaRun(TCModuleList tclist, String[] argv) throws Exception {
        boolean result = false;
        if (interpreter instanceof ModuleInterpreter)
		{
            Console.out.println("Calling Exu VDM analyser...");

            checkModules(tclist);

            result = true;
        }
        return result;
    }

    protected void checkInvariantTypeSpecificationConsistency(TCTypeDefinition d, TCModuleList tclist)
    {
        // if have ord and not eq or vice versa
        if (d.eqdef == null && d.orddef != null || d.eqdef != null && d.orddef == null)
        {
            if (!d.type.isNumeric(d.type.location))//(d.type instanceof TCRecordType)
            {
                warning(IsaWarningMessage.VDMSL_EXU_MISSING_TYPEDEF_SPEC_1P, d.location, d.name.toString());
            }
        }
    }

    protected void checkSpecificationCallsConsistency(TCModuleList tclist, TRSpecificationKind kind, TCExplicitFunctionDefinition spec)
    {
        if (spec != null)
        {
            TCRFunctionCallFinder finder = new TCRFunctionCallFinder(ExuPlugin.linientInvCheck);
            TCNameSet found = new TCNameSet();
            found.addAll(spec.body.apply(finder, null));
            if (spec.predef != null)
            {
                found.addAll(spec.predef.body.apply(finder, null));
            }
            Stack<TCNameToken> stack = new Stack<TCNameToken>();
            for(TCNameToken n : found)
            {
                // for non-spec name calls, insist that at least their pres are called! 
                if (!isSpecificationName(n))
                {
                    TCNameToken pren = n.getPreName(n.getLocation());
                    if (!found.contains(pren))
                    {
                        stack.clear();
                        stack.push(pren);
                        TCDefinitionList predef = tclist.findDefinitions(stack);
                        // there isn't a pre defined? Okay what about the type invariants?
                        if (predef == null || predef.isEmpty())
                        {
                            warning(IsaWarningMessage.VDMSL_EXU_MISSING_INVCALL_3P,
                                n.getLocation(), spec.name.toString(), 
                                    kind.equals(TRSpecificationKind.NONE) ? "body" : 
                                    kind.name().toLowerCase(), n);
                        }
                        // there is a pre defined, then why haven't you called it? 
                        else 
                        {
                            warning(IsaWarningMessage.VDMSL_EXU_MISSING_SPECCALL_3P, 
                                n.getLocation(), spec.name.toString(), 
                                    kind.equals(TRSpecificationKind.NONE) ? "body" : 
                                    kind.name().toLowerCase(), n);    
                        }
                    }
                }
            }
        }
    }

    // but implicit functions can have body! oh man
    // private void checkImplicitFunctionBody(TCImplicitFunctionDefinition def)
    // {
    //     if (def.body != null || def.measureDef != null)
    //     {
    //         report(IsaErrorMessage.VDMSL_EXU_IMPLICIT_FUNCTION_BODY_1P, def.name.getLocation(), def.name.toString());
    //     }
    // }

    private boolean isSpecificationName(TCNameToken n) {
        return n.isReserved(); 
    }

    protected void checkSpecificationDependencies(TCDefinition d, TCModuleList tclist)
    {
        if (d instanceof TCTypeDefinition)
        {
            TCTypeDefinition tdef = (TCTypeDefinition)d;
            checkSpecificationCallsConsistency(tclist, TRSpecificationKind.INV, tdef.invdef);
            checkSpecificationCallsConsistency(tclist, TRSpecificationKind.EQ, tdef.eqdef);
            checkSpecificationCallsConsistency(tclist, TRSpecificationKind.ORD, tdef.eqdef);
            checkInvariantTypeSpecificationConsistency(tdef, tclist);
        }
        else if (d instanceof TCExplicitFunctionDefinition)
        {
            TCExplicitFunctionDefinition fdef = (TCExplicitFunctionDefinition)d;
            checkSpecificationCallsConsistency(tclist, TRSpecificationKind.NONE, fdef);
            checkSpecificationCallsConsistency(tclist, TRSpecificationKind.PRE, fdef.predef);
            checkSpecificationCallsConsistency(tclist, TRSpecificationKind.POST, fdef.postdef);
            checkSpecificationCallsConsistency(tclist, TRSpecificationKind.MEASURE, fdef.measureDef);
        }
        else if (d instanceof TCImplicitFunctionDefinition)
        {
            TCImplicitFunctionDefinition idef = (TCImplicitFunctionDefinition)d;
            //checkSpecificationCallsConsistency(tclist, TRSpecificationKind.NONE, idef);
            checkSpecificationCallsConsistency(tclist, TRSpecificationKind.PRE, idef.predef);
            checkSpecificationCallsConsistency(tclist, TRSpecificationKind.POST, idef.postdef);
            checkSpecificationCallsConsistency(tclist, TRSpecificationKind.MEASURE, idef.measureDef);
            //checkImplicitFunctionBody(idef);
        }
    }

    protected void checkPatterns(TCDefinition d)
    {
        // Check for duplicated structured/record pattern in d
        // Check for let-def case? 
    }

    public TCDefinition findDefinition(TCModule m, TCNameToken sought)
	{
		for (TCDefinition def : m.defs)
		{
			if (def.name != null && def.name.equals(sought))
			{
				return def;
			}
		}
		return null;
	}

    protected void sortModule(TCModule m)
    {
        ExuOrder order = new ExuOrder(true);
        order.definitionOrder(m.defs);

        if (order.debug)
        {
            Console.out.println(order.toString());
        }

        TCNameList ts = order.topologicalSort(); 
        
        if (order.debug)
        {
            Console.out.println("Original order = " + ExuOrder.defListString(m.defs));
            Console.out.println("Sorted names   = " + ts.toString());
        }

        m.defs.size();
    }

    protected void checkModules(TCModuleList tclist) 
    {
        int mcount = 0;
        for(TCModule m : tclist)
        {         
            for(TCDefinition d : m.defs)
            {
                checkSpecificationDependencies(d, tclist);
                checkPatterns(d);
            }
            sortModule(m);
            mcount++;
        }
        addLocalModules(mcount);
    }

    @Override
    protected String getSummaryPrefix()
    {
        return "Exu analysed ";
    }

    @Override
    public String help() {
        return "exu - because the devil is in the detail; it will analyse all loaded VDM modules for Isabelle/HOL (v. " + GeneralisaPlugin.isaVersion + ") translation";
    }

    public static final void setupProperties()
    {
        GeneralisaPlugin.setupProperties();
        ExuPlugin.linientInvCheck = true;
    }
}
