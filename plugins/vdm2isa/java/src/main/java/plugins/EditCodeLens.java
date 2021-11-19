/**
 * An example code lens, for a plugin.
 */
package plugins;

import java.io.File;

import com.fujitsu.vdmj.ast.definitions.ASTDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;

import json.JSONArray;
import workspace.lenses.CodeLens;

public class EditCodeLens extends CodeLens
{
	private static final String EDIT_LAUNCH_COMMAND = "workbench.action.debug.configure";
	
	@Override
	public JSONArray codeLenses(ASTDefinition definition, File file)
	{
		return new JSONArray(makeLens(definition.location, "Edit", EDIT_LAUNCH_COMMAND));
	}

	@Override
	public JSONArray codeLenses(TCDefinition definition, File file)
	{
		return new JSONArray(makeLens(definition.location, "Edit", EDIT_LAUNCH_COMMAND));
	}
}
