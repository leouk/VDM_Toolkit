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
		setSemanticSeparator(" ");
	}  

	public TRTypeBindList(TRTypeBindList from)
	{
		this();
		addAll(from);
	}


	public TRTypeBindList(TCTypeBindList list) throws Exception
	{
		super(list);
		setSemanticSeparator(" ");
	}

	public String invTranslate()
	{
		// Inv separator forms a chained conjunction
		String old = setSemanticSeparator(" " + IsaToken.AND.toString() + " "); 
		String result = super.invTranslate();
		setSemanticSeparator(old);
		return result;
	}

	public static String translate(TRMultipleTypeBind... args)
	{
		TRTypeBindList list = new TRTypeBindList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
