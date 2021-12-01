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
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.visitors.TCFunctionCallFinder;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRSpecificationKind;
import vdm2isa.tr.expressions.TRExpression;

public class ExuPlugin extends GeneralisaPlugin {

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

            checkSpecificationDependencies(tclist);
            
            result = true;
        }
        return result;
    }

    // protected void checkSpecificationCallsConsistency(TRSpecificationKind kind, TCDefinition/*TCExplicitFunctionDefinition*/ specDef)
    // {
    //     //TODO this is not quite complete: if you get pre_g in the post_h' it would not fail! Oh well
    //     if (specDef != null)
    //     {
    //         TCNameSet calledNames = specDef.getCallMap();
    //         for(TCNameToken n : calledNames)
    //         {
    //             // for non-spec name calls, insist that at least their pres are called! 
    //             if (!isSpecificationName(n))
    //             {
    //                 if (!calledNames.contains(n.getPreName(n.getLocation())))
    //                 {
    //                     warning(IsaWarningMessage.VDMSL_EXU_MISSING_SPECCALL_3P, 
    //                         n.getLocation(), specDef.name.toString(), 
    //                             kind.equals(TRSpecificationKind.NONE) ? "body" : 
    //                             kind.name().toLowerCase(), n);    
    //                 }
    //             }
    //         }
    //     }
    // }

    protected void checkSpecificationCallsConsistency(TCModuleList tclist, TRSpecificationKind kind, TCExplicitFunctionDefinition spec)
    {
        if (spec != null)
        {
            TCFunctionCallFinder finder = new TCFunctionCallFinder();
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
                        if (predef != null && predef.isEmpty())
                        {
                            warning(IsaWarningMessage.VDMSL_EXU_MISSING_INVCALL_3P,
                                n.getLocation(), spec.name.toString(), 
                                kind.equals(TRSpecificationKind.NONE) ? "body" : 
                                kind.name().toLowerCase(), n);
                        }
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


    private boolean isSpecificationName(TCNameToken n) {
        return n.isReserved(); 
    }

    protected void checkSpecificationDependencies(TCModuleList tclist) 
    {
        for(TCModule m : tclist)
        {
            for(TCDefinition d : m.defs)
            {
                if (d instanceof TCTypeDefinition)
                {
                    TCTypeDefinition tdef = (TCTypeDefinition)d;
                    checkSpecificationCallsConsistency(tclist, TRSpecificationKind.INV, tdef.invdef);
                    checkSpecificationCallsConsistency(tclist, TRSpecificationKind.EQ, tdef.eqdef);
                    checkSpecificationCallsConsistency(tclist, TRSpecificationKind.ORD, tdef.eqdef);
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
                }
            }
        }
    }

    @Override
    protected String getSummaryPrefix()
    {
        return "Exu analysed ";
    }

    @Override
    public String help() {
        return "exu - because the devil is in the detail, analyse all loaded VDM modules for Isabelle/HOL (v. " + GeneralisaPlugin.isaVersion + ") translation";
    }
}
