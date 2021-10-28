/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCBooleanLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCCharLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCIntegerLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCQuoteLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCRealLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCStringLiteralExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRLiteralExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final IsaToken token;
	private final String exp;

	public TRLiteralExpression(TCBooleanLiteralExpression exp)
	{
		super(exp.location); 
		this.token = IsaToken.BOOL;
		this.exp = exp.value.value ? IsaToken.TRUE.toString() : IsaToken.FALSE.toString();
	}

	public TRLiteralExpression(TCCharLiteralExpression exp)
	{
		super(exp.location); 
		this.token = IsaToken.CHAR;
		this.exp = IsaToken.ISACHAR + " " + 
			IsaToken.bracketit(IsaToken.ISASTR, exp.toString(), IsaToken.ISASTR);
	}

	public TRLiteralExpression(TCIntegerLiteralExpression exp)
	{
		super(exp.location);
		this.token = exp.value.value >= 0 
			? (exp.value.value > 0 ? IsaToken.NAT1 : IsaToken.NAT) : 
			  IsaToken.INT; 
		this.exp = exp.toString();
	}
	
	public TRLiteralExpression(TCRealLiteralExpression exp)
	{
		super(exp.location); 
		this.token = IsaToken.REAL;
		this.exp = exp.toString();
	}

	public TRLiteralExpression(TCStringLiteralExpression exp)
	{
		super(exp.location); 
		assert exp.toString().length() > 1;
		this.token = IsaToken.STRING;
		// remove the quotes from "xxx" -> xxxx
		this.exp = IsaToken.bracketit(IsaToken.ISASTR,
			exp.value.value, //exp.toString().substring(1, exp.toString().length() - 1), 
			IsaToken.ISASTR);
	}

	public TRLiteralExpression(TCQuoteLiteralExpression exp)
	{
		super(exp.location); 
		this.token = IsaToken.QUOTE;
		// remove the <XXX> -> XXX
		this.exp = exp.type.value;
	}

	@Override
	public String translate()
	{
		// no casting needed for real, string, quote literals
		String typeStr =  
			!(token == IsaToken.REAL || token == IsaToken.STRING || token == IsaToken.QUOTE) ?
				IsaToken.TYPEOF.toString() + isaToken().toString() : "";
		return IsaToken.parenthesise(exp + typeStr);
	}

	@Override
	public IsaToken isaToken() 
	{
		return token;
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseLiteralExpression(this, arg);
	}
}
