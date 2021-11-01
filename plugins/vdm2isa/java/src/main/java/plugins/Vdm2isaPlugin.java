/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package plugins;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.VDMJ;
import com.fujitsu.vdmj.commands.CommandPlugin;
import com.fujitsu.vdmj.config.Properties;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.messages.ConsoleWriter;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.messages.VDMWarning;
import com.fujitsu.vdmj.pog.ProofObligationList;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.modules.TRModule;
import vdm2isa.tr.modules.TRModuleList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.messages.VDM2IsaError;
import vdm2isa.messages.VDM2IsaWarning;
import vdm2isa.tr.types.TRRecordType;

public class Vdm2isaPlugin extends CommandPlugin
{
	private final static List<VDM2IsaError> errors = new Vector<VDM2IsaError>();
	private final static List<VDM2IsaWarning> warnings = new Vector<VDM2IsaWarning>();
	
	// list of VDM warning numbers to raise as errors
	private final static List<Integer> vdmWarningOfInterest = 
		Arrays.asList(5000, 5006, 5007, 5008, 5009, 5010, 5011, 5012, 5013, 
					  5016, 5017, 5018, 5019, 5020, 5021, 5031, 5032, 5033, 5037);
	
  	private TRModuleList translatedModules;

	public static int errs;

	// plugin properties

	// target isabelle version (i.e. result of "isabelle version" call)
	public static String isaVersion; 
	// assuming max translation errors equals max type errors for now
	public static int maxErrors;
	// strict handling of errors (e.g. print output or not etc.)
	public static boolean strict;	
	// determines whether to add "pre_f =>" on post condition definitions
	public static boolean linientPost;
	public static boolean reportWarnings;
	public static boolean printVDMComments;
	public static boolean printIsaComments;
	public static boolean runExu;

	public static void main(String args[])
    {
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-i", "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl"});
    }

	public Vdm2isaPlugin(Interpreter interpreter)
	{
		super(interpreter);
		this.translatedModules = new TRModuleList();
	}

	public TRModuleList getTranslatedModules()
	{
		return this.translatedModules;
	}

