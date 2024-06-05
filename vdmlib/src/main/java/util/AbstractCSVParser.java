package util;

import java.io.IOException;
import java.io.Reader;
import java.util.Iterator;

public abstract class AbstractCSVParser implements CSVParser {
    
    protected Iterator<String[]> iterator; 
    protected String lastErrorStr;
    protected final CSVSettings settings;

    protected AbstractCSVParser(CSVSettings settingsGiven)
    {
        clear();
        this.settings = settingsGiven;
    }

    @Override
    public final Iterator<String[]> parseCSV(final Reader reader) throws IOException
    {
        clear();
        iterator = createIterator(reader);
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

    protected abstract Iterator<String[]> createIterator(final Reader stream) throws IOException;
}
