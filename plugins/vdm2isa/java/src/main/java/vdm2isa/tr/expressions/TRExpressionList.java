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
	
	public TRExpressionList(TCExpressionList list) throws Exception
	{
		super(list);
	}

	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		String sep = "";
		
		for (TRExpression exp: this)
		{
			sb.append(sep);
			sb.append(exp.translate());
			sep = ", ";
		}
		
		return sb.toString();
	}
}
