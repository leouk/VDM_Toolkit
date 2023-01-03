/*******************************************************************************
 *
 *	Copyright (c) 2020 Nick Battle.
 *
 *	Author: Nick Battle
 *
 *	This file is part of VDMJ.
 *
 *	VDMJ is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	VDMJ is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with VDMJ.  If not, see <http://www.gnu.org/licenses/>.
 *	SPDX-License-Identifier: GPL-3.0-or-later
 *
 ******************************************************************************/

package workspace.plugins;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import json.JSONArray;
import json.JSONObject;
import plugins.GeneralisaPlugin;
import plugins.IsaProperties;
import plugins.IsapogPlugin;
import plugins.ResourceUtil;
import rpc.RPCErrors;
import rpc.RPCMessageList;
import rpc.RPCRequest;
import vdm2isa.lex.IsaTemplates;
import vdmj.commands.Command;
import vdmj.commands.HelpList;
import vdmj.commands.IsaCommand;
import workspace.DAPWorkspaceManager;
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

	protected IsapogPlugin isapog;

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

	protected void reportErrors(CheckCompleteEvent ev, GeneralisaPlugin plugin, boolean result)
	{
		Diag.info("%1$s run %2$s", plugin.pluginName(), (result ? "succeeded" : "failed"));
		Diag.info("Reporting %1$s errors and %2$s warnings", plugin.getLocalErrorCount(), 
			plugin.getLocalWarningCount());
		List<VDMMessage> list = new ArrayList<VDMMessage>();
		
		list.addAll(GeneralisaPlugin.getErrors());
		MessageHub.getInstance().addPluginMessages(this, list);
		
		list.clear();
		list.addAll(GeneralisaPlugin.getWarnings());
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
			long before = System.currentTimeMillis();
			CheckCompleteEvent ev = (CheckCompleteEvent)event;
			IsaTemplates.reset();
			TCPlugin tcp = registry.getPlugin("TC");
			TCModuleList mlist = tcp.getTC();
			this.isapog = new IsapogPlugin(mlist);
			//TODO @NB Do I need to get the interpreter again here? 
			boolean pluginResult = true; 
			if (IsaProperties.vdm2isa_run_exu)
			{
				pluginResult = this.isapog.vdm2isa.exu.run(new String[] { "exu", "check", "sort" });
				reportErrors(ev, this.isapog.vdm2isa.exu, pluginResult);
			} 
			if (pluginResult)
			{
				pluginResult = this.isapog.vdm2isa.run(new String[] { "vdm2isa", "translate" });
				reportErrors(ev, this.isapog.vdm2isa, pluginResult);
			}
			if (pluginResult)
			{
				pluginResult = this.isapog.run(new String[] { "isapog", "isapog" });
				reportErrors(ev, this.isapog, pluginResult);	
			}
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
	public Command getCommand(String line)
	{
		String[] args = IsaCommand.isLineValid(line);
		IsaCommand result = null;
		if (args != null)
		{
			try
			{
				result = new IsaCommand(line, 
					ResourceUtil.createPlugin(args[0], DAPWorkspaceManager.getInstance().getInterpreter()));	
			}
			catch (NoSuchMethodException e)
			{
				//throw new IllegalArgumentException("Could not find Exu plugin?");
			}
			catch (InvocationTargetException e)
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