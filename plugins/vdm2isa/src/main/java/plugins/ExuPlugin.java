package plugins;

import java.util.Stack;

import com.fujitsu.vdmj.ExitStatus;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.expressions.visitors.TCRFunctionCallFinder;

public class ExuPlugin extends GeneralisaPlugin {
    
    public ExuPlugin(Interpreter interpreter)
	{
		super(interpreter);
	}

    @Override
    public boolean isaRun(TCModuleList tclist, String[] argv) throws Exception {
        boolean result = true;
        if (interpreter instanceof ModuleInterpreter)
		{
            Console.out.println("Calling Exu VDM analyser...");

            IsaProperties.general_debug = true;
            IsaProperties.exu_retypecheck = false;
            ExuTypeChecker etc = new ExuTypeChecker(IsaProperties.general_debug, true);
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
            else 
                Console.out.println("Module list topological sorting threw type errors!");
            checkModules(tclist);
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

    protected void checkSpecificationCallsConsistency(TCModuleList tclist, VDMSpecificationKind kind, TCExplicitFunctionDefinition spec)
    {
        if (spec != null)
        {
            TCRFunctionCallFinder finder = new TCRFunctionCallFinder(IsaProperties.exu_linient_inv_check);
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
        return "exu - because the devil is in the detail; it will analyse all loaded VDM modules for Isabelle/HOL (v. " + IsaProperties.general_isa_version + ") translation";
    }
}
