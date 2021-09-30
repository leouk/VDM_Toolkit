/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCIntegerLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCRealLiteralExpression;

public class TRLiteralExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TCExpression exp;

	public TRLiteralExpression(TCIntegerLiteralExpression exp)
	{
		this.exp = exp;
	}
	
	public TRLiteralExpression(TCRealLiteralExpression exp)
	{
		this.exp = exp;
	}
	
	@Override
	public String translate()
	{
		return exp.toString();
	}
}
