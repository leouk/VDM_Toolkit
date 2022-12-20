/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package plugins;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.modules.TRModule;
import vdm2isa.tr.modules.TRModuleList;

public class Vdm2isaPlugin extends GeneralisaPlugin
{
	private TRModuleList translatedModules;
	//TODO consider extending ExuPlugin?
	private ExuPlugin exu;

	public Vdm2isaPlugin(ModuleInterpreter interpreter)
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
	//TODO add plugin property about using abbreviations or definitions for TRValueDefinition  
	//TODO add plugin option about raising warnings? or just raise them 
    public boolean isaRun(TCModuleList tclist) throws Exception 
	{
		boolean result = false;
		if (!commands.isEmpty())
		{
			if (commands.contains("exu"))
			{
				// plugin run worked if exu's run works
				exu.prompt();
				result = exu.isaRun(tclist);

				// clear error messages to avoid duplication
				if (result)
				{	
					GeneralisaPlugin.fullReset(this);
				}
			}
			else
			{
				// plugin run worked
				result = true;
			}

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
				if (!IsaProperties.general_strict || GeneralisaPlugin.getErrorCount() == 0)
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
				}
			}
			catch (InternalException e)
			{
				processException(e, workingAt, false);
			}
			catch (Throwable t)
			{
				processException(t, workingAt, true);
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
    protected void processArgument(String arg, Iterator<String> i)
    {
        if (arg.equals("exu") && !commands.contains(arg))
        {
            commands.add(arg);
        }
        else if (arg.equals("translate") && !commands.contains(arg))
        {
            commands.add(arg);
        }
        else if (IsaProperties.vdm2isa_run_exu)
		{
			exu.processArgument(arg, i);
			mergeCommands(exu);
		}
		else
            super.processArgument(arg, i);
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
        else if (IsaProperties.vdm2isa_run_exu)
			exu.doSet(prop, val);
		else
            super.doSet(prop, val);
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
