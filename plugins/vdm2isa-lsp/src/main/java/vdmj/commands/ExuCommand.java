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
		String[] parts = line.split("\\s+", 2);
		if (parts.length == 2 && parts[0].equals("exu"))
		{
			this.args = parts[1].split("\\s+");
		}
		else
		{
			//TODO have to curb Console.out! Diag? 
			throw new IllegalArgumentException(USAGE);//exu.usage());
		}	
	}

	@Override
	public DAPMessageList run(DAPRequest request)
	{
		return new DAPMessageList(request, new JSONObject("result", "You typed: " + args));
	}

	@Override
	public boolean notWhenRunning()
	{
		return true;
	}
}
