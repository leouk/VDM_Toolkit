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
			exp.toString().substring(1, exp.toString().length() - 1), 
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
		/*
		StringBuilder sb = new StringBuilder();
		sb.append("(");
		if (exp instanceof TCBooleanLiteralExpression)
		{
			//True/False for true/false
			sb.append(exp.toString());
			sb.setCharAt(1, Character.toUpperCase(sb.charAt(1))); 
		} 
		else if (exp instanceof TCCharLiteralExpression)
		{
			// Isabelle chars are transformed from string through CHR
			sb.append("CHR ''");
			sb.append(exp.toString());
			sb.append("''");
		}
		else if (exp instanceof TCStringLiteralExpression)
		{
			sb.append("''");
			// remove the "xxxx" 
			sb.append(exp.toString().substring(1, exp.toString().length() - 1));
			sb.append("''");
		}
		else if (exp instanceof TCQuoteLiteralExpression)
		{
			// remove the "< ... >"
			TCQuoteLiteralExpression qexp = (TCQuoteLiteralExpression)exp;
			sb.append(qexp.type.value);
		}
		else
		{
			sb.append(exp.toString());
		}

		// no casting needed for those three 
		if (!(exp instanceof TCStringLiteralExpression || 
			  exp instanceof TCQuoteLiteralExpression ||
			  exp instanceof TCRealLiteralExpression))
		{
			sb.append(IsaToken.TYPEOF.toString());
			sb.append(isaToken().toString());
		}

		sb.append(")");
		return sb.toString();
		*/
	}

	@Override
	public IsaToken isaToken() 
	{
		return token;
		/*
		//@todo return IsaToken.literalTokenType(exp);? Or keep to minimise dependenceis?
		if (exp instanceof TCBooleanLiteralExpression)
			return IsaToken.BOOL;
		else if (exp instanceof TCCharLiteralExpression)
			return IsaToken.CHAR;
		else if (exp instanceof TCIntegerLiteralExpression)
		{
			long v = ((TCIntegerLiteralExpression)exp).value.value;
			if (v >= 0)
				return IsaToken.NAT;
			else 
				return IsaToken.INT; 
		}
		else if (exp instanceof TCRealLiteralExpression)
			return IsaToken.REAL;
		else if (exp instanceof TCStringLiteralExpression)
			return IsaToken.CHAR;
		else if (exp instanceof TCQuoteLiteralExpression)
			return IsaToken.CHAR;
		else
			throw new RuntimeException("Invalid VDM literal type " + exp.getClass().getName() + " = " + exp.toString());
			*/
	}
}
