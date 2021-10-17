/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;

import vdm2isa.tr.TRMappedList;

public class TRExpressionList extends TRMappedList<TCExpression, TRExpression>
{
	private static final long serialVersionUID = 1L;
	
	private String separator; 

	public TRExpressionList(TCExpressionList list) throws Exception
	{
		super(list);
		separator = null;
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
}
