package vdmj.commands;

import java.lang.reflect.InvocationTargetException;

import dap.DAPMessageList;
import dap.DAPRequest;
import json.JSONObject;
import plugins.ExuPlugin;
import plugins.ResourceUtil;
import workspace.DAPWorkspaceManager;

public class ExuCommand extends Command
{
	public static final String USAGE = "Usage: exu <args>";
	public static final String HELP = "exu help - shows how to use the command";

	private final String[] args;
	private final ExuPlugin exu; 
	
	public ExuCommand(String line, ExuPlugin exu)
	{
		this.exu = exu;
		this.args = line.split("\\s+");
		if (args.length > 0 && args[0].equals("exu"))
		{
		}
		else
		{
			exu.usage("Invalid args " + line);
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
			result = exu.run(args);
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
	public boolean notWhenRunning()
	{
		return true;
	}
}
