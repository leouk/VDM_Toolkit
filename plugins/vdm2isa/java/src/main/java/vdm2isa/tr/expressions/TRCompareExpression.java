/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexToken;

import vdm2isa.lex.IsaTemplates;

public class TRCompareExpression extends TRBinaryExpression
{
	private static final long serialVersionUID = 1L;
	private final LexToken op;
	
	public TRCompareExpression(TRExpression left, LexToken op, TRExpression right)
	{
		super(left, right);
		this.op = op;
	}

	@Override
	public String translate()
	{
		return IsaTemplates.tokenise(left, op, right);
	}
}
