/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRVariableExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TCNameToken name;
	
	public TRVariableExpression(TCNameToken name)
	{
		super(name.getLocation());
		this.name = name;
	}

	@Override
	public String translate()
	{
		return name.getName().toString();
	}

	@Override
	public IsaToken isaToken() {
		return IsaToken.VARIABLE;
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseVariableExpression(this, arg);
	}
}
