import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.fujitsu.vdmj.runtime.Context;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.VDMFunction;
import com.fujitsu.vdmj.runtime.VDMOperation;
import com.fujitsu.vdmj.runtime.ValueException;
import com.fujitsu.vdmj.values.BooleanValue;
import com.fujitsu.vdmj.values.QuoteValue;
import com.fujitsu.vdmj.values.RecordValue;
import com.fujitsu.vdmj.values.SeqValue;
import com.fujitsu.vdmj.values.TupleValue;
import com.fujitsu.vdmj.values.Value;
import com.fujitsu.vdmj.values.ValueFactory;
import com.fujitsu.vdmj.values.ValueList;

import util.CsvParser3;

/**
 * Implements a CSV loading library in conjunction with 
 * a VDM specification that tighens the notion of what a
 * CSV row/column should contain. 
 * @Author Leo Freitas
 */
public class CSV3 implements Serializable {

    private static final long serialVersionUID = 1L;
	private static String lastErrorStr = "";

    private static final String MODULE_NAME = "CSV3";
    private static final String CSVDATA_NAME = "Data0";
    private static final String HEADER_TYPE_NAME = "Header";
    private static final String HEADER_TYPE = "type";
    private static final String HEADER_INV  = "invariant";

    private static final String CSVTYPE_INTEGER = "Integer";
    private static final String CSVTYPE_FLOAT   = "Float";
    private static final String CSVTYPE_STRING  = "String";

    public enum ParserType { Native, Apache, Univocity, OpenCSV, QuirkCSV };

    private static void check_line_col_size_consistency(int headersLen, int namesLen, Context ctx)
        throws ValueException
    {
        // check input stream matches given headers
        if (headersLen != namesLen)
        {
            throw new ValueException(4999, "Installed headers mismatch: given " + 
                headersLen + " but expected " + namesLen, ctx);
        }        
    }

    protected static File getFile(Value path)
	{
		String adjustedPath = IO.stringOf(path).replace('/', File.separatorChar);        
		File f = new File(adjustedPath).getAbsoluteFile();
        return f;
	}

    protected static ParserType getParserType(Value parser, Context ctx)
        throws ValueException
    {
        return ParserType.valueOf(parser.quoteValue(ctx));
    }

    protected static Iterator<String[]> parse(File file, ParserType parserType)
        throws IOException
    {   
        // file does not exist could occur here 
        BufferedInputStream bufStream = new BufferedInputStream(new FileInputStream(file));
        try
        {
            switch (parserType)
            {
                case Native: 
                    // IOException/read could happen here
                    Iterable<String[]> iter = CsvParser3.parseCSV(bufStream);
                    return iter.iterator();
                default: 
                    throw new IOException("Not yet supported parser type " + parserType.toString());
            }    
        }
        finally
        {
            // ensure expense resources are cleared and GC'ed
            bufStream.close();
            bufStream = null;
        }
    }

    /**
     * Corresponds to VDM "file_status: Path -> FileStatus"
     * @param path absolute path of the file name. File separator (e.g. '/' x '\') will be adjusted if needed. 
     * @return FileStatus <Valid> | <DoesNotExist> | <CannotBeRead> | <CannotBeWritten> | <IsDirectory>; 
     */
    @VDMFunction 
    public static Value file_status(Value path)
    {
        QuoteValue result; 
        File f = getFile(path);
        if (!f.exists()) 
            result = ValueFactory.mkQuote("DoesNotExist");
        else if (!f.canRead())
            result = ValueFactory.mkQuote("CannotBeRead");
        // else if (!f.canWrite())
        //     result = new QuoteValue("CannotBeWritten");
        else if (f.isDirectory())
            result = ValueFactory.mkQuote("IsDirectory");
        else 
            result = ValueFactory.mkQuote("Valid");
        return result;
    }

