package workspace.plugins;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.util.Utils;

import json.JSONArray;
import json.JSONObject;
import plugins.IsaProperties;
import plugins.ResourceUtil;
import plugins.commands.IsabelleCommand;
import plugins.commands.IsapogCommand;
import rpc.RPCErrors;
import rpc.RPCMessageList;
import rpc.RPCRequest;
import vdm2isa.lex.IsaTemplates;
import vdmj.commands.AnalysisCommand;
import vdmj.commands.HelpList;
import vdmj.commands.IsaCommand;
import workspace.Diag;
import workspace.EventHub;
import workspace.EventListener;
import workspace.MessageHub;
import workspace.events.CheckCompleteEvent;
import workspace.events.CheckPrepareEvent;
import workspace.events.LSPEvent;
import workspace.events.UnknownTranslationEvent;

public abstract class ISAPlugin extends AnalysisPlugin implements EventListener
{
	public static ISAPlugin factory(Dialect dialect)
	{
		switch (dialect)
		{
			case VDM_SL:
				return new ISAPluginSL();
				
			default:
				Diag.error("Unsupported dialect " + dialect);
				throw new IllegalArgumentException("Unsupported dialect: " + dialect);
		}
	}

	public static final String VDM2ISA_PROPERTIES = ".vscode/vdm2isa.properties";

	protected IsapogCommand isapog;

	protected ISAPlugin()
	{
		super();
		IsaProperties.init(VDM2ISA_PROPERTIES);
	}
	
	@Override
	public String getName()
	{
		return "ISA";
	}

	@Override
	public void init()
	{
		EventHub.getInstance().register(CheckPrepareEvent.class, this);
		EventHub.getInstance().register(CheckCompleteEvent.class, this);
		EventHub.getInstance().register(UnknownTranslationEvent.class, this);
		IsaProperties.init();
		IsaTemplates.reset();
		//this.exu = ResourceUtil.createPlugin("exu", DAPWorkspaceManager.getInstance().getInterpreter()) ;
		// this.exu = new ExuPlugin(DAPWorkspaceManager.getInstance().getInterpreter());
		// this.vdm2isa = new Vdm2isaPlugin(DAPWorkspaceManager.getInstance().getInterpreter());
		//this.isapog = new IsapogPlugin(DAPWorkspaceManager.getInstance().getInterpreter());
	}

	protected RPCMessageList preCheck(CheckPrepareEvent ev)
	{
		MessageHub.getInstance().clearPluginMessages(this);
		return new RPCMessageList();
	}

	protected void reportErrors(CheckCompleteEvent ev, IsabelleCommand command, boolean result)
	{
		Diag.info("%1$s run %2$s", command.isabelleCommandName(), (result ? "succeeded" : "failed"));
		Diag.info("Reporting %1$s errors and %2$s warnings", command.getLocalErrorCount(), 
			command.getLocalWarningCount());
		List<VDMMessage> list = new ArrayList<VDMMessage>();
		
		list.addAll(IsabelleCommand.getErrors());
		MessageHub.getInstance().addPluginMessages(this, list);
		
		list.clear();
		list.addAll(IsabelleCommand.getWarnings());
		MessageHub.getInstance().addPluginMessages(this, list);
	}

	@Override
	public RPCMessageList handleEvent(LSPEvent event) throws Exception
	{
		RPCMessageList result;
		if (event instanceof CheckPrepareEvent)
		{
			result = preCheck((CheckPrepareEvent)event);
		}
		else if (event instanceof CheckCompleteEvent)
		{
			//@NB how  to set properties at this point? 
			long before = System.currentTimeMillis();
			CheckCompleteEvent ev = (CheckCompleteEvent)event;
			if (ev.request != null) 
				setProperties(ev.request);
			//IsaProperties.exu_linient_inv_check = false;
			IsaTemplates.reset();
			this.isapog = IsapogCommand.getInstance("isapog", registry);
			boolean pluginResult = true; 			
			if (IsaProperties.vdm2isa_run_exu)
			{
				pluginResult = this.isapog.translate.exu.run(new String[] { "exu", "check", "sort" });
				reportErrors(ev, this.isapog.translate.exu, pluginResult);
			} 
			// if (pluginResult)
			// {
			// 	pluginResult = this.isapog.vdm2isa.run(new String[] { "vdm2isa", "translate" });
			// 	reportErrors(ev, this.isapog.vdm2isa, pluginResult);
			// }
			// if (pluginResult)
			// {
			// 	pluginResult = this.isapog.run(new String[] { "isapog", "isapog" });
			// 	reportErrors(ev, this.isapog, pluginResult);	
			// }
			result = new RPCMessageList();
			long after = System.currentTimeMillis();
			Diag.info("ISAPlugin.checkCompleteEvent time = %1$s ms", (after-before));
		}
		else if (event instanceof UnknownTranslationEvent)
		{
			UnknownTranslationEvent ute = (UnknownTranslationEvent)event;
			
			if (ute.languageId.equals("isabelle"))
			{
				result = analyse(event.request);
				
			}
			else 
				result = null;
		}
		else
		{
			Diag.error("Unhandled %s event %s", getName(), event);
			result = null; // not handled
		}		
		return result;	
	}

