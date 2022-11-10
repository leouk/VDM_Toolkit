import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import com.fujitsu.vdmj.VDMJ;
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

import util.NativeCSVParser;
import util.ValueFactoryHelper;

/**
 * Implements a CSV loading library in conjunction with 
 * a VDM specification that tighens the notion of what a
 * CSV row/column should contain. 
 * @Author Leo Freitas
 */
public class CSV3 implements Serializable {

    private static final long serialVersionUID = 1L;
	private static String lastErrorStr = "";
    private static Context context = null;

    private static final String MODULE_NAME = "CSV3";
    private static final String CSVDATA_TYPE_NAME = "Data0";
    private static final String CSVDATA_FIELD_HEADERS = "headers";
    private static final String CSVDATA_FIELD_MATRIX    = "matrix";
    private static final String MATRIX_TYPE_NAME    = "Matrix";
    private static final String MATRIX_FIELD_CELLS    = "cells";
    private static final String HEADER_TYPE_NAME = "Header";
    private static final String HEADER_FIELD_NAME = "name";
    private static final String HEADER_FIELD_TYPE = "type";
    private static final String HEADER_FIELD_CELL_INV  = "cell_invariant";
    private static final String HEADER_FIELD_DEFAULT_VALUE = "default";
    private static final String HEADER_FIELD_COL_INV = "col_invariant";
    private static final String CSVTYPE_INTEGER = "Integer";
    private static final String CSVTYPE_FLOAT   = "Float";
    private static final String CSVTYPE_STRING  = "String";

    public enum ParserType { Native, Apache, Univocity, OpenCSV, QuirkCSV };

