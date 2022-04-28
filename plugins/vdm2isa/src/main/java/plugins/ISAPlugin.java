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

import java.util.List;
import java.util.Vector;

import json.JSONArray;
import json.JSONObject;
import vdmj.commands.Command;
import workspace.lenses.CodeLens;
import workspace.plugins.AnalysisPlugin;

public abstract class ISAPlugin extends AnalysisPlugin
{
	public ISAPlugin()
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
		// Ignore
	}
	
	@Override
	public JSONObject getExperimentalOptions(JSONObject standard)
	{
		JSONObject provider = standard.get("translateProvider");
		
		if (provider != null)
		{
			JSONArray ids = provider.get("languageId");
			
			if (ids != null)
			{
				ids.add("isabelle");	// Edit the standard response to include isabelle
			}
		}
		
		return new JSONObject();
	}
	
	@Override
	public List<CodeLens> getCodeLenses(boolean dirty)
	{
		List<CodeLens> lenses = new Vector<CodeLens>();
		// lenses.add(new EditCodeLens());
		return lenses;
	}
	
	@Override
	public Command getCommand(String line)
	{
		if (line.startsWith("isa"))
		{
			return new ISACommand(line);
		}
		else
		{
			return null;
		}
	}
	
	@Override
	public String[][] getCommandHelp()
	{
		String[][] entries = { {"isa", "isa - Example plugin command" } };
		return entries;
	}
}