
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.VDMJ;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.runtime.Context;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.VDMFunction;
import com.fujitsu.vdmj.runtime.VDMOperation;
import com.fujitsu.vdmj.runtime.ValueException;
import com.fujitsu.vdmj.values.RealValue;
import com.fujitsu.vdmj.values.RecordValue;
import com.fujitsu.vdmj.values.SeqValue;
import com.fujitsu.vdmj.values.TupleValue;
import com.fujitsu.vdmj.values.Value;
import com.fujitsu.vdmj.values.ValueFactory;
import com.fujitsu.vdmj.values.ValueList;
import com.fujitsu.vdmj.values.ValueSet;

import util.CSVParser;
import util.CSVSettings;
import util.NativeCSVParser;
import util.UnivocityCSVParser;
import util.ValueFactoryHelper;

/**
 * Implements a CSV loading library in conjunction with 
 * a VDM specification that tighens the notion of what a
 * CSV row/column should contain. 
 * @Author Leo Freitas
 */
public class CSVLib implements Serializable {

    private static final long serialVersionUID = 1L;
	private static String lastErrorStr = "";
    private static Context context = null;
    private static Reader reader = null;
    private static CSVParser parser = null;

    private static final String MODULE_NAME = "CSVLib";
    
    // CSVLib.vdmsl declared top-level type names *must* match
    private static final String CSVDATA_TYPE_NAME = "Data0";
    //private static final String CSVSETTINGS_TYPE_NAME = "CSVSettings";
    private static final String MATRIX_TYPE_NAME    = "Matrix";
    private static final String ERROR_TYPE_NAME = "Error";
    
    // CSVLib.vdmsl record types (Data0, CSVSettings, Matrix, Error) field names *must* match
    private static final String CSVDATA_FIELD_HEADERS = "headers";
    private static final String CSVDATA_FIELD_MATRIX    = "matrix";
    private static final String CSVDATA_FIELD_SETTINGS = "settings";
    private static final String CSVSETTINGS_FIELD_SKIPBLANKS = "skipBlankLines";
    private static final String CSVSETTINGS_FIELD_COMMENTSTR = "lineCommentStr";
    private static final String MATRIX_FIELD_CELLS    = "cells";
    private static final String HEADER_FIELD_NAME = "name";
    private static final String HEADER_FIELD_TYPE = "type";
    private static final String HEADER_FIELD_DEFAULT_VALUE = "default";
    
    // CSVLib.vdmsl CSVType names *must* match
    private static final String CSVTYPE_INTEGER = "Integer";
    private static final String CSVTYPE_FLOAT   = "Float";
    private static final String CSVTYPE_STRING  = "String";
    private static final String CSVTYPE_BOOLEAN = "Boolean";

    // CSVLib.vdmsl quote type values *must* match
    public enum ParserType { Native, Apache, Univocity, OpenCSV, QuirkCSV };

