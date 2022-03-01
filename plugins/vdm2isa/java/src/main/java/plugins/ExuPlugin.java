package plugins;

import java.util.Stack;

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
import vdm2isa.tr.definitions.TRSpecificationKind;
import vdm2isa.tr.expressions.visitors.TCRFunctionCallFinder;

public class ExuPlugin extends GeneralisaPlugin {

    // accepts invariant checks over compatible/equal types as unnecessary
    public static boolean linientInvCheck; 
    
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
        return "exu - because the devil is in the detail; it will analyse all loaded VDM modules for Isabelle/HOL (v. " + GeneralisaPlugin.isaVersion + ") translation";
    }

    public static final void setupProperties()
    {
        GeneralisaPlugin.setupProperties();
        ExuPlugin.linientInvCheck = true;
    }
}
