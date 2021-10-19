/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCBooleanLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCCharLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCIntegerLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCRealLiteralExpression;

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
	
	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		sb.append("(");
		if (exp instanceof TCBooleanLiteralExpression)
		{
			sb.append(exp.toString());
			sb.setCharAt(1, Character.toUpperCase(sb.charAt(1))); //True/False?
		} else if (exp instanceof TCCharLiteralExpression)
		{
			sb.append("CHR ''");
			sb.append(exp.toString());
			sb.append("''");
		}
		else
		{
			sb.append(exp.toString());
		}
		sb.append("::");
		sb.append(isaToken().toString());
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
		else
			throw new RuntimeException("Invalid VDM literal type " + exp.getClass().getName() + " = " + exp.toString());
	}
}
