package plugins;

import com.fujitsu.vdmj.VDMJ;
import com.fujitsu.vdmj.commands.CommandPlugin;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.messages.VDMWarning;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

public class ExuPlugin extends AbstractIsaPlugin {

	public ExuPlugin(Interpreter interpreter)
	{
		super(interpreter);
	}

	public static void main(String args[])
    {
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-i", "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl"});
    }

    @Override
    public boolean isaRun(TCModuleList tclist, String[] argv) throws Exception {
        boolean result = false;
        if (interpreter instanceof ModuleInterpreter)
		{
            Console.out.println("Calling Exu VDM analyser...");

            //TODO perform the analysis

            result = true;
        }
        return result;
    }

    @Override
    public String getSummaryPrefix()
    {
        return "Exu analysed ";
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
