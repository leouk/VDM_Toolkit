/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRUnionType;
import vdm2isa.tr.types.TRTypeSet;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCUnionType;

public class TRIfExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TRExpression ifExp;
	private final TRExpression thenExp;
	private final TRElseIfExpressionList elseList;
	private final TRExpression elseExp;
	
	//@todo TCElseIfExpressionList! 
	public TRIfExpression(LexLocation location, TRExpression ifExp, TRExpression thenExp, 
		TRElseIfExpressionList elseList, TRExpression elseExp, TRType exptype)
	{
		super(location, exptype);
		assert ifExp != null && thenExp != null && elseExp != null && elseList != null;
		this.ifExp = ifExp;
		this.thenExp = thenExp;
		this.elseExp = elseExp;
		this.elseList = elseList;
		this.setFormattingSeparator("\n\t\t");
		this.elseList.setFormattingSeparator(getFormattingSeparator());		
		//System.out.println(toString());
	}

	/**
	 * Choose the thenExp type as the resulting type (could have been elseExp); this is to attempt to solve the "(the (pattern))" problem
	 */
	@Override
	protected TRType getBestGuessType()
	{
		TRTypeSet typeSet = new TRTypeSet(thenExp.getType(), elseExp.getType(), elseList.getType());
		return new TRUnionType(new TCUnionType(location, typeSet.getVDMTypeSet()), new TRDefinitionList(), typeSet);
	}

	@Override 
	public String toString()
	{
		return super.toString() + 
			"\n\t if   = " + String.valueOf(ifExp) +//.translate() +
			"\n\t then = " + String.valueOf(thenExp) +//.translate() +
			"\n\t elseL= " + (elseList != null ? elseList.size() : "null") + 
			"\n\t      = " + String.valueOf(elseList) +//.translate() +
			// could this be null for operations? No. TCIfStatement.
			"\n\t else = " + String.valueOf(elseExp);//.translate();  
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
