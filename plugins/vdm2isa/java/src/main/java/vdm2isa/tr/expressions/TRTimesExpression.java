/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;

public class TRTimesExpression extends TRBinaryExpression
{
	private static final long serialVersionUID = 1L;
	
	//@todo how to take parenthesiation into account according to Isa's rules? 
	public TRTimesExpression(TRExpression left, TRExpression right)
	{
		super(left, right);
	}

	@Override
	public String translate()
	{
		return IsaTemplates.tokenise(left, IsaToken.TIMES, right);
	}
}
