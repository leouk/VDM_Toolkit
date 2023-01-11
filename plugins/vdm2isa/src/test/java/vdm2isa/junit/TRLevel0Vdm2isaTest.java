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

    @Override
    protected String getOutputPath()
    {
        return "./src/test/resources/lvl0/.generated/isabelle";
    }

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

    @Test
    public void test5() throws Exception
	{
        runPlugin("vdm2isa", "TestV2IUseBeforeDecl");
	}

    @Test
    public void test6() throws Exception
	{
        runPlugin("vdm2isa", "TestV2ITypes");
	}

    @Test
    public void test7() throws Exception
	{
        runPlugin("vdm2isa", "TestV2ITypesOrdering");
	}

    @Test
    public void test8() throws Exception
	{
        runPlugin("vdm2isa", "TestV2ITypesStructured");
	}

    @Test
    public void test9() throws Exception
	{
        runPlugin("vdm2isa", "TestV2ITypesRecordOrdering");
	}

    @Test
    public void test10() throws Exception
	{
        runPlugin("vdm2isa", "TestV2ITypesGeneric");
	}

    @Test
    public void test11() throws Exception
	{
        runPlugin("vdm2isa", "TestV2ITypesNamed");
	}

    @Test
    public void test12() throws Exception
	{
        runPlugin("vdm2isa", "TestV2ITypesOptional");
	}

    @Test
    public void test13() throws Exception
	{
        runPlugin("vdm2isa", "TestV2ITypesRecords");
	}

    @Test
    public void test14() throws Exception
	{
        runPlugin("vdm2isa", "TestV2ITypesQualifiedOptional");
	}
}
