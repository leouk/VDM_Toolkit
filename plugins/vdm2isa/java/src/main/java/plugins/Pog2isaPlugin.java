package plugins;

import java.util.HashMap;
import java.util.Map;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.messages.VDMWarning;
import com.fujitsu.vdmj.pog.ProofObligation;
import com.fujitsu.vdmj.pog.ProofObligationList;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.pog.IsaProofObligationList;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRExpressionList;
import vdm2isa.tr.expressions.TRProofObligationExpression;
import vdm2isa.tr.types.TRType;

public class Pog2isaPlugin extends AbstractIsaPlugin {

    public Pog2isaPlugin(Interpreter interpreter) {
        super(interpreter);
    }

    @Override
    public boolean isaRun(TCModuleList tclist, String[] argv) throws Exception {
        boolean result = false;
        if (interpreter instanceof ModuleInterpreter)
        {
            Vdm2isaPlugin vdm2isa = new Vdm2isaPlugin(interpreter);
            result = vdm2isa.run(argv);  
            int localerrs = 0;
            int poCount = 0;
            int modCount = 0;
            try
			{
                // create an isabelle module interpreter 
                ModuleInterpreter minterpreter = (ModuleInterpreter)interpreter;
                IsaInterpreter isaInterpreter = new IsaInterpreter(minterpreter);

                // get the POG and IsaPOG lists 
                ProofObligationList pogl = isaInterpreter.getProofObligations();
                IsaProofObligationList isapogl = new IsaProofObligationList();
                
                for(ProofObligation po : pogl)
                {
                    // type check PO as an TC AST
                    Pair<TCExpression, TCType> pair  = isaInterpreter.typeCheck(po.value, po.location.module);
                    //TODO check pair.value is type okay; for VDM POGs should always be fine, but there will be "mine" as well ;-)

                    // translate the PO back to TR world
                    Pair<TRExpression, TRType> mpair = isaInterpreter.map2isa(pair);
                    TRProofObligationExpression poe = new TRProofObligationExpression(po, mpair.key, mpair.value);
                    isapogl.add(poe);
                }

                if (AbstractIsaPlugin.strict && AbstractIsaPlugin.getErrorCount() == 0 && localerrs == 0)
                {
                    // output POs per module
                    Map<String, TRExpressionList> modules = isapogl.getModulePOs();
                    modCount += modules.size();
                    for (Map.Entry<String, TRExpressionList> entry : modules.entrySet())
                    {
                        poCount += entry.getValue().size();
                        outputModule(entry.getValue().getLocation(), entry.getKey(), entry.getValue().translate());
                    }
                }
			}
			catch (InternalException e)
			{
				Console.out.println(e.toString());
			}
			catch (Throwable t)
			{
				Console.out.println("Uncaught exception: " + t.toString());
				t.printStackTrace();
				AbstractIsaPlugin.errs++;
			}
        }
        return result;
    }

    @Override
    public void summarise(long execTimeMs) {
        Console.out.println("Translated " + plural(getLocalModuleCount(), "module", "s") +
            " in " + (double)(execTimeMs/1000) + " secs. ");
        Console.out.print(getLocalErrorCount() == 0 ? "No issues" :
            "Found " + plural(getLocalErrorCount(), "issues", "s"));
        Console.out.print(getLocalWarningCount() == 0 ? "" : " and " +
            (AbstractIsaPlugin.reportWarnings ? "" : "suppressed ") + plural(getLocalWarningCount(), "warning", "s") + ".");
        Console.out.println(getLocalErrorCount() > 0 ? " Proceeding with translation with remaining issues may lead to Isabelle errors!" : "");
    }

    @Override
    public String help() {
        return "exu - analyse all loaded VDM modules for Isabelle/HOL (v. " + AbstractIsaPlugin.isaVersion + ") translation";
    }

    public static void report(int number, String problem, LexLocation location)
	{
		AbstractIsaPlugin.report(number, problem, location);
	}

	public static void reportAsError(VDMWarning w)
	{
		AbstractIsaPlugin.reportAsError(w);
	}

	public static void warning(int number, String problem, LexLocation location)
	{
		AbstractIsaPlugin.warning(number, problem, location);
	}
}
