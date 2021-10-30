/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexToken;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

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
		//@todo equals expression has to be specialised because of record and other equality tests ? 
		this.op = op;
		this.right = right;
	}

	@Override
	public IsaToken isaToken()
	{
		return IsaToken.from(op);
	}

	@Override
	public String translate()
	{
		return tokenise(isaToken(), location, left, right);
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseBinaryExpression(this, arg);
	}
}
