/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package plugins;

import com.fujitsu.vdmj.commands.CommandPlugin;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.modules.TRModuleList;

public class TranslatePlugin extends CommandPlugin
{
	public TranslatePlugin(Interpreter interpreter)
	{
		super(interpreter);
	}

	@Override
	public boolean run(String[] argv) throws Exception
	{
		if (interpreter instanceof ModuleInterpreter)
		{
			ModuleInterpreter minterpreter = (ModuleInterpreter)interpreter;
			TCModuleList tclist = minterpreter.getTC();
			TRModuleList trModules = ClassMapper.getInstance(TRNode.MAPPINGS).init().convert(tclist);
			System.out.println(trModules.translate());
			return true;
		}
		else
		{
			return false;
		}
	}

	@Override
	public String help()
	{
		return "translate <language> [<files>] - translate the VDM specification to <language>";
	}
}
