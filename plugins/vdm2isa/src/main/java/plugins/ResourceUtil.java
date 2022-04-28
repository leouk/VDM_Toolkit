package plugins;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;

public class ResourceUtil
{
    public static final String DEFAULT_ENCODING = "UTF-8";//UTF-8-Isabelle";

    public static boolean found(String resourceURI)
    {
        return ResourceUtil.class.getResource("/" + resourceURI) != null;
    }

	public static InputStreamReader load(String resourceURI) throws IOException
	{
        assert found(resourceURI);
		InputStream in = ResourceUtil.class.getResourceAsStream("/" + resourceURI);
		InputStreamReader isr = new InputStreamReader(in, DEFAULT_ENCODING);
        return isr;
    }

    public static void save(String resourceURI, File targetFile) throws IOException 
    {
        InputStreamReader isr = load(resourceURI);
		OutputStream out = new FileOutputStream(targetFile);
        //@NB I am assuming VDMJ.filecharset is UTF-8, but we need UTF-8-Isabelle?!
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
