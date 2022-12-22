package vdm2isa.junit;

import org.junit.Assert;

import java.util.List;

import org.junit.Before;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmjunit.VDMJUnitTestSL;

import plugins.GeneralisaPlugin;
import plugins.IsaProperties;
import plugins.ResourceUtil;

public abstract class Vdm2IsaJUnitTest extends VDMJUnitTestSL {

    protected static void init()
	{
		VDMJUnitTestSL.init();
        VDMJUnitTestSL.setRelease(Release.VDM_10);
	}

    protected TCModuleList tclist;

	@Before
    public void setUp()
	{
		Vdm2IsaJUnitTest.init();
        tclist = interpreter.getTC();
	}

    protected void printMessages(List<? extends VDMMessage> messages)
	{
		for (VDMMessage message: messages)
		{
			System.out.println(message);
		}
    }

    protected void runPlugin(String line, boolean result) throws Exception
    {
        if (!result) Assert.fail(line + " plugin call raised errors (see stdout)");
        //result = ResourceUtil.runPlugin(line, interpreter);
        if (!result) Assert.fail(line + " plugin call raised errors (see stdout)");
    }
    
    protected void runPlugin(String name, String module) throws Exception
    {
        GeneralisaPlugin cmd = ResourceUtil.createPlugin(name, interpreter);
        // choose specific module to allow for test granualirty
        //TODO would be better to have one TestCase per file? 
        boolean result = cmd.run(new String[] { name, "set ml " + module });
        if (!result)
        Assert.fail(name + " plugin could not set modules " + module);
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
