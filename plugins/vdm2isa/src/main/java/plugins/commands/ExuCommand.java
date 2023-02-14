package plugins.commands;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Stack;

import com.fujitsu.vdmj.ExitStatus;
import com.fujitsu.vdmj.plugins.PluginConsole;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import plugins.ExuTypeChecker;
import plugins.IsaProperties;
import plugins.VDMSpecificationKind;
import plugins.visitors.exu.TCExuFunctionCallFinder;
import vdm2isa.messages.IsaWarningMessage;

public class ExuCommand extends IsabelleCommand {

    private ExuTypeChecker etc;

    private static ExuCommand INSTANCE = null;
    private static final String USAGE = "exu - it analyses loaded VDM modules for Isabelle/HOL  (v. " + IsaProperties.general_isa_version + ") translation"; 

    // public static final ExuPlugin getInstance(Interpreter interpreter)
    // {
    //     if (INSTANCE == null)
    //     {
    //         INSTANCE = new ExuPlugin(interpreter);
    //     }
    //     return INSTANCE; 
    // }

    public static final ExuCommand getInstance()
    {
        return INSTANCE; 
    }

    public ExuCommand(String line) {
        super(line);
        if (!argv[0].equals(isabelleCommandName()))
		{
			throw new IllegalArgumentException(USAGE);
		}
        INSTANCE = this;
    }

    @Override
    protected boolean setup()
    {
        boolean result = true;

        // VDM errors don't pass VDMJ typechecker; 
        // some VDM warnings have to be raised as Exu warnings or errors depending on strictness
        IsabelleCommand.processVDMWarnings(TypeChecker.getWarnings(), IsaProperties.general_strict);

        etc = new ExuTypeChecker(IsaProperties.general_debug, IsaProperties.general_report_vdm_warnings, this.saveURI);

        // once-only (per [re-]load) call definitionOrder on all modules
        etc.processModules(tclist);

        return result;  
    }

    @Override 
    protected boolean runCommand(String name, TCModuleList tclist)
    {
        boolean result;
        if (name.equals("graph"))
        {
            // graphIt
            etc.graphModules(tclist);
            result = true;
        }
        else if (name.equals("sort")) 
        {
            // sort it 
            result = true;
            boolean neddedSorting = etc.sortModules(tclist);
            if (neddedSorting && IsaProperties.exu_retypecheck)
            {
                ExitStatus status = etc.typeCheck(tclist);
                result = status == ExitStatus.EXIT_OK;    
            }
            if (neddedSorting && result)
            {
                // update the tclist with the topological sorted list now typechecked
                tclist.clear();
                tclist.addAll(etc.getSortedModules());
            }
            else if (!result)
                PluginConsole.println("Module list topological sorting threw type errors!");        
            result = (!IsaProperties.general_strict || result);
        }
        else if (name.equals("check"))
        {
            // check it 
            checkModules(tclist);
            result = (!IsaProperties.general_strict || getLocalErrorCount() == 0);
        }
        else 
        {
            result = false;
        }
        return result;
    }

