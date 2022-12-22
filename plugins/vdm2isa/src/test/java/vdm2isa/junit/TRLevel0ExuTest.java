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

    @Test
    public void test5() throws Exception
	{
        runPlugin("exu", "TestV2IUseBeforeDecl");
	}

    @Test
    public void test6() throws Exception
	{
        runPlugin("exu", "TestV2ITypes");
	}

    @Test
    public void test7() throws Exception
	{
        runPlugin("exu", "TestV2ITypesOrdering");
	}

    @Test
    public void test8() throws Exception
	{
        runPlugin("exu", "TestV2ITypesStructured");
	}

    // @Test
    // public void test9() throws Exception
	// {
    //     runPlugin("exu", "TestV2ITypesRecordOrdering");
	// }

    @Test
    public void test10() throws Exception
	{
        runPlugin("exu", "TestV2ITypesGeneric");
	}

    @Test
    public void test11() throws Exception
	{
        runPlugin("exu", "TestV2ITypesNamed");
	}

    @Test
    public void test12() throws Exception
	{
        runPlugin("exu", "TestV2ITypesOptional");
	}

    @Test
    public void test13() throws Exception
	{
        runPlugin("exu", "TestV2ITypesRecords");
	}
}