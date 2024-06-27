package uk.ac.ncl.plugins;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.lang.reflect.Method;
import java.net.URL;

import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.plugins.AnalysisCommand;
import com.fujitsu.vdmj.plugins.AnalysisPlugin;
import com.fujitsu.vdmj.plugins.PluginConsole;
import com.fujitsu.vdmj.plugins.PluginRegistry;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

import uk.ac.ncl.plugins.analyses.DafnyPlugin;
import uk.ac.ncl.plugins.commands.DafnyCommand;

public class ResourceUtil
{
    public static final String DEFAULT_ENCODING = "UTF-8";//UTF-8-Isabelle";

	public static final String DEFAULT_SAVEURI = "./.generated/dafny"; 

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

	/**
	 * Loads a given string as an URL that is known within the class path. 
	 * @param resourceURI
	 * @return
	 */
	public static URL loadURL(String resourceURI)  
	{
		// src/main/resources is on the classpath, and rules seem to just require the extra /templates/ path *with* the leading "/"!
        // https://stackoverflow.com/questions/16374235/resources-and-config-loading-in-maven-project
		assert found(resourceURI);
		URL result = ResourceUtil.class.getResource("/" + resourceURI);
		return result;
	}

	/**
	 * Looks for the given resource URI to be loaded from the class path (class.getResource),
	 * saving the result on the given target file output. If effectively copies the file
	 * @param fromResourceURI
	 * @param targetFile
	 * @throws IOException
	 */
    public static void copyTo(String fromResourceURI, File targetFile) throws IOException 
    {
        InputStreamReader isr = loadStream(fromResourceURI);
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
	
	public static void saveTo(String fromResourceName, File targetDirectory) 
	{
		// String dir; 
		// // if no saveURI is set, then use the "default" 
		// if (this.saveURI == null)
		// {
		// 	dir = module.files.get(0).getParent();
		// 	if (dir == null) 
		// 		dir = ".";
		// 	dir = dir + File.separator + IsabelleCommand.DEFAULT_SAVEURI; 
		// }
		// else 
		// {
		// 	dir = saveURI.toURI().toString();     		
		// }
		// File outfile = new File(targetDirectory, fromResourceName);
		// try 
		// {
		// 	Files.createDirectories(Paths.get(targetDirectory.toURI()));
		// } 		
	}

	@SuppressWarnings("unchecked")
	public static <T extends AnalysisCommand> T createCommand(String name) throws NoSuchMethodException, ClassNotFoundException, IllegalAccessException, Exception
	{
		AnalysisCommand result = PluginRegistry.getInstance().getCommand(name);
		
		if (result == null)
		{
			DafnyPlugin dafny = DafnyPlugin.factory(Dialect.VDM_SL);
			PluginRegistry.getInstance().registerPlugin(dafny);
			result = PluginRegistry.getInstance().getCommand(name);
		}

		if (result == null && System.getProperty("vdmj.plugins") != null)
		{
			String[] plugins = System.getProperty("vdmj.plugins").split("\\s*[,;]\\s*");
			
			for (String plugin: plugins)
			{
				try
				{
					Class<?> clazz = Class.forName(plugin);
					Method factory = clazz.getMethod("factory", Dialect.class);
					AnalysisPlugin instance = (AnalysisPlugin)factory.invoke(null, Settings.dialect);
					PluginRegistry.getInstance().registerPlugin(instance);
					PluginConsole.verbose("Registered " + plugin + " plugin");
				}
				catch (NoSuchMethodException e)
				{
					PluginConsole.println("vdmj.plugins = " + System.getProperty("vdmj.plugins"));
					PluginConsole.println("Cannot load plugin: " + plugin);
					throw e;
				}
			}
		}
		return (T)result;
	}

	public static boolean runPlugin(String name, String args) throws Exception
	{
		if (name == null || name.isEmpty())
			throw new IllegalArgumentException("Plugin name cannot be empty");
		AnalysisCommand cmd = PluginRegistry.getInstance().getCommand(name);
		if (cmd == null || !(cmd instanceof DafnyCommand))
			throw new IllegalArgumentException("Isabelle command " + name + " needs to be created first");
		
		String[] argv = (args == null || args.length() == 0) ? new String[0] : args.split("\\s+");
		return ((DafnyCommand)cmd).run(argv);
	}

    public static File getParentFile(TCModuleList modulelist) {
        File result = null;
		if (modulelist != null && modulelist.size() > 0)
		{
			result = getParentFile(modulelist.get(0));
		}
		return result;
    }

	public static File getParentFile(TCModule module)
	{
		File result = null; 
		if (module != null && module.files.size() > 0)
		{
			result = module.files.get(0).getParentFile();
		}
		return result;
	}

    public static File defaultSaveURI(File parentFile) {
        return new File(parentFile, ResourceUtil.DEFAULT_SAVEURI);
    }
}
