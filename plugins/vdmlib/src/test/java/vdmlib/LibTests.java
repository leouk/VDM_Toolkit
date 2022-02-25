
package vdmlib;

import static org.junit.Assert.assertTrue;

import org.junit.BeforeClass;
import org.junit.Test;

import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmjunit.VDMJUnitTestSL;

public class LibTests extends VDMJUnitTestSL
{
	@BeforeClass
	public static void before()
	{
		Settings.annotations = true;
	}
	
	@Test
	public void CheckISQ() throws Exception
	{
		readSpecification("ISQ.vdmsl", "MATH.vdmsl", "Support1.vdmsl", "VDMUtil.vdmsl");
		assertTrue(getWarnings().isEmpty());
	}

	@Test
	public void CheckSupport1() throws Exception
	{
		readSpecification("Support1.vdmsl", "MATH.vdmsl", "VDMUtil.vdmsl");
		assertTrue(getWarnings().isEmpty());
	}
}
