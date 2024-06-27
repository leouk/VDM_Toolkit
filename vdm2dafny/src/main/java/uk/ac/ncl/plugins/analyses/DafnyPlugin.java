package uk.ac.ncl.plugins.analyses;

import static com.fujitsu.vdmj.plugins.PluginConsole.fail;
import static com.fujitsu.vdmj.plugins.PluginConsole.println;

import java.io.File;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.plugins.AnalysisCommand;
import com.fujitsu.vdmj.plugins.AnalysisEvent;
import com.fujitsu.vdmj.plugins.AnalysisPlugin;
import com.fujitsu.vdmj.plugins.EventListener;
import com.fujitsu.vdmj.plugins.HelpList;
import com.fujitsu.vdmj.plugins.PluginRegistry;
import com.fujitsu.vdmj.plugins.analyses.TCPluginSL;
import com.fujitsu.vdmj.plugins.events.CheckCompleteEvent;
import com.fujitsu.vdmj.plugins.events.CheckPrepareEvent;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.util.Utils;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
/**
 * Create a new VDMJ plugin.
 * 
 * @author Adam Winstanley
 */
public class DafnyPlugin extends AnalysisPlugin implements EventListener {

    @Override
    public String getName() {
        return "VDM2Dafny";
    }

    @Override
    public int getPriority() {
        return TC_PRIORITY + 1;
    }

    public static DafnyPlugin factory(Dialect dialect) throws UnsupportedOperationException {
        switch (dialect) 
        {
            case VDM_SL: 
                return new DafnyPluginSL();
            case VDM_PP:
            case VDM_RT:
            default:
                throw new UnsupportedOperationException("VDM++ and VDMRT are not supported.");
        }
    }

    protected String usageMsg;
    protected File saveURI;
    protected Set<String> modulesToProcess;

    @Override
    public void init() {
        usageMsg = null;
        saveURI = null;
        modulesToProcess.clear();
        eventhub.register(CheckPrepareEvent.class, this);
        eventhub.register(CheckCompleteEvent.class, this);
    }

    @Override
    public void processArgs(List<String> argv) {
        Iterator<String> iter = argv.iterator(); 
        
        while (iter.hasNext())
        {
            switch (iter.next())
            {
                case "-m":
                    iter.remove();
                    
                    if (iter.hasNext())
                    {
                        modulesToProcess.add(iter.next());
                    }
                    else 
                    {
                        fail("-m <module> option missing");
                    }
                    break;

            }
        }
    }

    public void usage() {
        println("-m <module>: Translate module");
    }

    @Override
    public List<VDMMessage> handleEvent(AnalysisEvent event) throws Exception {
        if (event instanceof CheckPrepareEvent) 
            return dafnyPrepareEvent((CheckPrepareEvent)event);
        else if (event instanceof CheckCompleteEvent)
            return dafnyCompleteEvent((CheckCompleteEvent)event);
        throw new Exception("Unhandled event: " + event);
    }
    

    protected List<VDMMessage> dafnyPrepareEvent(CheckPrepareEvent event) {
        return null;
    }

    protected List<VDMMessage> dafnyCompleteEvent(CheckCompleteEvent event) {
        return null;
    }

    public final TCModuleList getTC() {
        return ((TCPluginSL)PluginRegistry.getInstance().getPlugin("TC")).getTC();
    }

    private DafnyCommandEnum arg2cmd(String[] args) {
        DafnyCommandEnum result = null;
        try {
            if (args != null && args.length > 0)
                result = DafnyCommandEnum.valueOf(args[0].toUpperCase());
        }
        catch (IllegalArgumentException e) 
        {

        }
        return result;
    }

    public AnalysisCommand getCommand(String line) {
        AnalysisCommand result = null;
        
        String[] argv = Utils.toArgv(line);
        DafnyCommandEnum cmd = arg2cmd(argv);
        switch (cmd)
        {
            case VDM2DAFNY:
                result = DafnyTranslateCommand.getInstance(line);
                break;
            default:
                result = null;
        }

        return result;
    }

    @Override 
    public HelpList getCommandHelp() {
        return new HelpList(DafnyTranslateCommand.help());
    }
}
