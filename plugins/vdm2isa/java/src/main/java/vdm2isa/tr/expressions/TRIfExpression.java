/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

import com.fujitsu.vdmj.lex.LexLocation;

public class TRIfExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TRExpression ifExp;
	private final TRExpression thenExp;
	private final TRElseIfExpressionList elseList;
	private final TRExpression elseExp;
	
	//@todo TCElseIfExpressionList! 
	public TRIfExpression(LexLocation location, TRExpression ifExp, TRExpression thenExp, TRElseIfExpressionList elseList, TRExpression elseExp)
	{
		super(location);
		assert ifExp != null && thenExp != null && elseExp != null && elseList != null;
		this.ifExp = ifExp;
		this.thenExp = thenExp;
		this.elseExp = elseExp;
		this.elseList = elseList;
		this.setFormattingSeparator("\n\t\t");
		this.elseList.setFormattingSeparator(getFormattingSeparator());		
		//System.out.println(toString());
	}

	@Override 
	public String toString()
	{
		return super.toString() + 
			"\n\t if   = " + ifExp.translate() +
			"\n\t then = " + thenExp.translate() +
			"\n\t elseL= " + elseList.size() + 
			"\n\t      = " + elseList.translate() +
			// could this be null for operations? No. TCIfStatement.
			"\n\t else = " + elseExp.translate();  
	}

	@Override
	public IsaToken isaToken() {
		return IsaToken.IF;
	}
	
	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		sb.append(getFormattingSeparator());
		sb.append(isaToken().toString());
		sb.append(" ");
		sb.append(IsaToken.parenthesise(ifExp.translate()));
		sb.append(" ");
		sb.append(IsaToken.THEN.toString());
		sb.append(getFormattingSeparator());
		sb.append(IsaToken.parenthesise(thenExp.translate()));
		sb.append(elseList.translate());
		sb.append(getFormattingSeparator());
		sb.append(IsaToken.ELSE.toString());
		sb.append(getFormattingSeparator());
		sb.append(IsaToken.parenthesise(elseExp.translate()));
		return IsaToken.parenthesise(sb.toString());
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseIfExpression(this, arg);
	}
}
