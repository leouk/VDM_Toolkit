package plugins;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.Vector;

import javax.swing.text.AbstractDocument;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.VDMJ;
import com.fujitsu.vdmj.commands.CommandPlugin;
import com.fujitsu.vdmj.config.Properties;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.messages.ConsoleWriter;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.messages.VDMWarning;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.messages.IsaMessage;
import vdm2isa.messages.IsaWarning;
import vdm2isa.messages.VDM2IsaError;
import vdm2isa.messages.VDM2IsaWarning;

public abstract class GeneralisaPlugin extends CommandPlugin {

    private final static List<VDM2IsaError> errors = new Vector<VDM2IsaError>();
    private final static List<VDM2IsaWarning> warnings = new Vector<VDM2IsaWarning>();

    // list of VDM warning numbers to raise as errors
    private final static List<Integer> vdmWarningOfInterest = Arrays.asList(5000, 5006, 5007, 5008, 5009, 5010, 5011,
            5012, 5013, 5016, 5017, 5018, 5019, 5020, 5021, 5031, 5032, 5033, 5037);

    // assuming max translation errors equals max type errors for now
    public static int maxErrors;
    public static String isaVersion;
	public static boolean reportWarnings;
    public static boolean strict;
    public static int errs;

    private int localErrors;
    private int localWarnings;
    private int localModules;