    public static final void main(String args[])
    {
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-annotations", "-i", 
                "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdmlib/src/main/resources/lib/IO.vdmsl",
                "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdmlib/src/main/resources/lib/VDMUtil.vdmsl",
                "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdmlib/src/main/resources/CSVExample.vdmsl",
                "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdmlib/src/main/resources/CSV3.vdmsl",
            }
        );
    }
    
    private static void check_line_col_size_consistency(int headersLen, int namesLen, int rowCount, Context ctxt)
        throws ValueException
    {
        // check input stream matches given headers
        if (headersLen != namesLen)
        {
            throw new ValueException(4999, "Invalid CSV Data record: expected " + 
                headersLen + " columns per row; found " + namesLen + " columns at row " + 
                rowCount, ctxt);
        }        
    }

    private synchronized static Context getContext()
    {
        if (context == null)
        {
            //@NB which one to choose? Or have a boolean flag for different cases? 
            context = Context.javaContext();
            context = Interpreter.getInstance().getInitialContext();
        }
        return context;
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

    private static String printItem(Value v, String fieldName, Context ctxt)
        throws ValueException
    {
        RecordValue r = v.recordValue(ctxt);
        Value rStr = r.fieldmap.get(fieldName);
        if (rStr == null)
        {
            throw new ValueException(4999, "Invalid CSV Data value to print for " + fieldName, ctxt);
        }
        return rStr.stringValue(ctxt);
    }
    protected static void print(File file, Value data, Context ctxt)
        throws IOException, ValueException
    {
        RecordValue csvData = data.recordValue(ctxt);               // mk_Data0 ::
        Value headers = csvData.fieldmap.get(CSVDATA_FIELD_HEADERS);//      headers: Headers0
        Value matrix = csvData.fieldmap.get(CSVDATA_FIELD_MATRIX);      //      matrix: Rows
        if (headers == null || matrix == null)
        {
            throw new ValueException(4999, "Invalid CSV Data record to print in file " + file.getAbsolutePath(), ctxt);
        }
        StringBuilder sb = new StringBuilder();
        Iterator<Value> it = headers.seqValue(ctxt).iterator();     // Headers0 = seq of Header
        int colCount = 0; 
        int rowCount = 0;
        // iterate over mk_Data(header, -) where it.next: Header
        if (it.hasNext())
        {
            // print name field in mk_Header(n, t, i) = it.next()
            sb.append(printItem(it.next(), HEADER_FIELD_NAME, ctxt));
            colCount++;
            while (it.hasNext())
            {
                sb.append(",");
                sb.append(printItem(it.next(), HEADER_FIELD_NAME, ctxt));
                colCount++;
            }
        }
        sb.append("\n");   
        rowCount++;
        RecordValue rowsRec = matrix.recordValue(ctxt);        // mk_Rows:: 
        Value cells = rowsRec.fieldmap.get(MATRIX_FIELD_CELLS);//     cells: seq of Row
        for (Value row : cells.seqValue(ctxt))               // Row = seq of CSVValue
        {
            ValueList rvl = row.seqValue(ctxt);
            // check headers column count match row's column count
            check_line_col_size_consistency(colCount, rvl.size(), rowCount, ctxt);

            // iterate over each cell in row; it.next() = CSVType value
            it = rvl.iterator();
            if (it.hasNext())
            {
                // print each cell at rowCount for all columns in row
                sb.append(it.next().stringValue(ctxt));
                while (it.hasNext())
                {
                    sb.append(",");
                    sb.append(it.next().stringValue(ctxt));
                }    
            }
            sb.append("\n");
            rowCount++;
        } 
        // generate output
        PrintWriter out = new PrintWriter(file);
		out.write(sb.toString());
		out.close();
        sb = null;
        out = null;
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
                    Iterable<String[]> iter = NativeCSVParser.parseCSV(bufStream);
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
        {
            result = ValueFactory.mkQuote("DoesNotExist");
            lastErrorStr = "CSV file does not exist:\n\t" + f.getAbsolutePath() + "\n"; 
        } 
        else if (!f.canRead())
        {
            result = ValueFactory.mkQuote("CannotBeRead");
            lastErrorStr = "CSV file does not have read permission:\n\t" + f.getAbsolutePath() + "\n"; 
        }
        else if (f.isDirectory())
        {
            result = ValueFactory.mkQuote("IsDirectory");
            lastErrorStr = "CSV file is a directory:\n\t" + f.getAbsolutePath() + "\n"; 
        }
        else 
            result = ValueFactory.mkQuote("Valid");
        return result;
    }

    @VDMFunction
    public static Value csv_write_data(Value path, Value parser, Value data)
    {        
        File file = getFile(path);
        Value result = ValueFactory.mkBool(true); 
        try
        {
            Context ctx = getContext();//javaContext?
            if (!file.canWrite())
                throw new ValueException(4999, "Can't write CSV to read-only file " + file.getAbsolutePath(), ctx);
            
            print(file, data, ctx);
        }
        catch (Exception e)
        {
            lastErrorStr = e.getMessage();
            result = ValueFactory.mkBool(false);
        }
        return result; 
    }



    /**
     * Corresponds to VDM "csv_read_data: Path * CSVParser * Headers0 -> bool * Data0"
     * @param path file path where it is expected file_status(path) = <Valid>
     * @return mk_(true, mk_Data0([ mu(headersI(i), name |-> csvHeaderData) | i in set inds headersI ], csvData)) if successful 
     *         mk_(false, mk_Data0([],[])), otherwise. The true case does a mu on every header
     */
    @VDMFunction
    public static Value csv_read_data(Value path, Value parser, Value headersI)
    {        
        // Follow NB's style from IO.freadval 
		ValueList result = new ValueList();
        File file = getFile(path);
        //@NB this is not the right type for mk_(false, ...)
        Value emptyCSV = ValueFactory.mkNil();

        Context ctx = getContext();//Interpreter's context?
        try
        {
            //@NB how to refer to CSV3`EMPTY_CSV here? e.g. mk_(false, EMPTY_CSV)
            // have here because of ValueException?
            emptyCSV = ValueFactory.mkRecord(
                    MODULE_NAME, CSVDATA_TYPE_NAME, 
                    new SeqValue(), // Headers0: seq of Header 
                    ValueFactory.mkRecord(
                        MODULE_NAME, 
                        MATRIX_TYPE_NAME, 
                        new SeqValue(), // cells: seq of Row 
                        ValueFactory.mkNil() // no row invariant 
                    )
            );

            Iterator<String[]> iterr= parse(file, getParserType(parser, ctx));
            
            // seq of Header0
            SeqValue headers = (SeqValue)headersI;

            // read in the header
            ValueList namedHeaders = new ValueList();
            List<RecordValue> headersList = new ArrayList<>(headers.values.size()); 
            int rowCount = 0;
            if (iterr.hasNext())
            {
                String[] nameStrs = iterr.next();
                
                // checks the header read matches the headers expected
                check_line_col_size_consistency(headers.values.size(), nameStrs.length, rowCount, ctx);

                // process the input streat 
                for(int i = 0; i < nameStrs.length; i++)
                {
                    String nameStr = nameStrs[i];
                    assert nameStr.length() > 0;

                    // prefer the java (0-index) access instead of VDM (1-index).
                    // get each Header0 in headers as list of records
                    //RecordValue headerAtI = headers.get(ValueFactory.mkNat1(i), ctx).recordValue(ctx);
                    RecordValue headerAtI = headers.values.get(i).recordValue(ctx);
                    headersList.add(headerAtI);
                    
                    // namedHeaderAtI = mk_Header(nameStr, headersAtI(i).type, headersAtI(i).invariant)
                    RecordValue namedHeaderAtI = 
                        ValueFactory.mkRecord(
                            MODULE_NAME, HEADER_TYPE_NAME, 
                            ValueFactoryHelper.mkString(nameStr), 
                            headerAtI.fieldmap.get(HEADER_FIELD_TYPE),
                            headerAtI.fieldmap.get(HEADER_FIELD_DEFAULT_VALUE),                            
                            headerAtI.fieldmap.get(HEADER_FIELD_CELL_INV),
                            headerAtI.fieldmap.get(HEADER_FIELD_COL_INV)
                        );
                    //@NB which one is best? Seems like the Mu one? 
                    //mu seems simpler?
                    namedHeaderAtI = 
                        ValueFactoryHelper.muRecord(
                            headerAtI, 
                            ValueFactoryHelper.mkFieldMap(
                                    Arrays.asList(HEADER_FIELD_NAME), 
                                    ValueFactoryHelper.mkValueList(ValueFactoryHelper.mkString(nameStr)), 
                                    Arrays.asList(true),
                                    ctx), 
                            ctx
                        );

                    namedHeaders.add(namedHeaderAtI);
                }
                rowCount++;
            }

            // read in the matrix by checking the invariant according to given type in headers param
            ValueList csvMatrix = new ValueList();
            ValueList cellValues = new ValueList();
            while (iterr.hasNext())
            {
                String[] row = iterr.next();

                // checks the row read matches the headers given
                check_line_col_size_consistency(headersList.size(), row.length, rowCount, ctx);

                // clear accumulated cell values per row count
                cellValues.clear();

                // process each row cell
                for(int i = 0; i < row.length; i++)
                {
                    String cell = row[i];
                    assert cell.length() > 0;
                    
                    RecordValue header = headersList.get(i);

                    // get the header declared type
                    String csvType = header.fieldmap.get(HEADER_FIELD_TYPE).quoteValue(ctx);

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
                        throw new ValueException(4998, "Invalid CSV type " + 
                            csvType + " at row " + rowCount + " col " + (i+1), ctx);
                }
                
                // add row cell values
                csvMatrix.add(new SeqValue(cellValues));
                rowCount++;
            }

            // reset tuple value with mk_(true, mk_Data0(headers, matrix))
            result.add(new BooleanValue(true));
            RecordValue csvData = ValueFactory.mkRecord(
                    MODULE_NAME, CSVDATA_TYPE_NAME, 
                    new SeqValue(namedHeaders),
                    ValueFactory.mkRecord(
                        MODULE_NAME, MATRIX_TYPE_NAME, 
                        new SeqValue(csvMatrix),
                        ValueFactory.mkNil()
                    )
            ); 
        
            // check the CSVDATA_TYPE_NAME invariant, which shouldn't include the
            // dynamic invariant check. This is done later. This is important
            // to allow the loading of "invalid" data into the VDM space, so 
            // that users get a VDM invariant failure check.
            // @NB see CSV3.vdmsl csv_invariants_failed call on loadCSV operation
            //     is it better there or here? Wanted there to be "clear" from the
            //     user's perspective. 
            // @NB invariant checks need the interpreter's context then? 
            csvData.checkInvariant(ctx);//Interpretr's context?
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
     * Corresponds to VDM "lastError: () ==> [String1]". Once called, clear.
     * @return [String1]
     */
    @VDMOperation
	public static Value lastError()
	{
		Value result = lastErrorStr.isEmpty() || lastErrorStr == null ? 
            ValueFactory.mkNil() : 
            //@NB ValueFactory.mkSeq doesn't work well for seq of char / Strings
            new SeqValue(lastErrorStr);//ValueFactory.mkSeq(lastErrorStr);
        lastErrorStr = "";
        return result;
	}
}
