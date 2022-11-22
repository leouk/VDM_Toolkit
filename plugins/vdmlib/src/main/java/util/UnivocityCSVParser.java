package util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Reader;
import java.util.Iterator;
import java.util.List;

import com.univocity.parsers.csv.CsvParser;
import com.univocity.parsers.csv.CsvParserSettings;

/**
 * Univocity parser have a richer settings and processing capability. Add later?
 */
public class UnivocityCSVParser extends AbstractCSVParser {

    private final CsvParser univocityParser; 
    private final CsvParserSettings univocitySettings; 

    public UnivocityCSVParser(CSVSettings settings) throws FileNotFoundException {
        super(settings);
        univocitySettings = new CsvParserSettings();
        univocityParser = new CsvParser(univocitySettings);
    }

    @Override
    protected Iterator<String[]> createIterator(Reader reader) throws IOException {
        List<String[]> result = univocityParser.parseAll(reader);
       // RecordMetaData mdata;
        return result.iterator();
    }
}
