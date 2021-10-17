/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;

import vdm2isa.tr.TRMappedList;

public class TRExpressionList extends TRMappedList<TCExpression, TRExpression>
{
	private static final long serialVersionUID = 1L;
	
	protected String separator; 

	protected TRExpressionList() 
	{
		super();
		separator = " ";
	}  

	public TRExpressionList(TCExpressionList list) throws Exception
	{
		super(list);
		separator = " ";
	}

	public String translate()
	{
		assert separator != null;
		StringBuilder sb = new StringBuilder();
		int l = size();
		for (TRExpression exp: this)
		{
			l = l - 1;
			sb.append(exp.translate());
			if (l > 0) sb.append(separator);
		}
		return sb.toString();
	}

	public static String translate(TRExpression... args)
	{
		TRExpressionList list = new TRExpressionList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
