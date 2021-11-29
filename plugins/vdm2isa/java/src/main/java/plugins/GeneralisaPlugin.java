package plugins;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.Vector;
import java.util.Iterator;

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
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.messages.VDM2IsaError;
import vdm2isa.messages.VDM2IsaWarning;

public abstract class GeneralisaPlugin extends CommandPlugin {

    private final static List<VDM2IsaError> errors = new Vector<VDM2IsaError>();
    private final static List<VDM2IsaWarning> warnings = new Vector<VDM2IsaWarning>();

    // list of VDM warning numbers to raise as errors
    private final static List<Integer> vdmWarningOfInterest = Arrays.asList(5000, 5006, 5007, 5008, 5009, 5010, 5011,
            5012, 5013, 5016, 5017, 5018, 5019, 5020, 5021, 5031, 5032, 5033, 5037);

	// target isabelle version (i.e. result of "isabelle version" call)
	public static String isaVersion; 
	// assuming max translation errors equals max type errors for now
	public static int maxErrors;
	// strict handling of errors (e.g. print output or not etc.)
	public static boolean strict;	
    // whether to report or hide warnings
	public static boolean reportWarnings;


    protected static int errs;
    private int localErrors;
    private int localWarnings;
    private int localModules;

    public static void main(String args[])
    {
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-i", 
                "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/VDMToolkit.vdmsl"

            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprs.vdmsl"
            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsRecords.vdmsl"
            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsMaps.vdmsl"
            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsOptional.vdmsl"
            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsComplex.vdmsl"
            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsIs.vdmsl"

            //      ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IBindsComplex.vdmsl"

                ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl"

            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypes.vdmsl"
            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesNamed.vdmsl"
            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesRecords.vdmsl"
            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesStructured.vdmsl"
           //     , "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesUnion.vdmsl"
            //    ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/real/Clocks.vdmsl"
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

			// VDM errors don't pass VDMJ; some VDM warnings have to be raised as errors to avoid translation issues
			GeneralisaPlugin.processVDMWarnings();

            ModuleInterpreter minterpreter = (ModuleInterpreter)interpreter;
			TCModuleList tclist = minterpreter.getTC();			

            TCModuleList tclist_filtered = new TCModuleList(); 
            tclist_filtered.addAll(tclist);
            Iterator<TCModule> mi = tclist_filtered.iterator();
            while (mi.hasNext())
            {
                if (mi.next().name.getName().equals(IsaToken.VDMTOOLKIT.toString()))
                {
                    mi.remove();
                    break;
                }
            } 

            //if (argv != null && argv.length > 0)
            //    Console.out.println("Params = " + Arrays.asList(argv).toString());
            result = isaRun(tclist_filtered, argv);

            long after = System.currentTimeMillis();
			//addLocalErrors(Vdm2isaPlugin.getErrorCount());
			addLocalErrors(GeneralisaPlugin.getErrorCount());
			if (getLocalErrorCount() > 0)
			{
				GeneralisaPlugin.printErrors(Console.out);
			}

			//addLocalWarnings(Vdm2isaPlugin.getWarningCount());
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
            GeneralisaPlugin.report(IsaErrorMessage.VDMSL_VDM10_ONLY, LexLocation.ANY);
            errs++;
        }
        if (Settings.release != Release.VDM_10)
        {
            // This refers to stuff like TCNameToken filtering important names out for CLASSIC say.
            // For now, it only affects TRExplicitFunctionDefinition, but this might get wider. 
            GeneralisaPlugin.warning(IsaWarningMessage.VDMSL_VDM10_ONLY, LexLocation.ANY);	
        }
    }

	public static void report(IsaErrorMessage message, LexLocation location)
	{
		report(message, location, (Object[])null);
	}

	public static void report(IsaErrorMessage message, LexLocation location, Object... args)
	{
		report(message.number, message.format(args), location);
	}

    public static void report(int number, String problem, LexLocation location) {
        VDM2IsaError error = new VDM2IsaError(number, problem, location);
        if (!errors.contains(error)) {
            errors.add(error);

            if (errors.size() >= GeneralisaPlugin.maxErrors - 1) 
            {
				String tooMany = "Too many translation errors";
    			errors.add(new VDM2IsaError(10, tooMany, location));
    			throw new InternalException(10, tooMany);
            }
        }
    }

    public static void reportAsError(VDMWarning w) {
        if (GeneralisaPlugin.vdmWarningOfInterest.contains(w.number)) {
            report(/*VDM2IsaWarning.ISABELLE_WARNING_BASE +*/ w.number, w.message, w.location);
        }
    }

    public static void processVDMWarnings()
	{
		List<VDMWarning> vdmWarnings = TypeChecker.getWarnings();
		int warnings2raiseCount = 0;
		// tad inneficient, but fine (for now) as I want to "warn" user of this first
		for (int i = 0; i < vdmWarnings.size(); i++)
		{
			if (vdmWarningOfInterest.contains(vdmWarnings.get(i).number))
				warnings2raiseCount++;
		}
		if (warnings2raiseCount > 0)
		{
			Console.out.println("Some VDM warnings are not tolerated: raising " + warnings2raiseCount + " warnings as errors.");
			for(VDMWarning w : vdmWarnings)
			{
				reportAsError(w);
			}
		}
	}

	public static void warning(IsaWarningMessage message, LexLocation location)
	{
		warning(message, location, (Object[])null);
	}

	public static void warning(IsaWarningMessage message, LexLocation location, Object... args)
	{
		warning(message.number, message.format(args), location);
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
        //if (Vdm2isaPlugin.getErrorCount() > 0) Vdm2isaPlugin.printErrors(out);
        for (VDM2IsaError e : GeneralisaPlugin.errors) {
            out.println(e.toString());
        }
    }

    public static void printWarnings(ConsoleWriter out) {
        //if (Vdm2isaPlugin.getWarningCount() > 0) Vdm2isaPlugin.printWarnings(out);
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
		// These are now a tc-tr.mappings init actions
        //IsaTemplates.reset();
		//TRRecordType.reset();
    }

    public static void setupProperties() {
        GeneralisaPlugin.errs = 0;
        GeneralisaPlugin.strict = false;
        GeneralisaPlugin.maxErrors = 2 * Properties.tc_max_errors;
        GeneralisaPlugin.isaVersion = "Isabelle2021: February 2021";
        GeneralisaPlugin.reportWarnings = true;
    }
}
