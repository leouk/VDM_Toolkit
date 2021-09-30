/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

public class TRDivideExpression extends TRBinaryExpression
{
	private static final long serialVersionUID = 1L;
	
	public TRDivideExpression(TRExpression left, TRExpression right)
	{
		super(left, right);
	}

	@Override
	public String translate()
	{
		return "(" + left.translate() + " / " + right.translate() + ")";
	}
}