	@Override
	//TODO add plugin property about using abbreviations or definitions for TRValueDefinition  
	//TODO add plugin option about raising warnings? or just raise them 
	public boolean run(String[] argv) throws Exception
	{
		boolean result = false;
		if (interpreter instanceof ModuleInterpreter)
		{
			long before = System.currentTimeMillis();
			errs = 0;
			int tcount = 0;

			Vdm2isaPlugin.setupProperties();
	
			Vdm2isaPlugin.reset();

			Vdm2isaPlugin.checkVDMSettings();

			if (Vdm2isaPlugin.runExu)
			{
				ExuPlugin exu = new ExuPlugin(interpreter);
				// plugin run worked if exu's run works
				result = exu.run(argv);
			}
			else
			{
				// plugin run worked
				result = true;
			}

			// VDM errors don't pass VDMJ; some VDM warnings have to be raised as errors to avoid translation issues
			Vdm2isaPlugin.processVDMWarnings();

			ModuleInterpreter minterpreter = (ModuleInterpreter)interpreter;
			TCModuleList tclist = minterpreter.getTC();			

			try
			{
				translatedModules = ClassMapper.getInstance(TRNode.MAPPINGS).init().convert(tclist);

				// be strict on translation output
				if (strict && Vdm2isaPlugin.getErrorCount() == 0)
				{
					for (TRModule module: translatedModules)
					{
						outputModule(module.name, module.translate());
					}
					tcount += translatedModules.size();
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
				errs++;
			}

			long after = System.currentTimeMillis();
			errs = errs + Vdm2isaPlugin.getErrorCount();

			if (errs > 0)
			{
				Vdm2isaPlugin.printErrors(Console.out);
			}

			int warn = Vdm2isaPlugin.getWarningCount();
			
			if (warn > 0 && Vdm2isaPlugin.reportWarnings)
			{
				Vdm2isaPlugin.printWarnings(Console.out);
			}

			Console.out.println("Translated " + plural(tcount, "module", "s") +
				" in " + (double)(after-before)/1000 + " secs. ");
			Console.out.print(errs == 0 ? "No translation errors" :
				"Found " + plural(errs, "translation error", "s"));
			Console.out.print(warn == 0 ? "" : " and " +
				(Vdm2isaPlugin.reportWarnings ? "" : "suppressed ") + plural(warn, "warning", "s") + ".");
			Console.out.println(errs > 0 ? " You must fix the errors first!" : "");
		}
		return result;
	}

	protected /*static*/ void outputModule(TCIdentifierToken moduleName, String result) throws FileNotFoundException
	{
		String dir = moduleName.getLocation().file.getParent();
		if (dir == null) dir = ".";
		String name = moduleName.getName() + ".thy";//module.name.getName().substring(0, module.name.getName().lastIndexOf('.')) + ".thy";
		Console.out.println("Translating module " + moduleName.getName() + " as " + dir + "/" + name);
		File outfile = new File(dir, name);
		PrintWriter out = new PrintWriter(outfile);
		out.write(result);
		out.close();
	}

	@Override
	public String help()
	{
		return "vdm2isa - translate all loaded VDM modules to Isabelle/HOL (v. " + Vdm2isaPlugin.isaVersion + ")";
	}

	public static void checkVDMSettings()
    {
        if (Settings.dialect != Dialect.VDM_SL)
        {
            Vdm2isaPlugin.report(11111, "Only VDMSL supports Isabelle translation", LexLocation.ANY);
            Vdm2isaPlugin.errs++;
        }
        if (Settings.release != Release.VDM_10)
        {
            // This refers to stuff like TCNameToken filtering important names out for CLASSIC say.
            // For now, it only affects TRExplicitFunctionDefinition, but this might get wider. 
            Vdm2isaPlugin.warning(11111, "Isabelle translation is optimal for VDM_10. You might encounter problems with CLASSIC release.", LexLocation.ANY);	
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

	public static void report(int number, String problem, LexLocation location)
	{
		VDM2IsaError error = new VDM2IsaError(number, problem, location);
		if (!errors.contains(error))
		{
			errors.add(error);

    		if (errors.size() >= Vdm2isaPlugin.maxErrors-1)
    		{
    			errors.add(new VDM2IsaError(10, "Too many translation errors", location));
    			throw new InternalException(10, "Too many translation errors");
    		}
		}
	}

	public static void reportAsError(VDMWarning w)
	{
		if (Vdm2isaPlugin.vdmWarningOfInterest.contains(w.number))
		{
			report(11111 + w.number, w.message, w.location);
		}
	}

	public static void warning(int number, String problem, LexLocation location)
	{
		VDM2IsaWarning warning = new VDM2IsaWarning(number, problem, location);

		if (!warnings.contains(warning))
		{
			warnings.add(warning);
		}
	}

	public static void clearErrors()
	{
		errors.clear();
		warnings.clear();
	}

	public static int getErrorCount()
	{
		return errors.size();
	}

	public static int getWarningCount()
	{
		return warnings.size();
	}

	public static List<VDM2IsaError> getErrors()
	{
		return errors;
	}

	public static List<VDM2IsaWarning> getWarnings()
	{
		return warnings;
	}

	public static void printErrors(ConsoleWriter out)
	{
		for (VDM2IsaError e: errors)
		{
			out.println(e.toString());
		}
	}

	public static void printWarnings(ConsoleWriter out)
	{
		for (VDM2IsaWarning w: warnings)
		{
			out.println(w.toString());
		}
	}

	public static String plural(int n, String s, String pl)
	{
		return n + " " + (n != 1 ? s + pl : s);
	}

	private static void reset()
	{
		// reset internal tables in case of restranslation
		Vdm2isaPlugin.clearErrors();
		IsaTemplates.reset();
		TRRecordType.reset();
	}
	
	private static void setupProperties()
	{
		Vdm2isaPlugin.maxErrors 	= Properties.tc_max_errors;
		Vdm2isaPlugin.strict 		= true;
		Vdm2isaPlugin.linientPost 	= false;
		Vdm2isaPlugin.reportWarnings= true;
		Vdm2isaPlugin.isaVersion    = "Isabelle2021: February 2021";
		Vdm2isaPlugin.printVDMComments = true;
		Vdm2isaPlugin.printIsaComments = true;
		Vdm2isaPlugin.runExu			= true;
	}
}
