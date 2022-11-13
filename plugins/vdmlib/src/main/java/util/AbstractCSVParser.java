package util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;

import com.fujitsu.vdmj.values.ValueList;

public abstract class AbstractCSVParser implements CSVParser {
    
    protected Iterator<String[]> iterator; 
    protected String lastErrorStr;
    protected final CSVSettings settings;

    private AbstractCSVParser()
    {
        clear();
        this.settings = CSVSettings.DEFAULT;
    }

    protected AbstractCSVParser(CSVSettings settingsGiven)
    {
        clear();
        this.settings = settingsGiven;
    }

    @Override
    public final Iterator<String[]> parseCSV(final InputStream stream) throws IOException
    {
        clear();
        iterator = createIterator(stream);
        return iterator; 
    }

    @Override
    public void clear()
    {
        lastErrorStr = "";
        iterator = null;
    }

    /**
     * @return any IO error
     */
    @Override
    public final String lastError()
    {
        return lastErrorStr;
    }

    @Override
    public final CSVSettings getSettings()
    {
        return settings;
    }

    protected abstract Iterator<String[]> createIterator(final InputStream stream) throws IOException;
}
