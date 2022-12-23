/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package plugins;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.modules.TRModule;
import vdm2isa.tr.modules.TRModuleList;

public class Vdm2isaPlugin extends GeneralisaPlugin
{
	private TRModuleList translatedModules;
	//TODO consider extending ExuPlugin?
	private ExuPlugin exu;

	public Vdm2isaPlugin(Interpreter interpreter)
	{
		super(interpreter);
		this.exu = new ExuPlugin(interpreter);
		this.translatedModules = new TRModuleList();
	}

	public TRModuleList getTranslatedModules()
	{
		return this.translatedModules;
	}

	@Override 
	protected void localReset()
	{
		super.localReset();
		// no need to clear before construction; already empty
		if (translatedModules != null)
			translatedModules.clear();
	}

	@Override
    protected void prompt()
    {
        Console.out.println("Calling VDM to " + IsaProperties.general_isa_version + " translator...");
        super.prompt();
    }

    @Override 
    protected boolean setup()
    {
        return false;
    }

	@Override 
    protected boolean runCommand(String name, TCModuleList tclist)
    {
        return false;
    }

    @Override
	public boolean isaRun(TCModuleList tclist) throws Exception 
	{
        boolean result = !commands.isEmpty() && !tclist.isEmpty();
		if (result)
		{
	        // VDM errors don't pass VDMJ typechecker; 
			// some VDM warnings have to be raised as errors to avoid translation issues
			Vdm2isaPlugin.processVDMWarnings(TypeChecker.getWarnings(), true);
			if (commands.contains("exu"))
			{
				result = exu.internalRun(tclist);
			}
			
			// if not strict, then absorb bad exu results
			// strict => result
			result = (!IsaProperties.general_strict || result);
			if (result)
			{
				String workingAt = "";
				try
				{
					// class map TC -> TR trees + set them up
					workingAt = "TC nodes class mapping";
					translatedModules = ClassMapper.getInstance(TRNode.MAPPINGS).init().convert(tclist);
					workingAt = "TR nodes setup";
					translatedModules.setup();

					//TODO issue "lemma finiteness" of involved dom/rng set for map comp at TLD! As a search through!
					//TODO issue "lemmas XYZ"

					// be strict on translation output
					// strict => GeneralisaPlugin.getErrorCount() == 0
					result = (!IsaProperties.general_strict || GeneralisaPlugin.getErrorCount() == 0);
					if (result)
					{
						int mcount = 0;
						String moduleName;
						for (TRModule module : translatedModules)
						{
							moduleName = module.name.getName();
							workingAt = "translating module " + moduleName;
							outputModule(module.getLocation(), moduleName, module.translate());  
							mcount++;
						}
						// only successful output calls
						addLocalModules(mcount);//translatedModules.size());

						// strict => must have translated (mcount) same as modules known
						result = (!IsaProperties.general_strict || mcount == translatedModules.size());
					}
				}
				catch (InternalException e)
				{
					processException(e, workingAt, false);
					result = false;
				}
				catch (Throwable t)
				{
					processException(t, workingAt, true);
					result = false;
				}
			}
		}
		return result;
	}

	@Override
	public String help()
	{
		return "vdm2isa - translate all loaded VDM modules to Isabelle/HOL (v. " + IsaProperties.general_isa_version + ")";
	}

	@Override 
    protected String pluginName()
    {
        return "vdm2isa";
    }

	@Override
    protected void printOptionDefaults()
    {
		if (IsaProperties.vdm2isa_run_exu)
			exu.printOptionDefaults();
		else
	        super.printOptionDefaults();
        printFlag("linient post", IsaProperties.vdm2isa_linient_post);
        printFlag("print VDM comments", IsaProperties.vdm2isa_print_vdm_comments);
        printFlag("print Isabelle comments", IsaProperties.vdm2isa_print_isa_comments);
        printFlag("run Exu plugin", IsaProperties.vdm2isa_run_exu);
        printFlag("translate min/max definitions", IsaProperties.vdm2isa_translate_typedef_min_max);
        printFlag("print VDM source locations", IsaProperties.vdm2isa_print_locations);
        printFlag("print VDM source", IsaProperties.vdm2isa_print_vdm_source);
        printFlag("translate VDM values as abbreviation", IsaProperties.vdm2isa_value_as_abbreviation); 
    }

