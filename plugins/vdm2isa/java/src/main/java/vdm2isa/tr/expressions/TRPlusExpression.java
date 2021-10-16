/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.IsaTemplates;

public class TRPlusExpression extends TRBinaryExpression
{
	private static final long serialVersionUID = 1L;
	
	public TRPlusExpression(TRExpression left, TRExpression right)
	{
		super(left, right);
	}

	@Override
	public String translate()
	{
		return IsaTemplates.tokenise(left, IsaToken.PLUS, right);
	}
}
