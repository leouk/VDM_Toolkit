package plugins;

import java.util.List;

import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.plugins.AnalysisEvent;
import com.fujitsu.vdmj.plugins.AnalysisPlugin;
import com.fujitsu.vdmj.plugins.EventListener;
import com.fujitsu.vdmj.plugins.events.CheckCompleteEvent;
import com.fujitsu.vdmj.plugins.events.CheckFailedEvent;
import com.fujitsu.vdmj.plugins.events.CheckPrepareEvent;

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

    @Override
    public String getName() {
        return "ISA";
    }

    @Override
    public List<VDMMessage> handleEvent(AnalysisEvent event) throws Exception {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public void init() {
        eventhub.register(CheckPrepareEvent.class, this);
        eventhub.register(CheckCompleteEvent.class, this); 
        eventhub.register(CheckFailedEvent.class, this);  
    }

    //public CommandList getCommands
    
}
