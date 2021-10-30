package vdm2isa.tr.patterns;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.patterns.TCTypeBind;
import com.fujitsu.vdmj.tc.patterns.TCTypeBindList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRTypeBindList extends TRMappedList<TCTypeBind, TRMultipleTypeBind> {
    
    private static final long serialVersionUID = 1L;

	protected TRTypeBindList() 
	{
		super();
		separator = " ";
	}  

	public TRTypeBindList(TCTypeBindList list) throws Exception
	{
		super(list);
		separator = " ";
	}

	public String invTranslate()
	{
		String old = separator; 
		separator = " " + IsaToken.AND.toString() + " ";
		String result = super.invTranslate();
		separator = old;
		return result;
	}

	public static String translate(TRMultipleTypeBind... args)
	{
		TRTypeBindList list = new TRTypeBindList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