    @Override
    protected void prompt()
    {
        PluginConsole.infoln("Calling Exu VDM analyser...");
        super.prompt();
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

    protected void checkSpecificationCallsConsistency(TCModuleList tclist, VDMSpecificationKind kind, TCExplicitFunctionDefinition spec)
    {
        if (spec != null)
        {
            TCExuFunctionCallFinder finder = new TCExuFunctionCallFinder(IsaProperties.exu_linient_inv_check);
            // use a list instead of set to get warnings at every call, not just the first! 
            TCNameList found = new TCNameList();
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
                                    kind.equals(VDMSpecificationKind.NONE) ? "body" : 
                                    kind.name().toLowerCase(), n);
                        }
                        // there is a pre defined, then why haven't you called it? 
                        else 
                        {
                            warning(IsaWarningMessage.VDMSL_EXU_MISSING_SPECCALL_3P, 
                                n.getLocation(), spec.name.toString(), 
                                    kind.equals(VDMSpecificationKind.NONE) ? "body" : 
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

            // if (tdef.eqdef == null && tdef.orddef != null || tdef.eqdef != null && tdef.orddef == null)
            // {
            //     report(IsaErrorMessage.ISA_INVALID_INVTYP_2P, getName(), "must define both eq and ord specificaition");
            // }
            checkSpecificationCallsConsistency(tclist, VDMSpecificationKind.INV, tdef.invdef);
            checkSpecificationCallsConsistency(tclist, VDMSpecificationKind.EQ, tdef.eqdef);
            checkSpecificationCallsConsistency(tclist, VDMSpecificationKind.ORD, tdef.eqdef);
            checkInvariantTypeSpecificationConsistency(tdef, tclist);
        }
        else if (d instanceof TCExplicitFunctionDefinition)
        {
            TCExplicitFunctionDefinition fdef = (TCExplicitFunctionDefinition)d;
            checkSpecificationCallsConsistency(tclist, VDMSpecificationKind.NONE, fdef);
            checkSpecificationCallsConsistency(tclist, VDMSpecificationKind.PRE, fdef.predef);
            checkSpecificationCallsConsistency(tclist, VDMSpecificationKind.POST, fdef.postdef);
            checkSpecificationCallsConsistency(tclist, VDMSpecificationKind.MEASURE, fdef.measureDef);
        }
        else if (d instanceof TCImplicitFunctionDefinition)
        {
            TCImplicitFunctionDefinition idef = (TCImplicitFunctionDefinition)d;
            //checkSpecificationCallsConsistency(tclist, TRSpecificationKind.NONE, idef);
            checkSpecificationCallsConsistency(tclist, VDMSpecificationKind.PRE, idef.predef);
            checkSpecificationCallsConsistency(tclist, VDMSpecificationKind.POST, idef.postdef);
            checkSpecificationCallsConsistency(tclist, VDMSpecificationKind.MEASURE, idef.measureDef);
            //checkImplicitFunctionBody(idef);
        }
    }

    protected void checkFieldExpressionTypes(TCDefinition d)
    {
        d.getFreeVariables();
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

    protected void checkModule(TCModule module)
    {
        for(TCDefinition d : module.defs)
        {
            checkSpecificationDependencies(d, tclist);
            checkPatterns(d);
        }
    }

    protected void checkModules(TCModuleList tclist) 
    {
        int mcount = 0;
        for(TCModule m : tclist)
        {         
            checkModule(m);
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
    public String isabelleCommandName()
    {
        return "exu";
    }

    public static void help() 
    {
        // because the devil is in the detail; 
        PluginConsole.println(USAGE);
    }

    @Override
    protected boolean processArgument(String arg, Iterator<String> i)
    {
        boolean result;
        if (arg.equals("graph") && !commands.contains(arg))
        {
            result = commands.add(arg);
        }
        else if (arg.equals("sort") && !commands.contains(arg))
        {
            result = commands.add(arg);
        }
        else if (arg.equals("check") && !commands.contains(arg))
        {
            result = commands.add(arg);
        }
        else if (!commands.contains(arg))
        {
            result = super.processArgument(arg, i);
        }
        else 
        {
            result = commands.contains(arg);
        }
        return result;
    }

    @Override
    protected void doSet(String prop, String val)
    {
        if (prop.equals("linv"))
        {
            IsaProperties.exu_linient_inv_check = Boolean.parseBoolean(val);
        }
        else if (prop.equals("rtc"))
        {
            IsaProperties.exu_retypecheck = Boolean.parseBoolean(val);
        }
        else if (prop.equals("gs"))
        {
            IsaProperties.exu_print_sorted_graph = Boolean.parseBoolean(val);
        }
        else 
        {
            super.doSet(prop, val);
        }
    }

    @Override
    protected void printOptionDefaults()
    {
        super.printOptionDefaults();
        printFlag("linient invariant", IsaProperties.exu_linient_inv_check);
        printFlag("re-type check", IsaProperties.exu_retypecheck);
        printFlag("print sorted dependency graph", IsaProperties.exu_print_sorted_graph);
    }

    @Override
    protected String commandsHelp()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(super.commandsHelp());
        sb.append("\tgraph: generates definition dependency graphs per module\n");
        sb.append("\tsort : topological sort enforces declaration before use of definitions\n");
        sb.append("\tcheck: structural check for compliance to translation rules\n");
        return sb.toString();
    }

    @Override
    protected List<String> validCommands()
    {
        return Arrays.asList("graph", "sort", "check");
    }

    @Override 
    protected String options()
    {
        return super.options() + 
            String.format(" linv=%1$s rtc=%2$s gs=%3$s", IsaProperties.exu_linient_inv_check, IsaProperties.exu_retypecheck, IsaProperties.exu_print_sorted_graph);
    }

    @Override
    protected String optionsHelp()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(super.optionsHelp());
        sb.append("\tlinv    : linient check on (sub-)type invariant chain\n");
        sb.append("\trtc     : re-typecheck modules if topological sort is needed\n");
        sb.append("\tgs      : generate graph of sorted module\n");
        return sb.toString();
    }
}
