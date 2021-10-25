package vdm2isa.tr.patterns;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.patterns.TCTypeBind;
import com.fujitsu.vdmj.tc.patterns.TCTypeBindList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRTypeBindList extends TRMappedList<TCTypeBind, TRMultipleTypeBind> {
    
    private static final long serialVersionUID = 1L;
	protected String separator; 

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

	public String translate()
	{
		assert separator != null;
		return IsaTemplates.listToString(this, separator);
	}

	public String invTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!this.isEmpty())
		{
			sb.append(this.get(0).invTranslate());
			for (int i=1; i < this.size(); i++)
			{
				sb.append(" " + IsaToken.AND.toString() + " ");
				sb.append(this.get(i).invTranslate());
			}
			return IsaToken.parenthesise(sb.toString());
		}
		return sb.toString();	
	}

	public static String translate(TRMultipleTypeBind... args)
	{
		TRTypeBindList list = new TRTypeBindList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
