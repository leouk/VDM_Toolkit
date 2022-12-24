package vdmj.commands;

import dap.DAPMessageList;
import dap.DAPRequest;
import json.JSONObject;
import plugins.ResourceUtil;

public class ExuCommand extends Command
{
	public static final String USAGE = "Usage: exu <args>";
	public static final String HELP = "exu help - shows how to use the command";

	private final String line;
	
	public ExuCommand(String line)
	{
		String[] parts = line.split("\\s+", 2);
		if (parts.length == 2 && parts[0].equals("exu"))
		{
			this.line = parts[1];	
		}
		else
		{
			throw new IllegalArgumentException(USAGE);
		}	
	}

	@Override
	public DAPMessageList run(DAPRequest request)
	{
		return new DAPMessageList(request, new JSONObject("result", "You typed: " + line));
	}

	@Override
	public boolean notWhenRunning()
	{
		return true;
	}
}
