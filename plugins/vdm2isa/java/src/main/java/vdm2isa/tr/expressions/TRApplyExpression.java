/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

public class TRApplyExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TRExpression root;
	private final TRExpressionList args;
	
	public TRApplyExpression(TRExpression root, TRExpressionList args)
	{
		this.root = root;
		this.args = args;
	}

	@Override
	public String translate()
	{
		return root.translate() + "(" + args.translate() + ")";
	}
}
