package util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;

public interface CSVParser {
    
    /**
     * @param stream
     * @return
     * @throws IOException
     */
    public Iterator<String[]> parseCSV(final InputStream stream) throws IOException;

    public String lastError();

    public void clear();

    public CSVSettings getSettings();
}
