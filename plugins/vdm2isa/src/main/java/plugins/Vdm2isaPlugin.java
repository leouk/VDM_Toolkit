/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package plugins;

import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.runtime.Interpreter;
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
	//TODO add plugin property about using abbreviations or definitions for TRValueDefinition  
	//TODO add plugin option about raising warnings? or just raise them 
    public boolean isaRun(TCModuleList tclist, String[] argv) throws Exception 
	{
		boolean result = false;
		if (interpreter instanceof ModuleInterpreter)
		{
			if (IsaProperties.vdm2isa_run_exu)
			{
				// plugin run worked if exu's run works
				result = exu.isaRun(tclist, argv);

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

			Console.out.println("Starting Isabelle to VDM translation.");

			// VDM errors don't pass VDMJ; some VDM warnings have to be raised as errors to avoid translation issues
			//Vdm2isaPlugin.processVDMWarnings();

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
    protected String commandsHelp()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("exu: runs the exu plugin before translation\n");
        sb.append("translate: translates all VDM modules to Isabelle\n");
        return sb.toString();
    }

    @Override
    protected String defaultCommands()
    {
        return (IsaProperties.vdm2isa_run_exu ? "exu; " : "") + "translate";
    }

    @Override 
    protected String defaultOptions()
    {
        return (IsaProperties.vdm2isa_run_exu ? exu.defaultOptions() : super.defaultOptions()) +	
            (IsaProperties.vdm2isa_linient_post ? " -lpost" : "") +
            (IsaProperties.vdm2isa_print_vdm_comments ? " -cvdm" : "") +
            (IsaProperties.vdm2isa_print_isa_comments ? " -cisa" : "") +
            (IsaProperties.vdm2isa_print_vdm_source ? " -src" : "") +
			(IsaProperties.vdm2isa_print_locations ? " -loc" : "") +
            (IsaProperties.vdm2isa_value_as_abbreviation ? " -va" : "") +
            (IsaProperties.vdm2isa_translate_typedef_min_max ? " -tm" : "");
    }

    @Override
    protected String optionsHelp()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(super.optionsHelp());
        sb.append("-lpost: linient postcondition as pre_f => post_f");
        sb.append("-cvdm: translated user-defined VDM comments");
		sb.append("-cisa: outputs translator process comments");
        sb.append("-src: VDM source as an Isabelle comment above translation");
        sb.append("-loc: VDM source location as an Isabelle comment above translation");
		sb.append("-va: translates VDM values as Isabelle abbreviations");
		sb.append("-tm: translates VDM type definition min/max predicates");
        return sb.toString();
    }
}
