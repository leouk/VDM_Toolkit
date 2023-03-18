package vdmantlr;

import java.io.File;
import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.plugins.analyses.ASTPlugin;
import com.fujitsu.vdmj.plugins.analyses.ASTPluginSL;

public class ANTLRASTPlugin extends ASTPluginSL
{
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
