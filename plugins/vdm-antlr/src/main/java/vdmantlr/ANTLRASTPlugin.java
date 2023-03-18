package vdmantlr;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.plugins.PluginConsole;
import com.fujitsu.vdmj.plugins.VDMJ;
import com.fujitsu.vdmj.plugins.analyses.ASTPlugin;
import com.fujitsu.vdmj.plugins.analyses.ASTPluginSL;

public class ANTLRASTPlugin extends ASTPluginSL
{

    public static void main(String[] args)
    {
        VDMJ.main(new String[] {"-vdmsl", "-strict", "-annotations", "-i", "-verbose", "-antlr", "sl_document" 
            , "./vdmslScenario/Types.vdmsl"
        });
    }

    public static ASTPlugin factory(Dialect dialect) throws Exception
    {
        if (dialect == Dialect.VDM_SL)
        {
            return new ANTLRASTPlugin();
        }
        else
        {
            throw new IllegalArgumentException("ANTLR parsing only supported for VDM-SL");
        }
    }

    public static String DEFAULT_RULE_NAME = "sl_document";
    private String ruleName;

    public ANTLRASTPlugin()
    {
        super();
        ruleName = DEFAULT_RULE_NAME;
    }

    @Override
	public void usage()
	{
        super.usage();
		PluginConsole.println("-antlr <rule-name>: select a specific ANTLR grammar entry point");
	}

    private boolean validRuleName(String ruleName)
    {
        return VDMParserUtils.validRuleName(ruleName);
    }

	@Override
	public void processArgs(List<String> argv)
	{
        super.processArgs(argv);
		Iterator<String> iter = argv.iterator();
		
		while (iter.hasNext())
		{
            String p = iter.next();
			switch (p)
			{
				case "-antlr":
	    			iter.remove();
	    			
	    			if (iter.hasNext())
	    			{
	    				ruleName = iter.next();
                        if (!validRuleName(ruleName))
                        {
                            ruleName = DEFAULT_RULE_NAME;
                            PluginConsole.fail("-antlr option requires a valid ANTLR grammar rule name; invalid rule = " + ruleName);
                        }
                        else 
    	    				iter.remove();
	    			}
	    			else
	    			{
	    				PluginConsole.fail("-antlr option requires a valid ANTLR grammer rule name");
	    			}
	    			break;
    		}
		}
	}
    
	@Override
	protected List<VDMMessage> syntaxCheck()
	{
		List<VDMMessage> messages = new Vector<VDMMessage>();
		
		for (File file: files)
		{
            VDMASTListener listener = null;			
			try
			{
				listener = new VDMASTListener(file.getAbsolutePath(), Settings.filecharset);
                //TODO could permit VDM parsing from different places? Nice! 
                ParseTree t = listener.production(ruleName);
                ParseTreeWalker.DEFAULT.walk(listener, t);
                astModuleList.addAll(listener.getAST());
			}
			catch (InternalException e)
			{
				messages.addAll(errsOf(e));
			}
			catch (Throwable e)
			{
				messages.addAll(errsOf(e));
			}

			if (listener != null)
			{
				messages.addAll(listener.getErrors());
				messages.addAll(listener.getWarnings());
			}
		}

		return messages;
	}
}
