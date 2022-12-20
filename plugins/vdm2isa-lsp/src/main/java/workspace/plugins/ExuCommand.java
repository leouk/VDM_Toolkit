package workspace.plugins;

import dap.DAPMessageList;
import dap.DAPRequest;
import json.JSONObject;
import vdmj.commands.Command;

public class ExuCommand extends Command
{
	private final String line;
	
	public ExuCommand(String line)
	{
		String[] parts = line.split("\\s+", 2);
		
		if (parts.length == 2)
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
