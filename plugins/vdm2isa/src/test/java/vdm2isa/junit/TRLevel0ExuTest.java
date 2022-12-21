package vdm2isa.junit;

import org.junit.BeforeClass;
import org.junit.Test;

public class TRLevel0ExuTest extends Vdm2IsaJUnitTest
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
        runPlugin("exu", "TestV2IEmpty");
	}

    @Test
    public void test1() throws Exception
	{
        runPlugin("exu", "TestV2IExprs");
	}

    @Test
    public void test2() throws Exception
	{
        runPlugin("exu", "TestV2IFcns");
	}

    @Test
    public void test3() throws Exception
	{
        runPlugin("exu", "TestV2IDeclBeforeUse");
	}

    @Test
    public void test4() throws Exception
	{
        runPlugin("exu", "TestV2IUseBeforeDecl");
	}
}
