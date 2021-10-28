/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

import com.fujitsu.vdmj.lex.LexLocation;

public class TRIfExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TRExpression ifExp;
	private final TRExpression thenExp;
	private final TRExpression elseExp;
	
	//@todo TCElseIfExpressionList! 
	public TRIfExpression(LexLocation location, TRExpression ifExp, TRExpression thenExp, TRExpression elseExp)
	{
		super(location);
		this.ifExp = ifExp;
		this.thenExp = thenExp;
		this.elseExp = elseExp;
	}

	@Override
	public String translate()
	{
		// attempt at shifting the parenthesing and expression handling elsewhere
		return IsaTemplates.tokenise(isaToken(), location, ifExp, thenExp, elseExp);
	}

	@Override
	public IsaToken isaToken() {
		return IsaToken.IF;
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseIfExpression(this, arg);
	}
}
