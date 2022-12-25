package vdmj.commands;

import java.util.Arrays;
import java.util.List;

import dap.DAPMessageList;
import dap.DAPRequest;
import json.JSONObject;
import plugins.GeneralisaPlugin;

public class IsaCommand extends Command {

    private final String[] args;
	private final GeneralisaPlugin plugin; 

    public static final String ExuHELP = "exu help - shows how to use the command";
	public static final String Vdm2IsaHELP = "vdm2isa help - shows how to use the command";
	public static final String IsapogHELP = "isapog help - shows how to use the command";

    private static final List<String> VALID_PLUGINS = Arrays.asList("exu", "vdm2isa", "isapog");
	
    public static final String[] isLineValid(String line)
    {
        String[] parts = line.split("\\s+");
		if ((parts.length > 0 && VALID_PLUGINS.contains(parts[0])))
            return parts;
        else 
            return null;
    } 

	public IsaCommand(String line, GeneralisaPlugin pl)
	{
		this.plugin = pl;
		this.args = isLineValid(line);
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
