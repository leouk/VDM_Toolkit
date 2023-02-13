package plugins.analyses;

import java.io.File;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.plugins.AnalysisCommand;
import com.fujitsu.vdmj.plugins.AnalysisEvent;
import com.fujitsu.vdmj.plugins.AnalysisPlugin;
import com.fujitsu.vdmj.plugins.CommandList;
import com.fujitsu.vdmj.plugins.EventListener;
import com.fujitsu.vdmj.plugins.PluginRegistry;
import com.fujitsu.vdmj.plugins.analyses.TCPluginSL;
import com.fujitsu.vdmj.plugins.events.CheckCompleteEvent;
import com.fujitsu.vdmj.plugins.events.CheckPrepareEvent;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import plugins.commands.ExuCommand;
import plugins.commands.IsabelleCommand;

public abstract class IsabellePlugin extends AnalysisPlugin implements EventListener {

    public static IsabellePlugin factory(Dialect dialect) throws Exception
	{
		switch (dialect)
		{
			case VDM_SL:
				return new IsabellePluginSL();
				
			case VDM_PP:				
			case VDM_RT:				
			default:
				throw new Exception("Unknown dialect: " + dialect);
		}
	}

    protected String usageMsg;
    private final CommandList commandsList;
    protected final Set<String> modulesToProcess;
    protected File saveURI; 
    
    protected IsabellePlugin()
    {
        super();
        usageMsg = null;
        saveURI = null;
        modulesToProcess = new HashSet<String>();
        commandsList = new CommandList(ExuCommand.class);   
    }

    @Override
    public String getName() {
        return "ISA";
    }

    @Override
    public void init() {
        usageMsg = null;
        saveURI = null;
        modulesToProcess.clear();
        eventhub.register(CheckPrepareEvent.class, this);
        eventhub.register(CheckCompleteEvent.class, this); 
        //eventhub.register(CheckFailedEvent.class, this);  
    }

    // @Override
	// public void usage()
    // {
    //     PluginConsole.println(sb.toString());
    // }

    protected List<VDMMessage> isabellePrepareEvent(CheckPrepareEvent event)
    {
        return null;
    }

    protected List<VDMMessage> isabelleCompleteEvent(CheckCompleteEvent event)
    {
        return null;
    }

    //protected abstract List<VDMMessage> isabelleFailedEvent(CheckFailedEvent event);

    @Override
    public final List<VDMMessage> handleEvent(AnalysisEvent event) throws Exception {
        if (event instanceof CheckPrepareEvent)
		{
			return isabellePrepareEvent((CheckPrepareEvent)event);
		}
		else if (event instanceof CheckCompleteEvent)
		{
            //TODO: perhaps have Exu as after CheckTypeCheckEvent? 
            return isabelleCompleteEvent((CheckCompleteEvent)event);
		}
        // else if (event instanceof CheckFailedEvent)
        // {
        //     return isabelleFailedEvent((CheckFailedEvent)event);
        // }
		else
		{
			throw new Exception("Unhandled event: " + event);
		}
    }

    public final TCModuleList getTC()
    {
        return ((TCPluginSL)PluginRegistry.getInstance().getPlugin("TC")).getTC();
    }

    @Override
    public AnalysisCommand getCommand(String[] argv)
    {
        return lookup(argv, commandsList);
    }

    @Override
	public void help()
	{
		showHelp(commandsList);
	}
}