    /**
     * Corresponds to VDM "csv_read[@p]: Path -> bool * [@p]"
     * @param path file path where it is expected file_status(path) = <Valid>
     * @return
     */
    @VDMFunction
    public static Value csv_read_data(Value path, Value parser, Value headersI)
    {        
        // Follow NB's style from IO.freadval 
		ValueList result = new ValueList();
        File file = getFile(path);
        Value emptyCSV = ValueFactory.mkNil();
        try
        {
            //@NB how to refer to CSV3`EMPTY_CSV here? e.g. mk_(false, EMPTY_CSV)
            // have here because of ValueException?
            emptyCSV = ValueFactory.mkRecord(
                    MODULE_NAME, CSVDATA_NAME, 
                    new SeqValue(), new SeqValue());

            // IO exception could occur here
            Context ctx = Context.javaContext();
            Iterator<String[]> iterr= parse(file, getParserType(parser, ctx));
            
            SeqValue headers = (SeqValue)headersI;

            // read in the header
            ValueList namedHeaders = new ValueList();
            List<RecordValue> headersList = new ArrayList<>(headers.values.size()); 
            if (iterr.hasNext())
            {
                String[] nameStrs = iterr.next();

                // checks the header read matches the headers expected
                check_line_col_size_consistency(headers.values.size(), nameStrs.length, ctx);

                // process the input streat 
                for(int i = 0; i < nameStrs.length; i++)
                {
                    String nameStr = nameStrs[i];
                    assert nameStr.length() > 0;

                    //RecordValue header = headers.get(ValueFactory.mkNat1(i), ctx).recordValue(ctx);
                    headersList.add(headers.values.get(i).recordValue(ctx));
                    
                    // header = mk_Header(nameStr, headersI(i).type, headersI(i).invariant)
                    namedHeaders.add(
                        ValueFactory.mkRecord(
                            MODULE_NAME, HEADER_TYPE_NAME, 
                            new SeqValue(nameStr), 
                            headersList.get(i).fieldmap.get(HEADER_TYPE),
                            headersList.get(i).fieldmap.get(HEADER_INV)
                        )
                    );
                }
            }
            // read in the rows by checking the invariant according to given type in headers param
            ValueList csvRows = new ValueList();
            ValueList cellValues = new ValueList();
            while (iterr.hasNext())
            {
                String[] row = iterr.next();

                // checks the row read matches the headers given
                check_line_col_size_consistency(headersList.size(), row.length, ctx);

                cellValues.clear();

                // process each row
                for(int i = 0; i < row.length; i++)
                {
                    String cell = row[i];
                    assert cell.length() > 0;
                    
                    RecordValue header = headersList.get(i);

                    // get the header declared type
                    String csvType = header.fieldmap.get(HEADER_TYPE).quoteValue(ctx);

                    // create a number
                    if (csvType.equals(CSVTYPE_INTEGER))
                        cellValues.add(ValueFactory.mkInt(Integer.valueOf(cell)));
                    else if (csvType.equals(CSVTYPE_FLOAT))
                    // create a float
                        cellValues.add(ValueFactory.mkReal(Double.valueOf(cell)));
                    else if (csvType.equals(CSVTYPE_STRING))
                    // create a String
                        cellValues.add(new SeqValue(cell));
                    else 
                    // invalid type
                        new ValueException(4998, "Invalid CSV type " + csvType, ctx);
                }
                
                // add row cell values
                csvRows.add(new SeqValue(cellValues));
            }

            // reset tuple value with mk_(true, mk_Data0(headers, rows))
            result.add(new BooleanValue(true));
            RecordValue csvData = ValueFactory.mkRecord(
                    MODULE_NAME, CSVDATA_NAME, 
                    new SeqValue(namedHeaders), 
                    new SeqValue(csvRows));
        
            // check the CSVDATA_NAME invariant, which shouldn't include the
            // dynamic invariant check. This is done later. This is important
            // to allow the loading of "invalid" data into the VDM space, so 
            // that users get a VDM invariant failure check.
            // @NB see CSV3.vdmsl csv_invariants_failed call on loadCSV operation
            //     is it better there or here? Wanted there to be "clear" from the
            //     user's perspective. 
            // @NB invariant checks need the interpreter's context then? 
            csvData.checkInvariant(Interpreter.getInstance().getInitialContext());
            result.add(csvData);
        } catch (Exception e)//IOException
        {
            // on error return mk_(false, [], [])
            lastErrorStr = e.getMessage();

            // get the failed answer here for ValueException catch
            // set failed tuple answer as mk_(false, mk_Data0([]], []]))
            result.add(new BooleanValue(false));
            result.add(emptyCSV);        
        }
        // otherwise, return mk_(true, data)
        assert result.size() == 2;
        return new TupleValue(result);
    }

    /**
     * Corresponds to VDM "lastError: () ==> [String1]".
     * @return [String1]
     */
    @VDMOperation
	public static Value lastError()
	{
		return lastErrorStr.isEmpty() || lastErrorStr == null ? 
            ValueFactory.mkNil() : 
            //@NB ValueFactory.mkSeq doesn't work well for seq of char / Strings
            new SeqValue(lastErrorStr);//ValueFactory.mkSeq(lastErrorStr);
	}
}
