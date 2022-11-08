import java.io.File;
import java.io.Serializable;

import com.fujitsu.vdmj.runtime.VDMFunction;
import com.fujitsu.vdmj.runtime.VDMOperation;
import com.fujitsu.vdmj.values.NilValue;
import com.fujitsu.vdmj.values.SeqValue;
import com.fujitsu.vdmj.values.Value;

/**
 * Implements a CSV loading library in conjunction with 
 * a VDM specification that tighens the notion of what a
 * CSV row/column should contain. 
 * @Author Leo Freitas
 */
public class CSV3 implements Serializable {

    private static final long serialVersionUID = 1L;
    private static String lastFilePath = null;
	private static String lastErrorStr = "";

    protected static File getFile(Value path)
	{
		String adjustedPath = IO.stringOf(path).replace('/', File.separatorChar);        
		File f = new File(adjustedPath).getAbsoluteFile();
        return f;
	}

    /**
     * Corresponds to VDM "file_status: Path -> FileStatus"
     * @param path
     * @return FileStatus
     */
    @VDMFunction 
    public static Value file_status(Value path)
    {
        File f = getFile(path);
        f.isDirectory()
        f.canRead()
        return null;
    }

    /**
     * Corresponds to VDM "csv_read[@p]: Path -> bool * [@p]"
     * @param path full file path where it is expected file_status(path) = <Valid>
     * @return
     */
    @VDMFunction
    public static Value csv_read(Value path)
    {
        return null;
    }

    /**
     * Corresponds to VDM "lastError: () ==> [String1]".
     * @return [String1]
     */
    @VDMOperation
	public static Value lastError()
	{
		return lastErrorStr.isEmpty() ? 
            new NilValue() : 
            new SeqValue(lastErrorStr);
	}
}
