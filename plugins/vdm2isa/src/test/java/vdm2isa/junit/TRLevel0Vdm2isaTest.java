package vdm2isa.junit;

import org.junit.BeforeClass;
import org.junit.Test;

public class TRLevel0Vdm2isaTest extends Vdm2IsaJUnitTest
{
	@BeforeClass
	public static void start() throws Exception
	{
		readSpecification("lvl0");
	}
    
    //TODO pick at CZT's to get a test suite per file in the directory
    @Test
    public void test0() throws Exception
	{
        runPlugin("vdm2isa", "TestV2IEmpty");
	}

    @Test
    public void test1() throws Exception
	{
        runPlugin("vdm2isa", "TestV2IExprs");
	}

    @Test
    public void test2() throws Exception
	{
        runPlugin("vdm2isa", "TestV2IFcns");
	}

    @Test
    public void test3() throws Exception
	{
        runPlugin("vdm2isa", "TestV2IDeclBeforeUse");
	}

    @Test
    public void test4() throws Exception
	{
        runPlugin("vdm2isa", "TestV2IUseBeforeDecl");
	}
}
