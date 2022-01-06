package vdm2isa.junit;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;

import com.fujitsu.vdmj.messages.Console;

import junit.framework.Test;
import junit.framework.TestSuite;

//import com.fujitsu.vdmj.junit.ModuleTest;

public class TRModuleTest extends TRAbstractModuleTest { //ModuleTest {

    public static Test suite()
    {
      TestSuite suite = new TestSuite();
      TRModuleTest trTests = new TRModuleTest();
      trTests.collectTests(suite, "/");        
      Console.out.println("Test suite contains " + suite.countTestCases() + " tests.");
      return suite;
    }
  
    protected void collectTests(TestSuite suite, String resource)
    {
        URL rurl = getClass().getResource(resource);
        Console.out.println("Collecting tests for URL " + rurl.getPath());
        File directory = new File(rurl.getPath());
        File[] files = null;
        if (!directory.isDirectory())
        {
          URL url = getClass().getResource("/");
          if (url != null) {
            try {
              String urlPath = URLDecoder.decode(url.getFile(), "UTF-8");
              Console.out.println("Looking for tests under: " + urlPath + resource); 
              directory = new File(urlPath + resource);
            } catch (UnsupportedEncodingException e) {
              throw new RuntimeException(e);
            }
            if (!directory.isDirectory()) {
              Console.out.println("No tests to perform on " + directory.getAbsolutePath());            
            } 
            else 
            {
                files = directory.listFiles();
            }       
          } 
          else 
          {
            fail("Could not retrieve a valid testing set under " + directory.getAbsolutePath());
          }
        } else 
        {
            files = directory.listFiles();
        }

        if (files != null) {
            for (File file : files)
            {
              collectTest(suite, file);
            }    
        }
    }

    protected void collectTest(TestSuite suite, File file)
    {    
        String fileName = file.getName();
        if (fileName.indexOf("-errors") == -1 && fileName.endsWith(".vdmsl"))
        {
            //suite.addTest(createTestCase(file.getAbsolutePath()));
        }
    }
}
