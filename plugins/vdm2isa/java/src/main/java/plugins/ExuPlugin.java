package plugins;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.messages.VDMWarning;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

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

            //TODO perform the analysis

            result = true;
        }
        return result;
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
