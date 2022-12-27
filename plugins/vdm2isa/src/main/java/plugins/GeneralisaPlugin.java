package plugins;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Vector;
import java.util.Iterator;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.VDMJ;
import com.fujitsu.vdmj.commands.CommandPlugin;
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

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.messages.VDM2IsaError;
import vdm2isa.messages.VDM2IsaWarning;
import vdm2isa.tr.modules.TRModule;

public abstract class GeneralisaPlugin extends CommandPlugin {

    /** 
     * These lists *must* be static to allow TRNode tree to report
     */
    private static final List<VDM2IsaError> errors = new Vector<VDM2IsaError>();
    private static final List<VDM2IsaWarning> warnings = new Vector<VDM2IsaWarning>();

    // list of VDM warning numbers to raise as errors
    protected static final List<Integer> vdmWarningOfInterest = 
        Arrays.asList(5000, 5006, 5007, 5008, 5009, 5010, 5011,
                            5012, 5013, 5016, 5017, 5018, 5019, 5020, 
                            5021, 5031, 5032, 5033, 5037);

    public static final String DEFAULT_SAVEURI = "./.generated"; 

    // Settings are initialised only once per class load
    static {
        IsaProperties.init();
    }

    protected static int created = 0;

    public static final void main(String args[])
    {
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-annotations", "-i"//, "-verbose" 
            , "./lvl0"
            //    ,"./lvl0/TestV2IEmpty.vdmsl"
            //    ,"./lvl0/TestV2IExprs.vdmsl"
            //    ,"./lvl0/TestV2IUseBeforeDecl.vdmsl"
            //    ,"./lvl0/TestV2IDeclBeforeUse.vdmsl"
            //    ,"./lvl0/TestV2IFcns.vdmsl"
            //    ,"./lvl0/TestV2ITypesNamed.vdmsl"
            //    ,"./lvl0/TestV2ITypesOptional.vdmsl"
            //    ,"./lvl0/TestV2ITypesOrdering.vdmsl"
            //    ,"./lvl0/TestV2ITypes.vdmsl"
            //    ,"./lvl0/TestV2ITypesGeneric.vdmsl"
            //    ,"./lvl0/TestV2ITypesNamed.vdmsl"
            //    ,"./lvl0/TestV2ITypesOptional.vdmsl"
            //    ,"./lvl0/TestV2ITypesOrdering.vdmsl"
            //    ,"./lvl0/TestV2ITypesRecordOrdering.vdmsl"
            //    ,"./lvl0/TestV2ITypesRecords.vdmsl"
            //    ,"./lvl0/TestV2ITypesStructured.vdmsl"


            //    ,"lib/VDMToolkit.vdmsl" 
            //    ,"./lvl0/TestV2IBindsComplex.vdmsl"
            //    ,"./lvl0/TestV2IErrors.vdmsl"
            //    ,"./lvl0/TestV2IErrorsToken.vdmsl"            
            //    ,"./lvl0/TestV2IErrorsUnionQuotes.vdmsl"            
            //    ,"./lvl0/TestV2IExprsComplex.vdmsl"
            //    ,"./lvl0/TestV2IExprsComplexMaps.vdmsl"
            //    ,"./lvl0/TestV2IExprsIs.vdmsl"
            //    ,"./lvl0/TestV2IExprsMaps.vdmsl"
            //    ,"./lvl0/TestV2IExprsOptional.vdmsl"
            //    ,"./lvl0/TestV2IExprsRecords.vdmsl"
            //    ,"./lvl0/TestV2IExprsSets.vdmsl"
            //    ,"./lvl0/TestV2IExprsSpecial.vdmsl"
            //    ,"./lvl0/TestV2IExprsToken.vdmsl"
            //    ,"./lvl0/TestV2IFcnsRecursiveComplexNat.vdmsl"
            //    ,"./lvl0/TestV2IFcnsRecursiveNat.vdmsl"
            //    ,"./lvl0/TestV2IFcnsRecursiveSet.vdmsl"
            //    ,"./lvl0/TestV2IModules.vdmsl"
            //    ,"./lvl0/TestV2ITypesComplexRecord.vdmsl"
            //    ,"./lvl0/TestV2ITypesComplexUnion.vdmsl"
            //    ,"./lvl0/TestV2ITypesUnion.vdmsl"
            //    ,"./lvl0/TestV2IWarnings.vdmsl"
            //    ,"./lvl0/TestV2IState.vdmsl"
            //    ,"real/Clocks.vdmsl"
            //    ,"Examples/Alarm/alarm.vdmsl"
            //    ,"Examples/Traffic/traffic.vdmsl"
            //    ,"Examples/Gateway/gateway.vdmsl"
            //    ,"Examples/CMSL/CM.vdmsl"
            //    ,"Examples/CMSL/CMISA.vdmsl"
            //    ,"Examples/CMSL/CMISA.vdmsl"
            //    ,"./lvl0/TestV2IRecursiveMutual.vdmsl"
            //    ,"../../../../annotationsVDMToolkit/src/test/resources/MinimalTheorem.vdmsl"
            //    ,"../../../isa/FMI/Clocks.vdmsl"
        });
    }

    /**
     * These are errors/warnings created by the plugin itself, rather than TRNode tree
     */
    private int localErrors;
    private int localWarnings;
    private int localModules;
    private int called;

    private boolean setup;
    protected final List<String> commands;
    protected final TCModuleList tclist;
    protected final TCModuleList source;
    protected File saveURI; 

    protected final Set<String> modulesToProcess; 

    public GeneralisaPlugin(Interpreter i) {
        super(i);
        if (i != null && !(i instanceof ModuleInterpreter))
            throw new IllegalArgumentException("Plugin interpreter must be a module interpreter");
        this.commands = new ArrayList<String>();
        this.tclist = new TCModuleList();
        this.modulesToProcess = new HashSet<String>();
        this.called = 0;
        this.saveURI = null;
        created++;
        this.setup = false;
        this.source = null;
        this.localReset();
    }

    public GeneralisaPlugin(TCModuleList vscodeModuleList)
    {
        super(null);
        this.commands = new ArrayList<String>();
        this.tclist = new TCModuleList();
        this.source = vscodeModuleList;
        this.modulesToProcess = new HashSet<String>();
        this.called = 0;
        created++;
        this.setup = false;
        this.localReset();
    }

    protected boolean calledFromVDMJ()
    {
        return interpreter != null; 
    } 

    protected TCModuleList getTC()
    {
        if (calledFromVDMJ())
        {
            assert interpreter != null;
            ModuleInterpreter minterpreter = (ModuleInterpreter)interpreter;
            return minterpreter.getTC();			
        }
        else 
        {
            assert source != null;
            return source;
        }
    }

    protected void localReset()
    {
        localErrors = 0;
        localWarnings = 0;
        localModules = 0;
        //No need for setup multiple times per run over the same module list
        //only reset that per creation (i.e. per reload)
        //setup = false;
        commands.clear();
        //leave it a set ml all!
        //modulesToProcess.clear();

        tclist.clear();
        tclist.addAll(getTC());
    }

    protected boolean processArguments(String[] args)
    {
        assert args != null && args.length > 0;
        List<String> largs = Arrays.asList(args);
        Iterator<String> i = largs.iterator();
        boolean cont_ = true;
        assert largs.size() > 0 && largs.get(0).equals(pluginName()); 
        i.next(); // first argument is plugin name itself.
        if (!i.hasNext())
        {
            i = validCommands().iterator();
            cont_ = processArgument0(i);
        }
        else
        {
            cont_ = processArgument0(i);
        }
        return cont_;
    }

    protected boolean processArgument0(Iterator<String> i)
    {
        boolean cont_ = true;
        while (i.hasNext() && cont_)
        {
            String arg = i.next();
            cont_ = processArgument(arg, i);
        }
        return cont_;
    }

    protected void mergeCommands(List<String> cmds)
    {
        for(String cmd : cmds)
        {
            if (!commands.contains(cmd))
                commands.add(cmd);
        }
    }

    protected void mergeCommands(GeneralisaPlugin other)
    {
        mergeCommands(other.commands);
    }

    protected void printFlag(String name, String val)
	{
		Console.out.println(String.format("%1$s flag is %2$s", name, val));
	}

	protected void printFlag(String name, boolean flag)
	{
		Console.out.println(String.format("%1$s flag is %2$s", name, flag ? "enabled" : "disabled"));
	}

    protected void printOptionDefaults()
    {
        printFlag("Isabelle version", IsaProperties.general_isa_version); 
        printFlag("max errors", String.valueOf(IsaProperties.general_max_errors));
        printFlag("strict", IsaProperties.general_strict);	
        printFlag("report warnings", IsaProperties.general_report_vdm_warnings);
        printFlag("debug", IsaProperties.general_debug);
        printFlag("modules to process", modulesToProcess.isEmpty() ? "all" : modulesToProcess.toString());
        printFlag("URI to save translation", saveURI == null ? GeneralisaPlugin.DEFAULT_SAVEURI : saveURI.toURI().toString());
    }

    protected boolean processArgument(String arg, Iterator<String> i)
    {
        if (arg.equals("set"))
        {
            if (!i.hasNext())
            {
                printOptionDefaults();
            }
            else 
            {
                String prop = i.next();
                if (i.hasNext())
                {
                    String val = i.next();
                    doSet(prop, val);
                }
                else 
                    usage("Set command requires two arguments");
            }
        }
        else if (arg.equals("help"))
        {
            usage("");
        }
        else 
            usage("Unknown command " + arg);
        return false; // don't continue if hit here.
    }

    protected void doSet(String prop, String val)
    {
        if (prop.equals("strict"))
        {
            IsaProperties.general_strict = Boolean.parseBoolean(val);
        }
        else if (prop.equals("me"))
        {
            try
            {
                IsaProperties.general_max_errors = Long.parseLong(val);
            }
            catch (NumberFormatException e)
            {
                usage("me property expects a number - " + val);
            }
        }
        else if (prop.equals("w"))
        {
            IsaProperties.general_report_vdm_warnings = Boolean.parseBoolean(val);
        }
        else if (prop.equals("debug"))
        {
            IsaProperties.general_debug = Boolean.parseBoolean(val);
        }
        else if (prop.equals("ml"))
        {
            if ("all".equals(val))
                modulesToProcess.clear();
            else 
            {
                String[] mods = val.split(",|;|:|\\|");
                modulesToProcess.clear();
                modulesToProcess.addAll(Arrays.asList(mods));    
            }
   
        }
        else if (prop.equals("o"))
        {
            saveURI = null; // default = GeneralisaPlugin.DEFAULT_SAVEURI
            try
            {
                File f = new File(val);
                if (f.isDirectory())
                {
                    saveURI = f;
                }
                else if (!f.exists())
                {
                    Path p = createOutputDirectory(f, pluginName());
                    saveURI = p.toFile();
                }

                if (saveURI == null || !saveURI.isDirectory())
                {
                    usage("Save location must be a directory: " + val);
                    saveURI = null;
                }
            }
            catch (IOException e)
            {
                usage("Could not create directory " + val);
            }
        }
        else 
            usage("Invalid property to set - " + prop);
    }

    protected String getSummaryPrefix()
    {
        return "Translated ";
    }

    public void usage(String msg)
    {
        StringBuilder sb = new StringBuilder();    
        if (!(msg == null || msg.isEmpty()))
            sb.append(String.format("%1$s: %2$s\n", pluginName(), msg));
        sb.append(String.format("Usage: %1$s [<cmds>] [<options>]\n", pluginName()));
        sb.append("\tCommands:\n");
        sb.append(commandsHelp());
        sb.append("\n\tOptions:\n");
        sb.append(optionsHelp());
        sb.append("\n\tDefault commands: ");
        sb.append(validCommands());
        sb.append("\n\tDefault options : ");
        sb.append(options());
        sb.append("\n");
        Console.err.println(sb.toString());
    }

    protected abstract String pluginName();

    protected String commandsHelp()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("\tset  : sets available options, e.g. \"set [<opt> <val>]\"\n");
        sb.append("\thelp : shows usage help\n");
        return sb.toString();
    }

    protected void prompt()
    {
        if (IsaProperties.general_debug)
            Console.out.println(pluginName() + " plugin with commands `" + commands.toString() + "` and options " + options() + "\n");
    }

    protected abstract List<String> validCommands();

    protected String options()
    {
        return String.format("strict=%1$s me=%2$s isa=%3$s w=%4$s debug=%5$s ml=%6$s o=%7$s", 
            IsaProperties.general_strict, IsaProperties.general_max_errors, 
            IsaProperties.general_isa_version, IsaProperties.general_report_vdm_warnings, 
            IsaProperties.general_debug, modulesToProcess.isEmpty() ? "all" : modulesToProcess.toString(), 
            saveURI == null ? GeneralisaPlugin.DEFAULT_SAVEURI : saveURI.toURI().toString());
    }

    protected String optionsHelp()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("\tstrict  : no translation output in case of errors\n");
        sb.append("\tme <num>: maximum number of errors before stop processing\n");
        //sb.append("\tisa <name>: translation target Isabelle version\n");
        sb.append("\tw       : reports (or supresses) warnings\n");
        sb.append("\tdebug   : runs in debug mode\n");
        sb.append("\tml <lst>: comma-separated list of modules to process, or `all`; all modules if not set\n");
        sb.append("\to <dir> : valid directory to save Isabelle files\n");
        return sb.toString();   
    }

    public void summarise(boolean result, long execTimeMs, int modSize) {
        Console.out.println(getSummaryPrefix() + 
            plural(getLocalModuleCount(), "module", "s") +
            " (of " + modSize + ")" +
            " in " + (double)(execTimeMs/1000) + " secs. ");
        int errCnt = getLocalErrorCount(); 
        int wrnCnt = getLocalWarningCount();
        if (errCnt == 0)
        {
            Console.out.print("No errors were found.");
            if (wrnCnt > 0)
                Console.out.println(" Found " + 
                    (IsaProperties.general_report_vdm_warnings ? "" : "(and suppressed) ") +
                    plural(wrnCnt, "warning", "s") + ".");
            else 
                Console.out.print("\n");
        }
        else 
        {
            Console.out.print("Found " + plural(errCnt, "error", "s"));
            if (wrnCnt > 0)
                Console.out.println(" and " + 
                (IsaProperties.general_report_vdm_warnings ? "" : "suppressed ") +
                plural(wrnCnt, "warning", "s") + ".");
            else 
                Console.out.print(".\n");
        }
        if (errCnt > 0 && result)
            Console.out.println("Proceeding with translation with remaining issues may lead to Isabelle errors!");
        if (!result)
            Console.out.println(pluginName() + " plugin execution failed"); 
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
        boolean result = true;
        
        long before = System.currentTimeMillis();
        
        called++;
        if (IsaProperties.general_debug)    
            Console.out.println("***" + pluginName() + " CREATED = " + created + "; RUN = " + called + "; errCnt = " + getErrorCount());

        GeneralisaPlugin.fullReset(this);
        GeneralisaPlugin.checkVDMSettings();

        boolean cont_ = processArguments(argv);
        TCModuleList tclist_filtered = GeneralisaPlugin.filterModuleList(tclist, modulesToProcess);        
        if (tclist_filtered.isEmpty())
        {
            Console.out.println("No modules to process; call `" + pluginName() + " set` to check!");
        }
        else if (cont_)
        {
            if (!commands.isEmpty())
            {
                result = doCommands(tclist_filtered);
                
                long after = System.currentTimeMillis();
                addLocalErrors(GeneralisaPlugin.getErrorCount());
                if (getLocalErrorCount() > 0)
                {
                    GeneralisaPlugin.printErrors(Console.out);
                    result = !IsaProperties.general_strict;
                }
        
                addLocalWarnings(GeneralisaPlugin.getWarningCount());
                if (getLocalWarningCount() > 0 && IsaProperties.general_report_vdm_warnings)
                {
                    GeneralisaPlugin.printWarnings(Console.out);
                }
                summarise(result, after-before, tclist_filtered.size());            
            }
            else 
            {
                Console.out.println("No command to run?");
                result = false;
            }
        }      
        return result;
    }

    private boolean doCommands(TCModuleList tclist)
    {
        prompt();
        
        boolean result = true;
        Iterator<String> it = commands.iterator();
        List<String> validCmds = validCommands();
        while (it.hasNext() && result)
        {
            String cmd = it.next();
            result = validCmds.contains(cmd);
            if (result)
            {
                if (!setupDone())
                {
                    // perform any initial setup  
                    result = setup(); 
                    setup = true;
                }
            }
            else 
                GeneralisaPlugin.report(IsaErrorMessage.PLUGIN_UNKNOWN_COMMAND_2P, LexLocation.ANY, cmd, pluginName());
            if (result)
                result = runCommand(cmd, tclist);
        }
        return result;
    }

    /**
     * Useful for plugins calling other plugins and don't need other processing but just run+reset
     * @param tclist
     * @return
     * @throws Exception
     */
    protected final boolean internalRun(TCModuleList tclist) 
    {
        boolean result = doCommands(tclist);

        // clear error messages to avoid duplication
        if (result)
        {	
            GeneralisaPlugin.fullReset(this);
        }
        return result;
    }

    /**
     * Each plugin extension will have various commands they can execute. Settings are passed/made before running, so no parameters
     * This is useful so that both VDMJ Command, LSP Command, and LSP Plugin behaviours will be the same over the given TCModuleList, 
     * regardless of where they originated from. 
     * @param name command to run
     * @param tclist type checked list to run command through 
     * @return whether the command run succeeded. 
     */
    protected abstract boolean runCommand(String name, TCModuleList tclist);

    /**
     * Method called before running commands, to setup the plugin. 
     * If called multiple times, will only be exeucted once, until setup done flag is reset.
     * @return
     */
    protected abstract boolean setup();

    protected final boolean setupDone()
    {
        return setup;
    }

    public final void processException(Throwable t, String workingAt, boolean printStackTrace)
    {
        Console.out.println("Uncaught exception whilst working at `" + workingAt + "`: " + t.toString());
        if (printStackTrace)
            t.printStackTrace();
        addLocalErrors(1);
    }

    protected static Path createOutputDirectory(File f, String plugin) throws IOException
    {
        String dir; 
		// if no saveURI is set, then use the "default" 
		if (f == null)
		{
			dir = GeneralisaPlugin.DEFAULT_SAVEURI; 
		}
		else 
		{
			dir = f.getPath();     		
		}
		try 
		{
            return Files.createDirectories(Paths.get(dir));            
		}         
        catch (IOException e)
        {
            GeneralisaPlugin.report(IsaErrorMessage.PLUGIN_INVALID_SAVE_URI_3P, LexLocation.ANY, plugin, dir, e.getMessage());
            throw e;
        }
    }

    protected void processOutput(LexLocation location, String moduleName, String output) throws IOException, FileNotFoundException
	{
		// only consider generating output if no errors when strict, or with errors when not strict
		// strict => errorCount = 0
		if (!IsaProperties.general_strict || getLocalErrorCount() == 0)
		{
			// if no saveURI was given, only output if called from VDMJ 
			// that is, if called from LSP, and have no saveURI set, then it's just at 
			// analysis time, and result of translation doesn't need to be output. 
			// saveURI == null => calledFromVDMJ
			if (saveURI != null || calledFromVDMJ())
				outputModule(location, moduleName, output);  
		}
	}
    
    private /* static */ void outputModule(LexLocation location, String module, String result) throws IOException, FileNotFoundException
	{
        Path dir = createOutputDirectory(saveURI, pluginName());
		String name = module + ".thy";//module.name.getName().substring(0, module.name.getName().lastIndexOf('.')) + ".thy";
		File outfile = new File(dir.toFile(), name);
        Console.out.println("Translating module " + module + " as " + outfile.getAbsolutePath());
		PrintWriter out = new PrintWriter(outfile);
		out.write(result);
		out.close();
	}

    public static final TCModuleList filterModuleList(TCModuleList tclist, Set<String> modules)
    {
        TCModuleList result = new TCModuleList(); 
        result.addAll(tclist);
        Iterator<TCModule> mi = result.iterator();
        while (mi.hasNext())
        {
            TCModule m = mi.next();
            String name = m.name.getName();
            if (name.equals(IsaToken.VDMTOOLKIT.toString()) || 
               (!modules.isEmpty() && !modules.contains(name)))
            {
                mi.remove();
            }
        } 
        return result;
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

    public static void fullReset(GeneralisaPlugin g)
    {
        GeneralisaPlugin.reset();
        g.localReset();
    }

    public static void reset() {
        // reset internal tables in case of restranslation
        GeneralisaPlugin.clearErrors();
    }

    public static final void reportAsError(VDMWarning w) {
        if (GeneralisaPlugin.vdmWarningOfInterest.contains(w.number)) {
            report(/*VDM2IsaWarning.ISABELLE_WARNING_BASE +*/ w.number, w.message, w.location);
        }
    }

    public static final void processVDMWarnings(List<VDMWarning> vdmWarnings, boolean reportFoundAsError)
	{
		int warnings2raiseCount = 0;
		// tad inneficient, but fine (for now) as I want to "warn" user of this first
		for (int i = 0; i < vdmWarnings.size(); i++)
		{
			if (GeneralisaPlugin.vdmWarningOfInterest.contains(vdmWarnings.get(i).number))
				warnings2raiseCount++;
		}
		if (warnings2raiseCount > 0)
		{
			if (reportFoundAsError)
                Console.out.println("Some VDM warnings are not tolerated: raising " + warnings2raiseCount + " warnings as errors.");
			for(VDMWarning w : vdmWarnings)
			{
                if (reportFoundAsError)
    				reportAsError(w);
                else 
                    warning(w.number, w.message, w.location);
			}
		}
	}
}