	protected RPCMessageList setProperties(RPCRequest request)
	{
		try
		{
			JSONObject params = request.get("params");
			if (params != null)
			{
				// File saveUri = Utils.uriToFile(params.get("saveUri"));
				JSONObject options = params.get("options");

				if (options != null)
				{
					try {
						Diag.fine("Setting up Isabelle translation plugin properties");
						Diag.fine("Options JSON = " + options.toString());
						IsaProperties.setValues(options);
						return new RPCMessageList();
					}
					catch (Throwable e)
					{
						// String.valueOf was generating a peculiar exception, hence the code below. Perhaps remove. 
						Diag.error("ISA plugin settings error: " + e.getMessage());
						StringWriter out = new StringWriter();
						PrintWriter writer = new PrintWriter(out);
						e.printStackTrace(writer);
						writer.flush();
						Diag.error("Trace: " + out.toString());
						return new RPCMessageList(request, RPCErrors.InternalError, e.getMessage());
					}
				}
				else
				{
					String d = "Could not retrieve Isabelle translation plugin params options";
					Diag.severe(d);
					return new RPCMessageList(request, RPCErrors.InvalidParams, d);
				}
			}
			else
			{
				String d = "Could not retrieve Isabelle translation plugin params";
				Diag.severe(d);
				return new RPCMessageList(request, RPCErrors.InvalidParams, d);
			}
		}
		catch (Exception e)
		{
			Diag.error(e);
			return new RPCMessageList(request, RPCErrors.InternalError, e.getMessage());
		}
	} 
	
	protected abstract RPCMessageList doAnalyse(RPCRequest request);

	public final RPCMessageList analyse(RPCRequest request)
	{
		RPCMessageList result = setProperties(request);
		result.addAll(doAnalyse(request));
		return result;
	}

	@Override
	public void setServerCapabilities(JSONObject capabilities)
	{
		JSONObject experimental = capabilities.get("experimental");
		
		if (experimental != null)
		{
			JSONObject provider = experimental.get("translateProvider");
			
			if (provider != null)
			{
				JSONArray ids = provider.get("languageId");
				
				if (ids != null)
				{
					ids.add("isabelle");	// Edit the capabilities to include isabelle
				}
			}
		}
	}

	@Override
	public AnalysisCommand getCommand(String line)
	{
		String[] args = Utils.toArgv(line);
		IsaCommand result = null;
		if (args != null)
		{
			try
			{
				result = new IsaCommand(line, ResourceUtil.createCommand(args[0]));	
			}
			catch (ClassNotFoundException e)
			{
				//throw new IllegalArgumentException("Could not find Exu plugin?");
			}
			catch (IllegalAccessException e)
			{
				//throw new IllegalArgumentException("Could not find Exu plugin?");
			}
			catch (NoSuchMethodException e)
			{
				//throw new IllegalArgumentException("Could not find Exu plugin?");
			}
			catch (InvocationTargetException e)
			{
				//throw new IllegalArgumentException("Could not find Exu plugin?");
			}
			catch (Exception e)
			{
				//throw new IllegalArgumentException("Could not find Exu plugin?");
			}
		}
		return result;
	}
	
	@Override
	public HelpList getCommandHelp()
	{
		//TODO make this nicer in ExuPlugin usage? Or leave for now. 
		return new HelpList(
			IsaCommand.ExuHELP,
			IsaCommand.Vdm2IsaHELP,
			IsaCommand.IsapogHELP
		);
	}
}