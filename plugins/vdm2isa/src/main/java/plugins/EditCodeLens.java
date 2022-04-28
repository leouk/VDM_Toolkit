/**
 * An example code lens, for a plugin.
 */
package plugins;

import json.JSONArray;
import vdm2isa.tr.definitions.TRDefinition;
import workspace.lenses.CodeLens;

public class EditCodeLens extends CodeLens
{
	private static final String EDIT_LAUNCH_COMMAND = "workbench.action.debug.configure";
	
	@Override
	public <DEF, CLS> JSONArray getDefinitionLenses(DEF definition, CLS classdef)
	{
		TRDefinition def = (TRDefinition)definition;
		return new JSONArray(makeLens(def.location, "Edit", EDIT_LAUNCH_COMMAND));
	}
}
