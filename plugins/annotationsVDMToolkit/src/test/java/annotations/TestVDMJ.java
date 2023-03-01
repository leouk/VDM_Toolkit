package annotations;

import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.plugins.PluginRegistry;
import com.fujitsu.vdmj.plugins.analyses.TCPlugin;
import com.fujitsu.vdmj.plugins.VDMJ;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmjunit.VDMJUnitTestSL;

public class TestVDMJ extends VDMJUnitTestSL {
    
    public static void main(String[] args)
    {
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-annotations", "-i", 
        //    "MinimalTheorem.vdmsl"
        //   ,"Doc.vdmsl"
        //   ,"MinimalTheoremAttr.vdmsl"
        //   ,"MinimalTime.vdmsl"
        //,"Witness.vdmsl"
        "WitnessDates.vdmsl"
        });  
    }

	@Before
    public void setUp()
	{
        VDMJUnitTestSL.setRelease(Release.VDM_10);
	}

    @Test
    public void testTime() throws Exception
	{
        System.out.println("Test @Time annotation");
        readSpecification("MinimalTime.vdmsl");
        assertTrue(getErrors().isEmpty());
	}

    @Test
    public void testDoc() throws Exception
	{
        System.out.println("Test @doc annotation");
        readSpecification("Doc.vdmsl");
        assertTrue(getErrors().isEmpty());
	}

    @Test
    public void testTheorem() throws Exception
	{
        System.out.println("Test @Theorem annotation");
        readSpecification("MinimalTheorem.vdmsl");
        assertTrue(getErrors().isEmpty());
	}

    @Test
    public void testTheoremAttr() throws Exception
	{
        System.out.println("Test @TheoremAttr annotation");
        readSpecification("MinimalTheoremAttr.vdmsl");
        assertTrue(getErrors().isEmpty());
	}

    @Test
    public void testWitness() throws Exception
	{
        System.out.println("Test @Witness annotation");
        readSpecification("Witness.vdmsl");
        assertTrue(getErrors().isEmpty());
	}

    @Test
    public void testWitnessDates() throws Exception
	{
        System.out.println("Test @Witness annotation for pre/post");
        readSpecification("WitnessDates.vdmsl");
        assertTrue(getErrors().isEmpty());
	}

    // protected void printMessages(List<? extends VDMMessage> messages)
    // {
    //     for (VDMMessage message: messages)
    //     {
    //         PluginConsole.println(message.toString());
    //     }
    // }

}
