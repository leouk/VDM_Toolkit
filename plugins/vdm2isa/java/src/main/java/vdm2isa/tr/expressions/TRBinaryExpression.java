/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

abstract public class TRBinaryExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	protected final TRExpression left;
	protected final TRExpression right;
	
	public TRBinaryExpression(TRExpression left, TRExpression right)
	{
		this.left = left;
		this.right = right;
	}
}
