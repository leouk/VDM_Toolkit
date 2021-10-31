package vdm2isa.tr.expressions;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.expressions.TCElseIfExpression;
import com.fujitsu.vdmj.tc.expressions.TCElseIfExpressionList;

import vdm2isa.tr.TRMappedList;

public class TRElseIfExpressionList extends TRMappedList<TCElseIfExpression, TRElseIfExpression>{
    
    public TRElseIfExpressionList()
    {
        super();
        setFormattingSeparator("\n\t\t");
    }

    public TRElseIfExpressionList(TCElseIfExpressionList from) throws Exception
    {
        super(from);
        setFormattingSeparator("\n\t\t");
    }

	public static String translate(TRElseIfExpression... args)
	{
		TRElseIfExpressionList list = new TRElseIfExpressionList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
