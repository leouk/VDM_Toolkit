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

package plugins;

import java.io.File;
import java.io.PrintWriter;

import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import json.JSONObject;
import lsp.Utils;
import rpc.RPCErrors;
import rpc.RPCMessageList;
import rpc.RPCRequest;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.modules.TRModule;
import vdm2isa.tr.modules.TRModuleList;
import workspace.Diag;
import workspace.PluginRegistry;
import workspace.plugins.TCPlugin;

public class ISAPluginSL extends ISAPlugin
{
	public static final String VDM_TOOLKIT = IsaToken.VDMTOOLKIT.toString() + ".thy";
	public ISAPluginSL()
	{
		super();
	}
	
	@Override
	public RPCMessageList analyse(RPCRequest request)
	{
		try
		{
			GeneralisaPlugin.reset();

			JSONObject params = request.get("params");
			File saveUri = Utils.uriToFile(params.get("saveUri"));

			JSONObject options = params.get("options");

			// get all properties in position
			ExuPlugin.setupProperties();
			Vdm2isaPlugin.setupProperties();
			IsapogPlugin.setupProperties();

			if (options != null)
			{
				Diag.fine("Setting up Isabelle translation plugin properties");
				GeneralisaPlugin.strict = options.get("strict") != null ? options.get("strict") : GeneralisaPlugin.strict;
				GeneralisaPlugin.maxErrors = options.get("maxErrors") != null ? options.get("maxErrors") : GeneralisaPlugin.maxErrors;
				GeneralisaPlugin.reportVDMWarnings = options.get("reportVDMWarnings") != null ? options.get("reportVDMWarnings") : GeneralisaPlugin.reportVDMWarnings;
				Vdm2isaPlugin.linientPost = options.get("linientPost") != null ? options.get("linientPost") : Vdm2isaPlugin.linientPost;
				Vdm2isaPlugin.printVDMComments = options.get("printVDMComments") != null ? options.get("printVDMComments") : Vdm2isaPlugin.printVDMComments;
				Vdm2isaPlugin.printIsaComments = options.get("printIsaComments") != null ? options.get("printIsaComments") : Vdm2isaPlugin.printIsaComments;
				Vdm2isaPlugin.runExu = options.get("runExu") != null ? options.get("runExu") : Vdm2isaPlugin.runExu;
				Vdm2isaPlugin.valueAsAbbreviation = options.get("valueAsAbbreviation") != null ? options.get("valueAsAbbreviation") : Vdm2isaPlugin.valueAsAbbreviation;
				Vdm2isaPlugin.translateTypeDefMinMax = options.get("translateTypeDefMinMax") != null ? options.get("translateTypeDefMinMax") : Vdm2isaPlugin.translateTypeDefMinMax;
				Vdm2isaPlugin.printVDMSource = options.get("printVDMSource") != null ? options.get("printVDMSource") : Vdm2isaPlugin.printVDMSource; 
				Vdm2isaPlugin.printLocations = options.get("printLocations") != null ? options.get("printLocations") : Vdm2isaPlugin.printLocations;
				IsapogPlugin.strategy = options.get("proofStrategy") != null ? 
					IsaProofStrategy.valueOf(String.valueOf(options.get("proofStrategy")).toUpperCase()) : IsapogPlugin.strategy;	
			}
			else
			{
				Diag.severe("Could not retrieve Isabelle translation plugin options");
			}
			
			TCPlugin tc = PluginRegistry.getInstance().getPlugin("TC");
			TCModuleList tclist = tc.getTC();
			
			if (tclist == null || tclist.isEmpty())
			{
				return new RPCMessageList(request, RPCErrors.InvalidRequest, "Specification is not checked");
			}
			
//			for (TCModule module: tclist)
//			{
//				File outfile = new File(saveUri, module.name.getName() + ".thy");
//				PrintWriter out = new PrintWriter(outfile);
//				out.write("Isabelle output...\n");
//				out.close();
//			}
			//GeneralisaPlugin.checkVDMSettings();

			// VDM errors don't pass VDMJ; some VDM warnings have to be raised as errors to avoid translation issues
			//GeneralisaPlugin.processVDMWarnings();

			TCModuleList filtered_tclist = GeneralisaPlugin.filterModuleList(tclist);
			TRModuleList trModules = ClassMapper.getInstance(TRNode.MAPPINGS).init().convert(filtered_tclist);
			trModules.setup();
			for (TRModule module: trModules)
			{
				File outfile = new File(saveUri, module.name.getName() + ".thy");
				PrintWriter out = new PrintWriter(outfile);
				String s = module.translate();
				Diag.finest(s);
				out.write(s);
				out.close();
			}

			// if it reaches here without exceptions, then also generate the VDMToolkit on the saveURI
			ResourceUtil.save(VDM_TOOLKIT, new File(saveUri, VDM_TOOLKIT));                
			
			return new RPCMessageList(request, new JSONObject("uri", saveUri.toURI().toString()));
		}
		catch (Exception e)
		{
			Diag.error(e);
			return new RPCMessageList(request, RPCErrors.InternalError, e.getMessage());
		}
	}
}
