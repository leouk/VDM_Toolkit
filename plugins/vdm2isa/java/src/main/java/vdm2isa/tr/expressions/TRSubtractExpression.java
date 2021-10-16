/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;

public class TRSubtractExpression extends TRBinaryExpression
{
	private static final long serialVersionUID = 1L;
	
	public TRSubtractExpression(TRExpression left, TRExpression right)
	{
		super(left, right);
	}

	@Override
	public String translate()
	{
		return IsaTemplates.tokenise(left, IsaToken.MINUS, right);
	}
}
