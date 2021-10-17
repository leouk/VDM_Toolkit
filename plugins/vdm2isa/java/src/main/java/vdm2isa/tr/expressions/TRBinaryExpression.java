/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexToken;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;

public class TRBinaryExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	protected final TRExpression left;
	protected final TRExpression right;
	protected final LexToken op;
	
	public TRBinaryExpression(TRExpression left, LexToken op, TRExpression right)
	{
		super(op.location);
		this.left = left;
		this.op = op;
		this.right = right;
	}

	@Override
	public IsaToken isaToken()
	{
		return IsaToken.from(op.type);
	}

	@Override
	public String translate()
	{
		return IsaTemplates.tokenise(isaToken(), location, left, right);
	}
}
