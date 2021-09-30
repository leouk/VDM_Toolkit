/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

public class TRIfExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TRExpression ifExp;
	private final TRExpression thenExp;
	private final TRExpression elseExp;
	
	public TRIfExpression(TRExpression ifExp, TRExpression thenExp, TRExpression elseExp)
	{
		this.ifExp = ifExp;
		this.thenExp = thenExp;
		this.elseExp = elseExp;
	}

	@Override
	public String translate()
	{
		return "(" + ifExp.translate() + ") ? " + thenExp.translate() + " : " + elseExp.translate();
	}
}
