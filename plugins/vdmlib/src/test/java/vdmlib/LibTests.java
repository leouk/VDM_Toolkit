
package vdmlib;

import static org.junit.Assert.assertTrue;
import org.junit.Test;
import com.fujitsu.vdmjunit.VDMJUnitTestSL;

public class LibTests extends VDMJUnitTestSL
{
	@Test
	public void CheckAsserting() throws Exception
	{
		readSpecification("ISQ.vdmsl", "MATH.vdmsl", "Support1.vdmsl", "VDMUtil.vdmsl");
		assertTrue(getWarnings().isEmpty());
	}
}
