package vdmantlr;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.ast.modules.ASTModuleList;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.lex.LexTokenReader;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.plugins.PluginConsole;
import com.fujitsu.vdmj.plugins.VDMJ;
import com.fujitsu.vdmj.plugins.analyses.ASTPlugin;
import com.fujitsu.vdmj.plugins.analyses.ASTPluginSL;
import com.fujitsu.vdmj.syntax.ModuleReader;

public class ANTLRASTPlugin extends ASTPluginSL
{

    public static void main(String[] args)
    {
        VDMJ.main(new String[] {"-vdmsl", "-strict", "-annotations", "-i" 
            //, "-verbose" 
            ,"-antlr", "sl_document" 
            //, "-antlrAST"
            , "-printAST" 
            , "-std"
            //, "-antlrDebug"
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
    private boolean antlrAST;
    private boolean printAST;
    private boolean stdParse;
    private boolean antlrDebug;

    public ANTLRASTPlugin()
    {
        super();
        antlrAST = false;
        printAST = false;
        stdParse = false;
        antlrDebug = false;
        ruleName = DEFAULT_RULE_NAME;
    }

    @Override
	public void usage()
	{
        super.usage();
		PluginConsole.println("-antlr <rule-name>: select a specific ANTLR grammar entry point");
		PluginConsole.println("-antlrAST: prints out ANTLR's S-expression of parse tree");
		PluginConsole.println("-printAST: prints out VDM string of generated VDM AST");
        PluginConsole.println("-antlrDebug: switches on various ANTLR diagnostics (slows parsing down)");
        PluginConsole.println("-std: also parses and prints AST with VDMJ parser");
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
			switch (iter.next())
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
                case "-antlrAST":
                    iter.remove();
                    antlrAST = true;
                    break;
                case "-printAST":
                    iter.remove();
                    printAST = true;
                    break;
                case "-std":
                    iter.remove();
                    stdParse = true;
                    break;
                case "-antlrDebug":
                    iter.remove();
                    antlrDebug = true;
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
				listener = new VDMASTListener(file.getAbsolutePath(), Settings.filecharset, antlrDebug);
                //TODO could permit VDM parsing from different places? Nice! 
                ParseTree t = listener.production(ruleName);
                ParseTreeWalker.DEFAULT.walk(listener, t);
                String antlrVDMString = "switch \"-printAST\" first!";
                if (antlrAST)
                    PluginConsole.println("\ntree="+listener.toSString(t)+"\n");
                if (printAST)
                {
                    antlrVDMString = listener.toVDMString(t);
                    PluginConsole.println("VDM=" + antlrVDMString +"\n");
                }
                if (stdParse)
                {
                    if (ruleName.equals("sl_document"))
                    {
                        ModuleReader mr = new ModuleReader(new LexTokenReader(file, Dialect.VDM_SL, Settings.filecharset));
                        ASTModuleList list = mr.readModules();
                        String stdString = list.toString();
                        PluginConsole.println("StdVDM=" + stdString +"\n");
                        PluginConsole.println("StdVDM equal ANTLRVDM? " + antlrVDMString.equals(stdString));
                    }
                    else 
                        PluginConsole.fail("VDMJ parsing *must* start from \"sl_document\" rule name! Found " + ruleName);
                }
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
