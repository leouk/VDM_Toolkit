package plugins;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.fujitsu.vdmj.commands.CommandPlugin;
import com.fujitsu.vdmj.config.Properties;
import com.fujitsu.vdmj.runtime.Interpreter;

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

	/** The cache of loaded plugin instances */
	private static final Map<String, CommandPlugin> plugins = new HashMap<String, CommandPlugin>();

	@SuppressWarnings("unchecked")
	public static <T extends CommandPlugin> T getPlugin(String name)
	{
		CommandPlugin c = plugins.get(name);
		if (c != null) 
			return (T)c; 
		else 
			return null;
	}

	/**
	 * Mimics CommandReader's use plugin method: looks for plugins within the right paths
	 * using naming convention, then runs then. Useful for jUnit testing. 
	 * @param line
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static <T extends CommandPlugin> T createPlugin(String name, Interpreter interpreter) throws NoSuchMethodException, InvocationTargetException, ClassCastException
	{
		T cmd = getPlugin(name);
		
		if (cmd != null)
		{
			return cmd;
		}
		
		String plugin = Character.toUpperCase(name.charAt(0)) + name.substring(1).toLowerCase() + "Plugin";
		String[] packages = Properties.cmd_plugin_packages.split(";|:");
		
		for (String pack: packages)
		{
			try
			{
				Class<?> clazz = Class.forName(pack + "." + plugin);

				if (CommandPlugin.class.isAssignableFrom(clazz))
				{
					Constructor<?> ctor = clazz.getConstructor(Interpreter.class);
					cmd = (T)ctor.newInstance(interpreter);
					plugins.put(name, cmd);
					return cmd;
				}
			}
			catch (ClassNotFoundException e)
			{
				// Try next package
			}
			catch (InstantiationException e)
			{
				// Try next package
			}
			catch (IllegalAccessException e)
			{
				// Try next package
			}
		}

		return null;
	}

	public static boolean runPlugin(String name, String args) throws Exception
	{
		if (name == null || name.isEmpty())
			throw new IllegalArgumentException("Plugin name cannot be empty");
		CommandPlugin cmd = getPlugin(name);
		if (cmd == null)
			throw new IllegalArgumentException("Plugin " + name + " needs to be created first");
		
		String[] argv = (args == null || args.length() == 0) ? new String[0] : args.split("\\s+");
		return cmd.run(argv);
	}
}
