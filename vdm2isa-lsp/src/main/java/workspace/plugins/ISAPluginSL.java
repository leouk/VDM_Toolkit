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

import java.io.File;

import com.fujitsu.vdmj.tc.modules.TCModuleList;

import json.JSONObject;
import lsp.Utils;
import plugins.ResourceUtil;
import rpc.RPCErrors;
import rpc.RPCMessageList;
import rpc.RPCRequest;
import vdm2isa.lex.IsaToken;
import workspace.Diag;
import workspace.PluginRegistry;

public class ISAPluginSL extends ISAPlugin
{
	public static final String VDM_TOOLKIT = IsaToken.VDMTOOLKIT.toString() + ".thy";
	
	public ISAPluginSL()
	{
		super();
	}

	@Override
	protected RPCMessageList doAnalyse(RPCRequest request)
	{
		try
		{
			JSONObject params = request.get("params");
			File saveUri = Utils.uriToFile(params.get("saveUri"));
			
			TCPlugin tc = PluginRegistry.getInstance().getPlugin("TC");
			TCModuleList tclist = tc.getTC();
			
			if (tclist == null || tclist.isEmpty())
			{
				return new RPCMessageList(request, RPCErrors.InvalidRequest, "There are no type checked specifications");
			}

			// here we call the plugin 
			boolean r = this.isapog.run(
				new String[] { "isapog", "set", "o", saveUri.toPath().toString()});
			if (r)
			{
				r = this.isapog.run(new String[] { "isapog" });
			}
			
			//TODO @NB, how can I add the plugin errors within this event? 

// //			for (TCModule module: tclist)
// //			{
// //				File outfile = new File(saveUri, module.name.getName() + ".thy");
// //				PrintWriter out = new PrintWriter(outfile);
// //				out.write("Isabelle output...\n");
// //				out.close();
// //			}
			

			// if it reaches here without exceptions, then also generate the VDMToolkit on the saveURI
			ResourceUtil.copyTo(VDM_TOOLKIT, new File(saveUri, VDM_TOOLKIT));                
			
			return new RPCMessageList(request, new JSONObject("uri", saveUri.toURI().toString()));
		}
		catch (Exception e)
		{
			Diag.error("Isa plugin analyse error: " + e.getMessage());
			return new RPCMessageList(request, RPCErrors.InternalError, e.getMessage());
		}
 	}
}
