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

    private static final List<VDM2IsaError> errors = new Vector<VDM2IsaError>();
    private static final List<VDM2IsaWarning> warnings = new Vector<VDM2IsaWarning>();

    // list of VDM warning numbers to raise as errors
    private static final List<Integer> vdmWarningOfInterest = 
        Arrays.asList(5000, 5006, 5007, 5008, 5009, 5010, 5011,
                            5012, 5013, 5016, 5017, 5018, 5019, 5020, 
                            5021, 5031, 5032, 5033, 5037);

    private int localErrors;
    private int localWarnings;
    private int localModules;

    public static final void main(String args[])
    {
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-annotations", "-i", "-verbose" 
            //    ,"TestV2IEmpty.vdmsl"
            //    ,"lib/VDMToolkit.vdmsl" 
            //    ,"TestV2IBindsComplex.vdmsl"
            //    ,"TestV2IUseBeforeDecl.vdmsl"
            //    ,"TestV2IDeclBeforeUse.vdmsl"
            //    ,"TestV2IErrors.vdmsl"
            //    ,"TestV2IErrorsToken.vdmsl"            
            //    ,"TestV2IErrorsUnionQuotes.vdmsl"            
            //    ,"TestV2IExprs.vdmsl"
            //    ,"TestV2IExprsComplex.vdmsl"
            //    ,"TestV2IExprsComplexMaps.vdmsl"
            //    ,"TestV2IExprsIs.vdmsl"
            //    ,"TestV2IExprsMaps.vdmsl"
            //    ,"TestV2IExprsOptional.vdmsl"
            //    ,"TestV2IExprsRecords.vdmsl"
            //    ,"TestV2IExprsSets.vdmsl"
            //    ,"TestV2IExprsSpecial.vdmsl"
            //    ,"TestV2IExprsToken.vdmsl"
            //    ,"TestV2IFcns.vdmsl"
            //    ,"TestV2IFcnsRecursiveComplexNat.vdmsl"
            //    ,"TestV2IFcnsRecursiveNat.vdmsl"
            //    ,"TestV2IFcnsRecursiveSet.vdmsl"
            //    ,"TestV2IModules.vdmsl"
            //    ,"TestV2ITypes.vdmsl"
            //    ,"TestV2ITypesComplexRecord.vdmsl"
            //    ,"TestV2ITypesComplexUnion.vdmsl"
            //    ,"TestV2ITypesGeneric.vdmsl"
            //    ,"TestV2ITypesNamed.vdmsl"
            //    ,"TestV2ITypesOptional.vdmsl"
            //    ,"TestV2ITypesOrdering.vdmsl"
            //    ,"TestV2ITypesRecordOrdering.vdmsl"
            //    ,"TestV2ITypesRecords.vdmsl"
            //    ,"TestV2ITypesStructured.vdmsl"
            //    ,"TestV2ITypesUnion.vdmsl"
            //    ,"TestV2IWarnings.vdmsl"
            //    ,"TestV2IState.vdmsl"
            //    ,"real/Clocks.vdmsl"
            //    ,"Examples/Alarm/alarm.vdmsl"
            //    ,"Examples/Traffic/traffic.vdmsl"
            //    ,"Examples/Gateway/gateway.vdmsl"
            //    ,"Examples/CMSL/CM.vdmsl"
            //    ,"Examples/CMSL/CMISA.vdmsl"
            //    ,"Examples/CMSL/CMISA.vdmsl"
            //    ,"TestV2IRecursiveMutual.vdmsl"
            //    ,"../../../../annotationsVDMToolkit/src/test/resources/MinimalTheorem.vdmsl"
                ,"../../../isa/FMI/Clocks.vdmsl"
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

    public void summarise(long execTimeMs, int modSize) {
        Console.out.println(getSummaryPrefix() + 
            plural(getLocalModuleCount(), "module", "s") +
            " (of " + modSize + ")" +
            " in " + (double)(execTimeMs/1000) + " secs. ");
        Console.out.print(getLocalErrorCount() == 0 ? "No issues" :
            "Found " + plural(getLocalErrorCount(), "issues", "s"));
        Console.out.print(getLocalWarningCount() == 0 ? "" : " and " +
            (IsaProperties.general_report_vdm_warnings ? "" : "suppressed ") + plural(getLocalWarningCount(), "warning", "s") + ".");
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

    protected static final TCModuleList filterModuleList(TCModuleList tclist)
    {
        TCModuleList result = new TCModuleList(); 
        result.addAll(tclist);
        Iterator<TCModule> mi = result.iterator();
        while (mi.hasNext())
        {
            if (mi.next().name.getName().equals(IsaToken.VDMTOOLKIT.toString()))
            {
                mi.remove();
                break;
            }
        } 
        return result;
    } 

    @Override
    public final boolean run(String[] argv) throws Exception {
        boolean result = false;
        if (interpreter instanceof ModuleInterpreter)
		{
			long before = System.currentTimeMillis();
            
			GeneralisaPlugin.fullReset(this);
            GeneralisaPlugin.checkVDMSettings();

			// VDM errors don't pass VDMJ; some VDM warnings have to be raised as errors to avoid translation issues
			GeneralisaPlugin.processVDMWarnings();

            ModuleInterpreter minterpreter = (ModuleInterpreter)interpreter;
			TCModuleList tclist = minterpreter.getTC();			

            TCModuleList tclist_filtered = GeneralisaPlugin.filterModuleList(tclist);

            //if (argv != null && argv.length > 0)
            //    Console.out.println("Params = " + Arrays.asList(argv).toString());
            result = isaRun(tclist_filtered, argv);

            long after = System.currentTimeMillis();
			addLocalErrors(GeneralisaPlugin.getErrorCount());
			if (getLocalErrorCount() > 0)
			{
				GeneralisaPlugin.printErrors(Console.out);
			}

			addLocalWarnings(GeneralisaPlugin.getWarningCount());
			if (getLocalWarningCount() > 0 && IsaProperties.general_report_vdm_warnings)
			{
				GeneralisaPlugin.printWarnings(Console.out);
			}
            summarise(after-before, tclist_filtered.size());
        }
        return result;
    }

    public final void processException(Throwable t, String workingAt, boolean printStackTrace)
    {
        Console.out.println("Uncaught exception whilst working at `" + workingAt + "`: " + t.toString());
        if (printStackTrace)
            t.printStackTrace();
        addLocalErrors(1);
    }
    
    protected /* static */ void outputModule(LexLocation location, String module, String result) throws FileNotFoundException
	{
		String dir = location.file.getParent();
		if (dir == null) dir = ".";
		String name = module + ".thy";//module.name.getName().substring(0, module.name.getName().lastIndexOf('.')) + ".thy";
		File outfile = new File(dir + "/.generated", name);
		Console.out.println("Translating module " + module + " as " + outfile.getAbsolutePath());
		PrintWriter out = new PrintWriter(outfile);
		out.write(result);
		out.close();
	}

    public static final void checkVDMSettings()
    {
        if (Settings.dialect != Dialect.VDM_SL)
        {
            GeneralisaPlugin.report(IsaErrorMessage.VDMSL_VDM10_ONLY, LexLocation.ANY);
        }
        if (Settings.release != Release.VDM_10)
        {
            // This refers to stuff like TCNameToken filtering important names out for CLASSIC say.
            // For now, it only affects TRExplicitFunctionDefinition, but this might get wider. 
            GeneralisaPlugin.warning(IsaWarningMessage.VDMSL_VDM10_ONLY, LexLocation.ANY);	
        }
    }

	public static final void report(IsaErrorMessage message, LexLocation location)
	{
		report(message, location, (Object[])null);
	}

	public static final void report(IsaErrorMessage message, LexLocation location, Object... args)
	{
		report(message.number, message.format(args), location);
	}

    public static final void report(int number, String problem, LexLocation location) {
        VDM2IsaError error = new VDM2IsaError(number, problem, location);
        if (!errors.contains(error)) {
            errors.add(error);

            if (errors.size() >= IsaProperties.general_max_errors - 1) 
            {
				String tooMany = "Too many translation errors (> " + 
                    IsaProperties.general_max_errors + "); increase ``maxErrors'' input parameter.";
                //TODO: @NB, how best to report this in the LSP?
                // workspace.Diag.severe(tooMany);
                // workspace.Diag.severe(String.valueOf(errors.size()));
                // workspace.Diag.severe(errors.toString());
    			errors.add(new VDM2IsaError(10, tooMany, location));
    			InternalException ie = new InternalException(10, tooMany);
                throw ie;
            }
        }
    }

    public static final void reportAsError(VDMWarning w) {
        if (GeneralisaPlugin.vdmWarningOfInterest.contains(w.number)) {
            report(/*VDM2IsaWarning.ISABELLE_WARNING_BASE +*/ w.number, w.message, w.location);
        }
    }

    public static final void processVDMWarnings()
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

	public static final void warning(IsaWarningMessage message, LexLocation location)
	{
		warning(message, location, (Object[])null);
	}

	public static final void warning(IsaWarningMessage message, LexLocation location, Object... args)
	{
		warning(message.number, message.format(args), location);
	}

    public static final void warning(int number, String problem, LexLocation location) {
        VDM2IsaWarning warning = new VDM2IsaWarning(number, problem, location);

        if (!warnings.contains(warning)) {
            warnings.add(warning);
        }
    }

    public static final void clearErrors() {
        GeneralisaPlugin.errors.clear();
        GeneralisaPlugin.warnings.clear();
    }

    public static final int getErrorCount() {
        return GeneralisaPlugin.errors.size();
    }

    public static final int getWarningCount() {
        return GeneralisaPlugin.warnings.size();
    }

    public static final List<VDM2IsaError> getErrors() {
        return GeneralisaPlugin.errors;
    }

    public static final List<VDM2IsaWarning> getWarnings() {
        return GeneralisaPlugin.warnings;
    }

    public static final void printErrors(ConsoleWriter out) {
        //if (Vdm2isaPlugin.getErrorCount() > 0) Vdm2isaPlugin.printErrors(out);
        for (VDM2IsaError e : GeneralisaPlugin.errors) {
            out.println(e.toString());
        }
    }

    public static final void printWarnings(ConsoleWriter out) {
        //if (Vdm2isaPlugin.getWarningCount() > 0) Vdm2isaPlugin.printWarnings(out);
        for (VDM2IsaWarning w : GeneralisaPlugin.warnings) {
            out.println(w.toString());
        }
    }

    public static final String plural(int n, String s, String pl) {
        return n + " " + (n != 1 ? s + pl : s);
    }

    protected static void fullReset(GeneralisaPlugin g)
    {
        GeneralisaPlugin.reset();
        g.localReset();
    }

    protected static void reset() {
        // read properties file if any
        IsaProperties.init();
        // reset internal tables in case of restranslation
        GeneralisaPlugin.clearErrors();
    }
}
