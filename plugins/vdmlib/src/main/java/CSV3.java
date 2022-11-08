import java.io.Serializable;

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
	private static String lastError = "";
    
    @VDMOperation
	public static Value ferror()
	{
		return lastError.isEmpty() ? 
            new NilValue() : 
            new SeqValue(lastError);
	}
}
