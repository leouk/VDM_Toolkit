package plugins;

import dap.DAPMessageList;
import dap.DAPRequest;
import json.JSONObject;
import vdmj.commands.Command;

public class ISACommand extends Command
{
	private final String line;
	
	public ISACommand(String line)
	{
		this.line = line;
	}

	@Override
	public DAPMessageList run(DAPRequest request)
	{
		return new DAPMessageList(request, new JSONObject("result", "You typed: " + line));
	}

	@Override
	public boolean notWhenRunning()
	{
		return false;
	}
}