	@Override
    protected boolean processArgument(String arg, Iterator<String> i)
    {
		boolean result;
        if (arg.equals("exu") && !commands.contains(arg) && IsaProperties.vdm2isa_run_exu)
        {
            result = commands.add(arg);
			if (result)
			{
				result = exu.processArgument0(exu.defaultCommands().iterator());
				mergeCommands(exu);
			}
        }
        else if (arg.equals("translate") && !commands.contains(arg))
        {
            result = commands.add(arg);
        }
        else if (!commands.contains(arg))
            result = super.processArgument(arg, i);
		else 
			result = commands.contains(arg);
		return result;
    }


    @Override
    protected void doSet(String prop, String val)
    {
        if (prop.equals("lpost"))
        {
            IsaProperties.vdm2isa_linient_post = Boolean.parseBoolean(val);
        }
        else if (prop.equals("cvdm"))
        {
            IsaProperties.vdm2isa_print_vdm_comments = Boolean.parseBoolean(val);
        }
        else if (prop.equals("cisa"))
        {
            IsaProperties.vdm2isa_print_isa_comments = Boolean.parseBoolean(val);
        }
        else if (prop.equals("src"))
        {
            IsaProperties.vdm2isa_print_vdm_source = Boolean.parseBoolean(val);
        }
        else if (prop.equals("loc"))
        {
            IsaProperties.vdm2isa_print_locations = Boolean.parseBoolean(val);
        }
        else if (prop.equals("va"))
        {
            IsaProperties.vdm2isa_value_as_abbreviation = Boolean.parseBoolean(val);
        }
        else if (prop.equals("tm"))
        {
            IsaProperties.vdm2isa_translate_typedef_min_max = Boolean.parseBoolean(val);
        }
        else 
		{
			if (IsaProperties.vdm2isa_run_exu)
				exu.doSet(prop, val);
			super.doSet(prop, val);
		}
    }
	
	@Override
    protected String commandsHelp()
    {
        StringBuilder sb = new StringBuilder();
		sb.append(super.commandsHelp());
        sb.append("\texu      : runs the exu plugin before translation\n");
        sb.append("\ttranslate: translates all VDM modules to Isabelle\n");
        return sb.toString();
    }

    @Override
    protected List<String> defaultCommands()
    {
        List<String> result = Arrays.asList("exu", "translate");
		if (!IsaProperties.vdm2isa_run_exu)
			result.remove("exu"); 
		return result;
	}

    @Override 
    protected String options()
    {
		return (IsaProperties.vdm2isa_run_exu ? exu.options() : super.options()) +	 
			String.format(" lpost=%1$s cvdm=%2$s cisa=%3$s src=%4$s loc=%5$s va=%6$s tm=%7$s", 
				IsaProperties.vdm2isa_linient_post, IsaProperties.vdm2isa_print_vdm_comments,
				IsaProperties.vdm2isa_print_isa_comments, IsaProperties.vdm2isa_print_vdm_source,
				IsaProperties.vdm2isa_print_locations, IsaProperties.vdm2isa_value_as_abbreviation,
				IsaProperties.vdm2isa_translate_typedef_min_max);
    }

    @Override
    protected String optionsHelp()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(super.optionsHelp());
        sb.append("\tlpost: linient postcondition as pre_f => post_f\n");
        sb.append("\tcvdm : translated user-defined VDM comments\n");
		sb.append("\tcisa : outputs translator process comments\n");
        sb.append("\tsrc  : VDM source as an Isabelle comment above translation\n");
        sb.append("\tloc  : VDM source location as an Isabelle comment above translation\n");
		sb.append("\tva   : translates VDM values as Isabelle abbreviations\n");
		sb.append("\ttm   : translates VDM type definition min/max predicates\n");
        return sb.toString();
    }
}
