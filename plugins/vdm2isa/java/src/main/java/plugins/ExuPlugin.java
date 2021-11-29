package plugins;

import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRSpecificationKind;

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

    protected void checkSpecificationCallsConsistency(TRSpecificationKind kind, TCDefinition/*TCExplicitFunctionDefinition*/ specDef)
    {
        //TODO this is not quite complete: if you get pre_g in the post_h' it would not fail! Oh well
        if (specDef != null)
        {
            TCNameSet calledNames = specDef.getCallMap();
            for(TCNameToken n : calledNames)
            {
                // for non-spec name calls, insist that at least their pres are called! 
                if (!isSpecificationName(n))
                {
                    if (!calledNames.contains(n.getPreName(n.getLocation())))
                    {
                        warning(IsaWarningMessage.VDMSL_EXU_MISSING_SPECCALL_3P, 
                            n.getLocation(), specDef.name.toString(), 
                                kind.equals(TRSpecificationKind.NONE) ? "body" : 
                                kind.name().toLowerCase(), n);    
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
                    checkSpecificationCallsConsistency(TRSpecificationKind.INV, tdef.invdef);
                    checkSpecificationCallsConsistency(TRSpecificationKind.EQ, tdef.eqdef);
                    checkSpecificationCallsConsistency(TRSpecificationKind.ORD, tdef.eqdef);
                }
                else if (d instanceof TCExplicitFunctionDefinition)
                {
                    TCExplicitFunctionDefinition fdef = (TCExplicitFunctionDefinition)d;
                    checkSpecificationCallsConsistency(TRSpecificationKind.NONE, fdef);
                    checkSpecificationCallsConsistency(TRSpecificationKind.PRE, fdef.predef);
                    checkSpecificationCallsConsistency(TRSpecificationKind.POST, fdef.postdef);
                    checkSpecificationCallsConsistency(TRSpecificationKind.MEASURE, fdef.measureDef);
                }
                else if (d instanceof TCImplicitFunctionDefinition)
                {
                    TCImplicitFunctionDefinition idef = (TCImplicitFunctionDefinition)d;
                    checkSpecificationCallsConsistency(TRSpecificationKind.NONE, idef);
                    checkSpecificationCallsConsistency(TRSpecificationKind.PRE, idef.predef);
                    checkSpecificationCallsConsistency(TRSpecificationKind.POST, idef.postdef);
                    checkSpecificationCallsConsistency(TRSpecificationKind.MEASURE, idef.measureDef);
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
        return "exu - analyse all loaded VDM modules for Isabelle/HOL (v. " + GeneralisaPlugin.isaVersion + ") translation";
    }
}
