package vdm2isa.junit;

import org.junit.Assert;

import java.util.Arrays;
import java.util.List;

import org.junit.Before;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.messages.VDMMessage;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmjunit.VDMJUnitTestSL;

import plugins.GeneralisaPlugin;
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
        //TODO Will this already raise an exception if errors found? 
        GeneralisaPlugin.processVDMWarnings(Vdm2IsaJUnitTest.reader.getWarnings());

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
        boolean result = cmd.run(new String[] { "set ml " + module });
        if (!result)
            Assert.fail(name + " plugin could not set modules " + module);
        result = cmd.run(new String[] {});
        if (!result)
        {
            printMessages(cmd.getErrors());
        }
    }
}
