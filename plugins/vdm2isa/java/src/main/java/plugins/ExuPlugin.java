package plugins;

import com.fujitsu.vdmj.VDMJ;
import com.fujitsu.vdmj.commands.CommandPlugin;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.VDMWarning;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;

public class ExuPlugin extends AbstractISAPlugin {

	public ExuPlugin(Interpreter interpreter)
	{
		super(interpreter);
	}

	public static void main(String args[])
    {
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-i", "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl"});
    }

    @Override
    public boolean run(String[] argv) throws Exception {
        if (interpreter instanceof ModuleInterpreter)
		{
			long before = System.currentTimeMillis();
			int errs = 0;
			int tcount = 0;

            AbstractISAPlugin.setupProperties();
			AbstractISAPlugin.reset();

            

            return true;
        }
        else
        {
            return false;
        }
    }

    @Override
    public String help() {
        return "exu - analyse all loaded VDM modules for Isabelle/HOL (v. " + AbstractISAPlugin.isaVersion + ") translation";
    }

    public static void report(int number, String problem, LexLocation location)
	{
		AbstractISAPlugin.report(number, problem, location);
	}

	public static void reportAsError(VDMWarning w)
	{
		AbstractISAPlugin.reportAsError(w);
	}

	public static void warning(int number, String problem, LexLocation location)
	{
		AbstractISAPlugin.warning(number, problem, location);
	}
}
