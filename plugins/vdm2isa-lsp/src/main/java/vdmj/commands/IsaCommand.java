package vdmj.commands;

import com.fujitsu.vdmj.util.Utils;

import dap.DAPMessageList;
import dap.DAPRequest;
import json.JSONObject;
import plugins.commands.IsapogCommand;

public class IsaCommand extends AnalysisCommand {

    private final String[] args;
	private final IsapogCommand plugin; 

    public static final String ExuHELP = "exu help - shows how to use the command";
	public static final String Vdm2IsaHELP = "vdm2isa help - shows how to use the command";
	public static final String IsapogHELP = "isapog help - shows how to use the command";
    
	public IsaCommand(String line, IsapogCommand pl)
	{
		this.plugin = pl;
		this.args = Utils.toArgv(line);
		if (this.args == null)
		{
			plugin.usage("Invalid args " + line);
			//TODO have to curb Console.out! Diag? 
			throw new IllegalArgumentException();
		}	
	}

	@Override
	public DAPMessageList run(DAPRequest request)
	{
		JSONObject r;
		boolean result;
		try
		{
			result = plugin.run(args);
		}
		catch (Exception e)
		{
			result = false;
		}
		if (result)
			r = new JSONObject("result", "Exu run succeeded");
		else 	
			r = new JSONObject("result", "Exu run failed");
		return new DAPMessageList(request, r);
	}
    
    @Override
    public boolean notWhenRunning() {
        return true;
    }
    
}
