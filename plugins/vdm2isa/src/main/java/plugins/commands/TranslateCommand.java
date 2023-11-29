package plugins.commands;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.plugins.PluginConsole;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.typechecker.TypeChecker;
import com.fujitsu.vdmj.util.Utils;

import plugins.IsaProperties;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.modules.TRModule;
import vdm2isa.tr.modules.TRModuleList;
import vdm2isa.tr.templates.IsaIdentifier;
import vdm2isa.tr.templates.IsaTemplateException;

public class TranslateCommand extends IsabelleCommand {

	//TODO consider extending ExuPlugin?
	public final ExuCommand exu;

	private static TranslateCommand INSTANCE = null;
	private static final String USAGE = "vdm2isa - translate all loaded VDM modules to Isabelle/HOL (v. " + IsaProperties.general_isa_version + ")";
	
    //@NB does this need to also be synchronized? No? 
    public static final TranslateCommand getInstance(String line)
    {
        return getInstance(line, null);
    }

    public static synchronized final TranslateCommand getInstance(String line, workspace.PluginRegistry lspR)
    {
        if (INSTANCE == null)
        {
            INSTANCE = new TranslateCommand(line);
        }
        else
        {
            INSTANCE.setArguments(Utils.toArgv(line));
        }
        // ensure the source registry is updated for LSP
        if (lspR != null) 
            INSTANCE.setLSPRegistry(lspR);
        return INSTANCE; 
    }

    private TRModuleList translatedModules;

    private TranslateCommand(String line) {
        super(line);
        this.translatedModules = new TRModuleList();
        this.exu = ExuCommand.getInstance("exu");
    }

	@Override
	protected void setLSPRegistry(workspace.PluginRegistry lspR)
	{
		super.setLSPRegistry(lspR);
		this.exu.setLSPRegistry(lspR);
	}

	@Override 
	protected String getMinimalUsage()
	{
		return USAGE;
	}

	public TRModuleList getTranslatedModules()
	{
		return this.translatedModules;
	}

	@Override 
	protected void localReset()
	{
		super.localReset();
		if (exu != null) 
			exu.localReset();
		// no need to clear before construction; already empty
		if (translatedModules != null)
			translatedModules.clear();
		IsaIdentifier.reset();
	}

	@Override
    protected void prompt()
    {
        PluginConsole.infoln("Calling VDM to " + IsaProperties.general_isa_version + " translator...");
        super.prompt();
    }

    @Override 
    protected boolean setup()
    {
        //exu.setup();
		// VDM errors don't pass VDMJ typechecker; 
		// some VDM warnings have to be raised as errors to avoid translation issues
		TranslateCommand.processVDMWarnings(TypeChecker.getWarnings(), true);
		
        return true;
    }

	@Override 
    protected boolean runCommand(String name, TCModuleList tclist)
    {
        boolean result;
		if (name.equals("exu"))
		{
			result = exu.internalRun(tclist);			
		}
		else if (name.equals("translate"))
		{
			result = doTranslate(tclist);
			// if not strict, then absorb bad exu results
			// strict => result
			result = (!IsaProperties.general_strict || result);
		}
		else 
		{
			result = false; 
		}
		return result;
    }

	protected boolean doTranslate(TCModuleList tclist)
	{
		boolean result;
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
			// strict => IsabelleCommand.getErrorCount() == 0
			result = (!IsaProperties.general_strict || IsabelleCommand.getErrorCount() == 0);
			if (result)
			{
				int mcount = 0;
				String moduleName;
				for (TRModule module : translatedModules)
				{
					moduleName = module.name.getName();
					workingAt = "translating module " + moduleName;
					processOutput(module.getLocation(), moduleName, module.translate());
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
			// only print stack if debugging
			processException(e, workingAt, IsaProperties.general_debug);
			result = false;
		}
		catch (IsaTemplateException t)
		{
			IsabelleCommand.report(IsaErrorMessage.PLUGIN_UNEXPECTED_ERROR_3P, LexLocation.ANY, "from Isabelle templates", " ", t.getMessage());
			processException(t, workingAt, true);//IsaProperties.general_debug);
			result = false;
		}
		catch (Throwable t)
		{
			IsabelleCommand.report(IsaErrorMessage.PLUGIN_UNEXPECTED_ERROR_3P, LexLocation.ANY, "while translating", " ", t.getMessage());
			processException(t, workingAt, true);
			result = false;
		}
		return result;
	}

	@Override 
    public String isabelleCommandName()
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
				result = exu.processArgument0(exu.validSubCommands().iterator());
				//mergeCommands(exu);
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
    protected List<String> validSubCommands()
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

    public static String help()
	{
		return USAGE;
	}
}
