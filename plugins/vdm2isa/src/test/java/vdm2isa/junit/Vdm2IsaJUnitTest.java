package vdm2isa.junit;

import org.junit.AfterClass;
import org.junit.Assert;

import java.util.List;

import org.junit.Before;
import org.junit.BeforeClass;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.plugins.PluginConsole;
import com.fujitsu.vdmj.plugins.PluginRegistry;
import com.fujitsu.vdmj.plugins.analyses.TCPlugin;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmjunit.VDMJUnitTestSL;

import plugins.GeneralisaPlugin;
import plugins.IsaProperties;
import plugins.ResourceUtil;

public abstract class Vdm2IsaJUnitTest extends VDMJUnitTestSL {

    @BeforeClass
	public static void start() throws Exception
	{
		System.setProperty("vdmj.plugins", "plugins.analyses.IsabellePluginSL");
	}
	
	@AfterClass
	public static void stop()
	{
		System.clearProperty("vdmj.plugins");
	}
    
    protected static void init()
	{
		VDMJUnitTestSL.init();
        VDMJUnitTestSL.setRelease(Release.VDM_10);
        IsaProperties.init();
	}

    protected TCModuleList tclist;
    protected String outputPath;

	@Before
    public void setUp()
	{
		Vdm2IsaJUnitTest.init();
        tclist = ((TCPlugin)PluginRegistry.getInstance().getPlugin("TC")).getTC();
        //tclist = interpreter.getTC();
        outputPath = getOutputPath();
	}

    protected abstract String getOutputPath();

    protected void printMessages(List<? extends VDMMessage> messages)
	{
		for (VDMMessage message: messages)
		{
            PluginConsole.println(message.toString());
		}
    }
    
    protected void runCommand(String name, String module) throws Exception
    {
        GeneralisaPlugin cmd = ResourceUtil.createPlugin(name, interpreter);
        // choose specific module to allow for test granualirty
        //TODO would be better to have one TestCase per file? 
        boolean result = cmd.run(new String[] { name, "set", "ml", module });
        if (!result)
            Assert.fail(name + " plugin could not set modules " + module);
        result = cmd.run(new String[] { name, "set", "o", outputPath });
        if (!result)
            Assert.fail(name + " plugin could not set output path " + module); 
        // every run does a reset of local + global errors
        result = cmd.run(new String[] { name });
        printMessages(GeneralisaPlugin.getWarnings());
        // if plugin run failed or if strictly reporting errors, then fail
        if (!result || (IsaProperties.general_strict && GeneralisaPlugin.getErrorCount() > 0))
        {
            printMessages(GeneralisaPlugin.getErrors());
            
            Assert.fail(name + " plugin failed. Found " + GeneralisaPlugin.getErrorCount() + " errors for module " + module);
        }
    }
}
