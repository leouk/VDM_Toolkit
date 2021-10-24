/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
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
	private final TCExpression exp;

	public TRLiteralExpression(TCBooleanLiteralExpression exp)
	{
		super(exp.location); 
		this.exp = exp;
	}

	public TRLiteralExpression(TCCharLiteralExpression exp)
	{
		super(exp.location); 
		this.exp = exp;
	}

	public TRLiteralExpression(TCIntegerLiteralExpression exp)
	{
		super(exp.location); 
		this.exp = exp;
	}
	
	public TRLiteralExpression(TCRealLiteralExpression exp)
	{
		super(exp.location); 
		this.exp = exp;
	}

	public TRLiteralExpression(TCStringLiteralExpression exp)
	{
		super(exp.location); 
		this.exp = exp;
	}

	public TRLiteralExpression(TCQuoteLiteralExpression exp)
	{
		super(exp.location); 
		this.exp = exp;
	}

	@Override
	public String translate()
	{
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
	}

	@Override
	public IsaToken isaToken() 
	{
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
	}
}