    public static void main(String args[])
    {
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-i", 
                "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2I.vdmsl"
//                ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl"
                ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IComplexExpr.vdmsl"
        });
    }

    public GeneralisaPlugin(Interpreter interpreter) {
        super(interpreter);
        localReset();
    }

    protected void localReset()
    {
        localErrors = 0;
        localWarnings = 0;
        localModules = 0;
    }

    public abstract boolean isaRun(TCModuleList tclist, String[] argv) throws Exception;

    protected String getSummaryPrefix()
    {
        return "Translated ";
    }

    public void summarise(long execTimeMs) {
        Console.out.println(getSummaryPrefix() + plural(getLocalModuleCount(), "module", "s") +
            " in " + (double)(execTimeMs/1000) + " secs. ");
        Console.out.print(getLocalErrorCount() == 0 ? "No issues" :
            "Found " + plural(getLocalErrorCount(), "issues", "s"));
        Console.out.print(getLocalWarningCount() == 0 ? "" : " and " +
            (GeneralisaPlugin.reportWarnings ? "" : "suppressed ") + plural(getLocalWarningCount(), "warning", "s") + ".");
        Console.out.println(getLocalErrorCount() > 0 ? " Proceeding with translation with remaining issues may lead to Isabelle errors!" : "");
    }

    public int getLocalErrorCount()
    {
        return localErrors;
    }

    public int getLocalWarningCount()
    {
        return localWarnings;
    }

    public int getLocalModuleCount()
    {
        return localModules;
    }

    protected void addLocalErrors(int toadd)
    {
        assert toadd >= 0;
        localErrors += toadd;
    }

    protected void addLocalWarnings(int toadd)
    {
        assert toadd >= 0;
        localWarnings += toadd;
    }

    protected void addLocalModules(int toadd)
    {
        assert toadd >= 0;
        localModules += toadd;
    }

    @Override
    public final boolean run(String[] argv) throws Exception {
        boolean result = false;
        if (interpreter instanceof ModuleInterpreter)
		{
			long before = System.currentTimeMillis();
            
            GeneralisaPlugin.setupProperties();
			GeneralisaPlugin.reset();
            localReset();
            GeneralisaPlugin.checkVDMSettings();

            ModuleInterpreter minterpreter = (ModuleInterpreter)interpreter;
			TCModuleList tclist = minterpreter.getTC();			

            result = isaRun(tclist, argv);

            long after = System.currentTimeMillis();
			addLocalErrors(Vdm2isaPlugin.getErrorCount());
			addLocalErrors(GeneralisaPlugin.getErrorCount());
			if (getLocalErrorCount() > 0)
			{
				GeneralisaPlugin.printErrors(Console.out);
			}

			addLocalWarnings(Vdm2isaPlugin.getWarningCount());
			addLocalWarnings(GeneralisaPlugin.getWarningCount());
			if (getLocalWarningCount() > 0 && GeneralisaPlugin.reportWarnings)
			{
				GeneralisaPlugin.printWarnings(Console.out);
			}
            summarise(after-before);
        }
        return result;
    }
    
    protected /* static */ void outputModule(LexLocation location, String module, String result) throws FileNotFoundException
	{
		String dir = location.file.getParent();
		if (dir == null) dir = ".";
		String name = module + ".thy";//module.name.getName().substring(0, module.name.getName().lastIndexOf('.')) + ".thy";
		Console.out.println("Translating module " + module + " as " + dir + "/" + name);
		File outfile = new File(dir, name);
		PrintWriter out = new PrintWriter(outfile);
		out.write(result);
		out.close();
	}

    public static void checkVDMSettings()
    {
        if (Settings.dialect != Dialect.VDM_SL)
        {
            GeneralisaPlugin.report(IsaMessage.VDMSL_ONLY, LexLocation.ANY);
            errs++;
        }
        if (Settings.release != Release.VDM_10)
        {
            // This refers to stuff like TCNameToken filtering important names out for CLASSIC say.
            // For now, it only affects TRExplicitFunctionDefinition, but this might get wider. 
            GeneralisaPlugin.warning(IsaWarning.VDMSL_VDM10, LexLocation.ANY);	
        }
    }

	public static void report(IsaMessage message, LexLocation location)
	{
		report(message, location, (Object[])null);
	}

	public static void report(IsaMessage message, LexLocation location, Object... args)
	{
		report(message.number, message.format(args), location);
	}

    public static void report(int number, String problem, LexLocation location) {
        VDM2IsaError error = new VDM2IsaError(number, problem, location);
        if (!errors.contains(error)) {
            errors.add(error);

            if (errors.size() >= GeneralisaPlugin.maxErrors - 1) {
                errors.add(new VDM2IsaError(10, "Too many translation errors", location));
                throw new InternalException(10, "Too many translation errors");
            }
        }
    }

    public static void reportAsError(VDMWarning w) {
        if (GeneralisaPlugin.vdmWarningOfInterest.contains(w.number)) {
            report(11111 + w.number, w.message, w.location);
        }
    }

	public static void warning(IsaWarning message, LexLocation location)
	{
		warning(message, location, (Object[])null);
	}

	public static void warning(IsaWarning message, LexLocation location, Object... args)
	{
		report(message.number, message.format(args), location);
	}

    public static void warning(int number, String problem, LexLocation location) {
        VDM2IsaWarning warning = new VDM2IsaWarning(number, problem, location);

        if (!warnings.contains(warning)) {
            warnings.add(warning);
        }
    }

    public static void clearErrors() {
        GeneralisaPlugin.errs = 0;
        GeneralisaPlugin.errors.clear();
        GeneralisaPlugin.warnings.clear();
    }

    public static int getErrorCount() {
        return GeneralisaPlugin.errors.size();
    }

    public static int getWarningCount() {
        return GeneralisaPlugin.warnings.size();
    }

    public static List<VDM2IsaError> getErrors() {
        return GeneralisaPlugin.errors;
    }

    public static List<VDM2IsaWarning> getWarnings() {
        return GeneralisaPlugin.warnings;
    }

    public static void printErrors(ConsoleWriter out) {
        if (Vdm2isaPlugin.getErrorCount() > 0) Vdm2isaPlugin.printErrors(out);
        for (VDM2IsaError e : GeneralisaPlugin.errors) {
            out.println(e.toString());
        }
    }

    public static void printWarnings(ConsoleWriter out) {
        if (Vdm2isaPlugin.getWarningCount() > 0) Vdm2isaPlugin.printWarnings(out);
        for (VDM2IsaWarning w : GeneralisaPlugin.warnings) {
            out.println(w.toString());
        }
    }

    public static String plural(int n, String s, String pl) {
        return n + " " + (n != 1 ? s + pl : s);
    }

    protected static void reset() {
        // reset internal tables in case of restranslation
        GeneralisaPlugin.clearErrors();
    }

    public static void setupProperties() {
        GeneralisaPlugin.errs = 0;
        GeneralisaPlugin.strict = false;
        GeneralisaPlugin.maxErrors = Properties.tc_max_errors;
        GeneralisaPlugin.isaVersion = "Isabelle2021: February 2021";
        GeneralisaPlugin.reportWarnings = true;
    }
}