    public static final void main(String args[])
    {
        // With the launch.json cwd working directory, can give relative paths
        // DO NOT add/use $VDMJTK_HOME on file names (!!!!)
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-annotations", "-default", "CSVExample", "-i", 
                "./lib/IO.vdmsl",
                "./lib/CSV.vdmsl",
                "./lib/VDMUtil.vdmsl",
                "./CSVExample.vdmsl",
                "./CSVLib.vdmsl",
                "./lib/MATH.vdmsl",
                "./Support1.vdmsl",
                "./ISQ.vdmsl",
                "./performance/TimeTestCSV.vdmsl",
            }
        );
    }

    private static void close() throws IOException
    {
        if (reader != null)
        { 
            reader.close();
        }
        reader = null;
        if (parser != null)
        {
            parser.clear();
        }
        parser = null;
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

    private static ParserType getParserType(Value parser, Context ctx)
        throws ValueException
    {
        return ParserType.valueOf(parser.quoteValue(ctx));
    }

    private static File getFile(Value path)
	{
		String adjustedPath = IO.stringOf(path).replace('/', File.separatorChar);        
		File f = new File(adjustedPath).getAbsoluteFile();
        return f;
	}

    private static String printHeader(Value h, Context ctxt)
        throws ValueException
    {
        RecordValue header = h.recordValue(ctxt);
        Value headerName = header.fieldmap.get(HEADER_FIELD_NAME); // [String1]
        if (headerName == null)
        {
            throw new ValueException(4999, "Invalid CSV Data value to print for " + HEADER_FIELD_NAME, ctxt);
        }
        // field name must be a string, as it's a Header (not Header0) at this point.
        String headerNameStr = headerName.stringValue(ctxt);//IO.stringOf(headerName) if want to include nil case
        return quoteScape(headerNameStr);
    }

    private static String printItem(Value v, long precision)
    {
        String result;
        if (v instanceof RealValue)
        {
            assert precision >= 0;
            result = ValueFactoryHelper.stringOfReal((RealValue)v, precision);
        }
        else 
        {
            result = IO.stringOf(v);
        }
        return quoteScape(result);
    }

    //@todo presume there will be more cases? 
    private static String quoteScape(String s)
    {
        return s.indexOf(" ") != -1 || s.indexOf("\t") != -1 || s.indexOf("\n") != -1 || s.indexOf("\r") != -1 ? "\"" + s + "\"" : s;
    }

    private static Value processCell(int rowCount, int colCount, String csvType, String cell, Context ctx)
    throws Exception
    {
        Value result;
        // create a number
        if (csvType.equals(CSVTYPE_INTEGER))
            result = //new IntegerValue(Long.valueOf(cell));//
                     ValueFactory.mkInt(Long.valueOf(cell));
        else if (csvType.equals(CSVTYPE_FLOAT))
        // create a float: could raise Exception if infinite or NaN etc. 
            result = //new RealValue(Double.valueOf(cell));//
                     ValueFactory.mkReal(Double.valueOf(cell));
        else if (csvType.equals(CSVTYPE_STRING))
        // create a String
            result = //new SeqValue(cell);//
                     ValueFactoryHelper.mkString(cell);
        else if (csvType.equals(CSVTYPE_BOOLEAN))
        // creates a bool
            result = //new BooleanValue(Boolean.valueOf(cell));//
                     ValueFactory.mkBool(Boolean.valueOf(cell));
        else 
        // invalid type
            throw new ValueException(4998, "Invalid CSV type " + 
                csvType + " at row " + rowCount + " col " + (colCount+1), ctx);
        return result;
    }

    private static String plural(int n, String s, String pl)
    {
        return n + " " + (n != 1 ? s + pl : s);
    }

    /**
     * 
     * @param rowNo VDM indexed row
     * @param expectedCol expected column size
     * @param givenCol given column size
     * @param reason detail
     * @return list of errors from given to expected, assuming givenCol < expectedCol
     * @throws ValueException
     */
    private static ValueList createError(int rowNo, int expectedCol, int givenCol, String reason)
        throws ValueException
    {
        assert givenCol < expectedCol; 
        ValueList result = new ValueList();
        // Row number is already VDM based, so no padding
        // Column numbers are Java based, so pad +1
        //for(int colNo = givenCol; colNo < expectedCol; colNo++)
        //{
            // only a single error, given the whole row will be filtered out
            result.add(ValueFactoryHelper.mkRecord(
                MODULE_NAME, ERROR_TYPE_NAME, 
                ValueFactory.mkInt(Long.valueOf(rowNo)),
                ValueFactory.mkInt(Long.valueOf(givenCol+1)),
                ValueFactoryHelper.mkString("CSV row " + rowNo + " is too short for header: expected " + 
                    plural(expectedCol, "columns", "s") + " found " + plural(givenCol, "column", "s"))));
        //}
        return result;
    }

    protected static CSVSettings getCSVSettings(Value settings, Context ctxt) throws ValueException
    {
        RecordValue rsettings = settings.recordValue(ctxt);
        Value skipBlanks = rsettings.fieldmap.get(CSVSETTINGS_FIELD_SKIPBLANKS); // bool
        Value cmtStr = rsettings.fieldmap.get(CSVSETTINGS_FIELD_COMMENTSTR);     // [String1]
        return new CSVSettings(ValueFactoryHelper.mkValueList(skipBlanks, cmtStr), ctxt);
    }

    protected static Iterator<String[]> parse(File file, ParserType parserType, CSVSettings settings)
    throws IOException, ValueException
    {   
        // file does not exist could occur here 
        reader = new BufferedReader(new FileReader(file));
        switch (parserType)
        {
            // IOException/read could happen here
            case Native: 
                parser = new NativeCSVParser(settings);
                return parser.parseCSV(reader);
            case Univocity:
                parser = new UnivocityCSVParser(settings);
                return parser.parseCSV(reader);
            default: 
                close();
                throw new IOException("Not yet supported parser type " + parserType.toString());
        }
    }

    protected static void print(File file, Value data, Value precision, Context ctxt)
        throws IOException, ValueException
    {
        RecordValue csvData = data.recordValue(ctxt);                   // mk_Data0 ::
        Value settings = csvData.fieldmap.get(CSVDATA_FIELD_SETTINGS);  //      settings: CSVSettings
        Value headers = csvData.fieldmap.get(CSVDATA_FIELD_HEADERS);    //      headers: Headers0
        Value matrix = csvData.fieldmap.get(CSVDATA_FIELD_MATRIX);      //      matrix: Rows
        if (settings == null || headers == null || matrix == null)
        {
            throw new ValueException(4999, "Invalid CSV Data record to print in file " + file.getAbsolutePath(), ctxt);
        }
        StringBuilder sb = new StringBuilder();

        // process settings as a comment, if those are allowed; ignore it otherwise
        CSVSettings csvSettings = getCSVSettings(settings, ctxt);
        if (csvSettings.lineCommentStr != null)
        {
            // if comment strings are allowed
            String skipping = csvSettings.skipBlankLines ? "with blanks skiped" : "without blanks skiped"; 
            sb.append(csvSettings.lineCommentStr);
            sb.append(" VDM CSVLib print " + skipping);
            sb.append("\n");
        }       

        // process header
        Iterator<Value> it = headers.seqValue(ctxt).iterator();     // Headers0 = seq of Header
        int colCount = 0; 
        int rowCount = 0;
        // iterate over mk_Data(header, -) where it.next: Header
        if (it.hasNext())
        {
            // print name field in mk_Header(n, t, i) = it.next()
            sb.append(printHeader(it.next(), ctxt));
            colCount++;
            while (it.hasNext())
            {
                sb.append(",");
                sb.append(printHeader(it.next(), ctxt));
                colCount++;
            }
        }
        sb.append("\n");   
        rowCount++;

        // process records
        RecordValue rowsRec = matrix.recordValue(ctxt);        // mk_Rows:: 
        Value cells = rowsRec.fieldmap.get(MATRIX_FIELD_CELLS);//     cells: seq of Row
        long prec = precision.natValue(ctxt);
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
                //sb.append(it.next().stringValue(ctxt));
                sb.append(printItem(it.next(), prec));
                while (it.hasNext())
                {
                    sb.append(",");
                    sb.append(printItem(it.next(), prec));
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

    /**
     * Corresponds to VDM "file_status: Path -> FileStatus"
     * @param path absolute path of the file name. File separator (e.g. '/' x '\') will be adjusted if needed. 
     * @return FileStatus <Valid> | <DoesNotExist> | <CannotBeRead> | <CannotBeWritten> | <IsDirectory>; 
     */
    @VDMFunction 
    public static Value file_status(Value path)
    {
        Value result; 
        File f = getFile(path);
        if (!f.exists())
        {
            result = ValueFactory.mkQuote("DoesNotExist");
            //lastErrorStr = "CSV file does not exist:\n\t" + f.getAbsolutePath() + "\n"; 
        } 
        else if (!f.canRead())
        {
            result = ValueFactory.mkQuote("CannotBeRead");
            //lastErrorStr = "CSV file does not have read permission:\n\t" + f.getAbsolutePath() + "\n"; 
        }
        else if (f.isDirectory())
        {
            result = ValueFactory.mkQuote("IsDirectory");
            //lastErrorStr = "CSV file is a directory:\n\t" + f.getAbsolutePath() + "\n"; 
        }
        else 
            result = ValueFactory.mkQuote("Valid");
        return result;
    }

    /**
     * Corresponds to VDM "csv_read_data: Path * CSVParser * Headers0 -> bool * Data0"
     * @param path file path where it is expected file_status(path) = <Valid>
     * @return mk_(true, mk_Data0([ mu(headersI(i), name |-> csvHeaderData) | i in set inds headersI ], csvData)) if successful 
     *         mk_(false, mk_Data0([],[])), otherwise. The true case does a mu on every header
     */
    @VDMFunction
    public static Value csv_read_data(Value path, Value parser, Value settings, Value headersI)
    {        
        // Follow NB's style from IO.freadval 
		ValueList result = new ValueList();
        File file = getFile(path);
        //@NB this is not the right type for mk_(false, ...)
        Value emptyCSV = ValueFactory.mkNil();

        Context ctx = getContext();//Interpreter's context?
        try
        {
            //@NB how to refer to CSVLib`EMPTY_CSV/DEFAULT_SETTINGS here? e.g. mk_(false, EMPTY_CSV)
            // have here because of ValueException?
            emptyCSV = ValueFactoryHelper.mkRecord(
                    MODULE_NAME, CSVDATA_TYPE_NAME, 
                    // ValueFactoryHelper.mkRecord(
                    //     MODULE_NAME,
                    //     CSVSETTINGS_TYPE_NAME,
                    //     ValueFactory.mkBool(false), // don't skip/allow empty lines
                    //     ValueFactory.mkNil()           // no line comment delimeter string
                    // ),
                    settings,
                    ValueFactoryHelper.mkEmptySeqValue(),// Headers0: seq of Header 
                    ValueFactoryHelper.mkRecord(
                        MODULE_NAME, 
                        MATRIX_TYPE_NAME, 
                        ValueFactoryHelper.mkEmptySeqValue(), // cells: seq of Row 
                        ValueFactory.mkNil() // no row invariant 
                    ),
                    ValueFactory.mkNil()//@AB: nil File invariant
            );

            Iterator<String[]> iterr = CSVLib.parse(file, getParserType(parser, ctx), getCSVSettings(settings, ctx));
            assert reader != null; 

            // seq of Header0
            //@NB all params are updatable values?
            //SeqValue headers = (SeqValue)headersI;
            //SeqValue headers = (SeqValue)ValueFactoryHelper.deref(headersI);
            SeqValue headers = ValueFactoryHelper.seqValue(headersI, ctx);
                
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
                    RecordValue namedHeaderAtI; 
                    // namedHeaderAtI = 
                    //     ValueFactoryHelper.mkRecord(
                    //         MODULE_NAME, HEADER_TYPE_NAME, 
                    //         ValueFactoryHelper.mkString(nameStr), 
                    //         headerAtI.fieldmap.get(HEADER_FIELD_TYPE),
                    //         headerAtI.fieldmap.get(HEADER_FIELD_DEFAULT_VALUE),                            
                    //         headerAtI.fieldmap.get(HEADER_FIELD_CELL_INV),
                    //         headerAtI.fieldmap.get(HEADER_FIELD_COL_INV)
                    //     );
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
            ValueSet short_row_errors = new ValueSet();
            while (iterr.hasNext())
            {
                String[] row = iterr.next();

                // raise short rows as resulting (IO) errors 
                //check_line_col_size_consistency(headersList.size(), row.length, rowCount, ctx);
                if (headersList.size() > row.length)
                {
                    // stop row processing and accummulate the short row error for every column mising
                    short_row_errors.addAll(createError(rowCount, headersList.size(), row.length,
                        "CSV row " + rowCount + " is short: expected " + 
                        headersList.size() + " rows but read " + row.length));
                    // count the missing row though
                    rowCount++;
                    continue;
                }
                // cell value list has to be created uniquely
                // otherwise a reference in JAva is used (!)
                // (i.e. only last row would be valid for all rows)?!
                //@NB why is that? 
                ValueList cellValues = new ValueList();

                // process each row cell
                for(int colCount = 0; colCount < row.length; colCount++)
                {
                    String cell = row[colCount];                    
                    RecordValue header = headersList.get(colCount);

                    // get the header declared type
                    String csvType = header.fieldmap.get(HEADER_FIELD_TYPE).quoteValue(ctx); // CSVType
                    if (cell == null || cell.isEmpty())
                    {
                        // for default values, pick the one in the header
                        Value defaultVal = header.fieldmap.get(HEADER_FIELD_DEFAULT_VALUE);  // CSVValue
                        assert defaultVal != null; 
                        cellValues.add(defaultVal);
                        if (Settings.verbose)
                            Console.out.printf("CSV read @(%1s,%2s) is empty choose default [%3s: %4s]\n", rowCount, colCount+1, defaultVal.toString(), csvType);
                    }
                    else
                    {
                        cellValues.add(processCell(rowCount, colCount, csvType, cell, ctx));
                        if (Settings.verbose)
                            Console.out.printf("CSV read @(%1s,%2s)=[%3s: %4s]\n", rowCount, colCount+1, cell, csvType);
                    }
                }
                
                // add row cell values
                csvMatrix.add(ValueFactoryHelper.mkSeq(cellValues));
                rowCount++;
            }

            // return the CSV data with short rows filtered and the rows missing as errors.
            RecordValue csvData = ValueFactoryHelper.mkRecord(
                    MODULE_NAME, CSVDATA_TYPE_NAME, 
                    settings,
                    ValueFactoryHelper.mkSeq(namedHeaders),
                    ValueFactoryHelper.mkRecord(
                        MODULE_NAME, MATRIX_TYPE_NAME, 
                        ValueFactoryHelper.mkSeq(csvMatrix),
                        ValueFactory.mkNil()
                    ),
                    ValueFactory.mkNil()//@AB: nil File invariant
            ); 
        
            // checks Data0 invariant only (i.e. the CSVDATA_TYPE_NAME invariant), 
            // which shouldn't include the
            // dynamic invariant check. This is done later. This is important
            // to allow the loading of "invalid" data into the VDM space, so 
            // that users get a VDM invariant failure check. 
            // @NB see CSVLib.vdmsl csv_invariants_failed call on loadCSV operation
            //     is it better there or here? Wanted there to be "clear" from the
            //     user's perspective. 
            // @NB invariant checks need the interpreter's context then? 
            csvData.checkInvariant(ctx);//Interpretr's context?
            
            // reset tuple value with mk_(true, errors, mk_Data0(headers, matrix))
            result.add(ValueFactory.mkBool(true));
            result.add(ValueFactoryHelper.mkSet(short_row_errors));            
            result.add(csvData);

            close();
        } catch (Exception e)//IOException
        {
            // on error return mk_(false, {}, [])
            lastErrorStr = e.getMessage();

            // get the failed answer here for ValueException catch
            // set failed tuple answer as mk_(false, {}, mk_Data0([]], []]))
            result.add(ValueFactory.mkBool(false));
            result.add(ValueFactoryHelper.mkEmptySetValue());
            result.add(emptyCSV);        
        }
        // otherwise, return mk_(true, short_row_errors, data)
        assert result.size() == 3;
        return new TupleValue(result);
    }

    @VDMFunction
    public static Value csv_write_data(Value path, Value data, Value precision)
    {        
        File file = getFile(path);
        Value result;
        try
        {
            Context ctx = getContext();//javaContext?
            if (file.exists() && !file.canWrite())
                throw new ValueException(4999, "Can't write CSV to read-only file " + file.getAbsolutePath() + "\n", ctx);
            else if (file.isDirectory())
                throw new ValueException(4999, "CSV print file is a directory:\n\t" + file.getAbsolutePath() + "\n", ctx); 

            // file exists and can write or doesn't exists and isn't a directory, then go
            print(file, data, precision, ctx);
        }
        catch (Exception e)
        {
            lastErrorStr = e.getMessage();
            result = ValueFactory.mkBool(false);
        }
        result = ValueFactory.mkBool(true);
        return result; 
    }

    /**
     * Corresponds to VDM "lastError: () ==> [String1]". Once called, clear.
     * @return [String1]
     */
    @VDMOperation
	public static Value lastError()
	{
		// if no errors to report, check low-level IO
        if ((lastErrorStr == null || lastErrorStr.isEmpty()) && parser != null)
            lastErrorStr = parser.lastError();     
        Value result = lastErrorStr == null || lastErrorStr.isEmpty() ? 
            ValueFactory.mkNil() : 
            ValueFactoryHelper.mkString(lastErrorStr);
        lastErrorStr = "";
        return result;
	}
}
