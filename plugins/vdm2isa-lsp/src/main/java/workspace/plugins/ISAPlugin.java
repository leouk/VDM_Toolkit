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

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import json.JSONArray;
import json.JSONObject;
import plugins.ExuPlugin;
import plugins.GeneralisaPlugin;
import plugins.IsapogPlugin;
import plugins.ResourceUtil;
import plugins.Vdm2isaPlugin;
import rpc.RPCMessageList;
import rpc.RPCRequest;
import vdm2isa.messages.VDM2IsaError;
import vdmj.commands.Command;
import vdmj.commands.ExuCommand;
import vdmj.commands.HelpList;
import workspace.DAPWorkspaceManager;
import workspace.Diag;
import workspace.EventHub;
import workspace.EventListener;
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

	// private ExuPlugin exu;
	// private Vdm2isaPlugin vdm2isa; 
	private IsapogPlugin isapog;

	protected ISAPlugin()
	{
		super();
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
		//this.exu = ResourceUtil.createPlugin("exu", DAPWorkspaceManager.getInstance().getInterpreter()) ;
		// this.exu = new ExuPlugin(DAPWorkspaceManager.getInstance().getInterpreter());
		// this.vdm2isa = new Vdm2isaPlugin(DAPWorkspaceManager.getInstance().getInterpreter());
		//this.isapog = new IsapogPlugin(DAPWorkspaceManager.getInstance().getInterpreter());
	}

	protected void preCheck(CheckPrepareEvent ev)
	{
		//this.isapog = new IsapogPlugin(null);
	}

	
	@Override
	public RPCMessageList handleEvent(LSPEvent event) throws Exception
	{
		RPCMessageList result;
		if (event instanceof CheckPrepareEvent)
		{
			preCheck((CheckPrepareEvent)event);
			result = new RPCMessageList();
		}
		else if (event instanceof CheckCompleteEvent)
		{
			CheckCompleteEvent ev = (CheckCompleteEvent)event;
			TCPlugin tcp = registry.getPlugin("TC");
			TCModuleList mlist = tcp.getTC();
			this.isapog = new IsapogPlugin(mlist);
			//TODO @NB Do I need to get the interpreter again here? 
			boolean exuresult = this.isapog.vdm2isa.exu.run(new String[] { "exu", "check" });
			List<VDMMessage> list = new ArrayList<VDMMessage>();
			list.addAll(GeneralisaPlugin.getErrors());
			ev.addErrs(list);
			list.clear();
			list.addAll(GeneralisaPlugin.getWarnings());
			ev.addWarns(list);
			result = new RPCMessageList();
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
	
	abstract public RPCMessageList analyse(RPCRequest request);

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
		if (line.startsWith("exu"))
		{
			ExuCommand exu = null;
			try
			{
				exu = new ExuCommand(line, 
					ResourceUtil.createPlugin("exu", DAPWorkspaceManager.getInstance().getInterpreter()));	
			}
			catch (NoSuchMethodException e)
			{
				//throw new IllegalArgumentException("Could not find Exu plugin?");
			}
			catch (InvocationTargetException e)
			{
				//throw new IllegalArgumentException("Could not find Exu plugin?");
			}
			return exu;
		}
		else
		{
			return null;
		}
	}
	
	@Override
	public HelpList getCommandHelp()
	{
		//TODO make this nicer in ExuPlugin usage? Or leave for now. 
		return new HelpList(
			ExuCommand.HELP
		);
	}
}