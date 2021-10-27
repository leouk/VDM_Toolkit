/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package plugins;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.commands.CommandPlugin;
import com.fujitsu.vdmj.config.Properties;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.messages.ConsoleWriter;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.modules.TRModule;
import vdm2isa.tr.modules.TRModuleList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.messages.VDM2IsaError;
import vdm2isa.messages.VDM2IsaWarning;
import vdm2isa.tr.types.TRRecordType;

public class Vdm2isaPlugin extends CommandPlugin
{
	private static List<VDM2IsaError> errors = new Vector<VDM2IsaError>();
	private static List<VDM2IsaWarning> warnings = new Vector<VDM2IsaWarning>();
	// assuming max translation errors equals max type errors for now
	private static int MAX = Properties.tc_max_errors;

	public Vdm2isaPlugin(Interpreter interpreter)
	{
		super(interpreter);
	}

	@Override
	public boolean run(String[] argv) throws Exception
	{
		if (interpreter instanceof ModuleInterpreter)
		{
			// reset internal tables in case of restranslation
			IsaTemplates.reset();
			TRRecordType.reset();

			try
			{
				ModuleInterpreter minterpreter = (ModuleInterpreter)interpreter;
				TCModuleList tclist = minterpreter.getTC();
				TRModuleList trModules = ClassMapper.getInstance(TRNode.MAPPINGS).init().convert(tclist);

				for (TRModule module: trModules)
				{
					String dir = module.name.getLocation().file.getParent();
					if (dir == null) dir = ".";
					String name = module.name.getName() + ".thy";//module.name.getName().substring(0, module.name.getName().lastIndexOf('.')) + ".thy";
					System.out.println("Translating into " + dir + "/" + name);
					File outfile = new File(dir, name);
					PrintWriter out = new PrintWriter(outfile);
					out.write(module.translate());
					out.close();
				}
			}
			catch (Throwable t)
			{
				System.out.println("Exception uncaught " + t.getMessage());
				t.printStackTrace();
				throw t;
			}

			//System.out.println(trModules.translate());
			return true;
		}
		else
		{
			return false;
		}
	}

	@Override
	public String help()
	{
		return "vdm2isa - translate all loaded VDM modules to Isabelle/HOL";
	}

	public static void report(int number, String problem, LexLocation location)
	{
		VDM2IsaError error = new VDM2IsaError(number, problem, location);
		if (!errors.contains(error))
		{
			errors.add(error);

    		if (errors.size() >= MAX-1)
    		{
    			errors.add(new VDM2IsaError(10, "Too many translation errors", location));
    			throw new InternalException(10, "Too many translation errors");
    		}
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
}
