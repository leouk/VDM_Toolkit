package plugins;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URL;

public class ResourceUtil
{
    public static final String DEFAULT_ENCODING = "UTF-8";//UTF-8-Isabelle";

    public static boolean found(String resourceURI)
    {
        return ResourceUtil.class.getResource("/" + resourceURI) != null;
    }

	public static InputStreamReader loadStream(String resourceURI) throws IOException
	{
        assert found(resourceURI);
		InputStream in = ResourceUtil.class.getResourceAsStream("/" + resourceURI);
		InputStreamReader isr = new InputStreamReader(in, DEFAULT_ENCODING);
        return isr;
    }

	public static URL loadURL(String resourceURI)  
	{
		// src/main/resources is on the classpath, and rules seem to just require the extra /templates/ path *with* the leading "/"!
        // https://stackoverflow.com/questions/16374235/resources-and-config-loading-in-maven-project
		assert found(resourceURI);
		URL result = ResourceUtil.class.getResource(resourceURI);
		return result;
	}

    public static void save(String resourceURI, File targetFile) throws IOException 
    {
        InputStreamReader isr = loadStream(resourceURI);
		OutputStream out = new FileOutputStream(targetFile);
		// given the output is in YXML, UTF-8 is fine. 
		OutputStreamWriter osr = new OutputStreamWriter(out, DEFAULT_ENCODING);
		
		char[] buf = new char[8192];
	    int length;

	    while ((length = isr.read(buf, 0, 8192)) > 0)
	    {
	        osr.write(buf, 0, length);
	    }
	    
		isr.close();
		osr.close();		
	}    
}
