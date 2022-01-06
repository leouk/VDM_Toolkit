package vdm2isa.junit;

import java.io.File;
import java.net.URL;
import java.util.List;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.ast.modules.ASTModuleList;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.lex.LexTokenReader;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.messages.VDMError;
import com.fujitsu.vdmj.syntax.ModuleReader;
import com.fujitsu.vdmj.tc.TCNode;
import com.fujitsu.vdmj.tc.modules.TCModuleList;
import com.fujitsu.vdmj.typechecker.ModuleTypeChecker;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import junit.framework.TestCase;

public class TRAbstractModuleTest extends TestCase {
    
    @Override
	protected void setUp() throws Exception
	{
		super.setUp();
		Settings.release = Release.VDM_10;
		Settings.dialect = Dialect.VDM_SL;
	}

	@Override
	protected void tearDown() throws Exception
	{
		super.tearDown();
	}

    //TODO this is copied from com.fujitsu.vdmj.junit.ModuleTest.process
	protected void process(String resource, Integer... expected) throws Exception
	{
		Console.out.println("Processing " + resource + "...");

		URL rurl = getClass().getResource("/" + resource);
		String file = rurl.getPath();

        //TODO @NB couldn't this be wrapped up somewhere? like Utils.parse(String resource)?  
		long before = System.currentTimeMillis();
		LexTokenReader ltr = new LexTokenReader(new File(file), Dialect.VDM_SL);
		ModuleReader mr = new ModuleReader(ltr);
		ASTModuleList parsed = new ASTModuleList();
		parsed.addAll(mr.readModules());
		long after = System.currentTimeMillis();
		Console.out.println("Parsed " + parsed.size() + " modules in " +
   			(double)(after-before)/1000 + " secs. ");
		mr.printErrors(Console.out);
		mr.printWarnings(Console.out);
		assertEquals("Parse errors", 0, mr.getErrorCount());

		before = System.currentTimeMillis();
		TCModuleList checked = ClassMapper.getInstance(TCNode.MAPPINGS).init().convert(parsed);
		TypeChecker typeChecker = new ModuleTypeChecker(checked);
		typeChecker.typeCheck();
		after = System.currentTimeMillis();
   		Console.out.println("Type checked in " + (double)(after-before)/1000 + " secs. ");
		Console.out.println("There were " + TypeChecker.getWarningCount() + " warnings");
		TypeChecker.printErrors(Console.out);

        processErrors("Type check error", TypeChecker.getErrors(), expected);
	}    

    protected void processErrors(String prefix, List<VDMError> errors, Integer... expected)
    {
        //TODO filter by range category? 
        assertEquals(prefix, expected.length, errors.size());

		int p = 0;
		
		for (VDMError err: errors)
		{
			assertEquals(prefix, err.number, expected[p++].intValue());
		}
    }
}
