/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package plugins;

import java.io.File;
import java.io.PrintWriter;

import com.fujitsu.vdmj.commands.CommandPlugin;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.modules.TRModule;
import vdm2isa.tr.modules.TRModuleList;

public class Vdm2isaPlugin extends CommandPlugin
{
	public Vdm2isaPlugin(Interpreter interpreter)
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

			for (TRModule module: trModules)
			{
				String dir = module.name.getLocation().file.getParent();
				if (dir == null) dir = ".";
				String name = module.name.getName() + ".thy";//module.name.getName().substring(0, module.name.getName().lastIndexOf('.')) + ".thy";
				System.out.println("Translating into " + dir + "/" + name);
				File outfile = new File(dir, name);
				PrintWriter out = new PrintWriter(outfile);
				out.write(module.translate());
				out.close();
			}

			//System.out.println(trModules.translate());
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
		return "vdm2isa - translate all loaded VDM modules to Isabelle/HOL";
	}
}
