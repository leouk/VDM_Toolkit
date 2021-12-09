/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRUnionType;
import vdm2isa.tr.types.TRTypeSet;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCElseIfExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCIfExpression;

public class TRIfExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	public final TRExpression ifExp;
	public final TRExpression thenExp;
	public final TRElseIfExpressionList elseList;
	public final TRExpression elseExp;
	
	//@todo TCElseIfExpressionList! 
	public TRIfExpression(LexLocation location, TCIfExpression tc, TRExpression ifExp, TRExpression thenExp, 
		TRElseIfExpressionList elseList, TRExpression elseExp, TRType exptype)
	{
		super(location, tc, exptype);
		this.ifExp = ifExp;
		this.thenExp = thenExp;
		this.elseExp = elseExp;
		this.elseList = elseList;
	}
	
	@Override
	public void setup()
	{
		super.setup();
		assert ifExp != null && thenExp != null && elseExp != null && elseList != null;
		TRNode.setup(ifExp, thenExp, elseExp, elseList);
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
		return TRUnionType.newUnionType(location, new TRTypeSet(thenExp.getType(), elseExp.getType(), elseList.getType()));
	}

	@Override 
	public String toString()
	{
		return super.toString() + 
			"\n\t if   = " + String.valueOf(ifExp) +
			"\n\t then = " + String.valueOf(thenExp) +
			"\n\t elseL= " + (elseList != null ? elseList.size() : "null") + 
			"\n\t      = " + String.valueOf(elseList) +
			// could this be null for operations? No. TCIfStatement.
			"\n\t else = " + String.valueOf(elseExp);  
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

	public static final TRIfExpression newIfExpression(LexLocation location, TRExpression ifExp, TRExpression thenExp, TRExpression elseExp, TRType exptype)
	{
		return TRIfExpression.newIfExpression(location, ifExp, thenExp, null, elseExp, exptype);
	}

	public static final TRIfExpression newIfExpression(LexLocation location, TRExpression ifExp, TRExpression thenExp, 
		TRElseIfExpressionList elseList, TRExpression elseExp, TRType exptype)
	{
		TRIfExpression result = new TRIfExpression(location, 
			new TCIfExpression(location, ifExp.getVDMExpr(), thenExp.getVDMExpr(), 
				elseList != null ? elseList.getVDMElseIfExpressionList() : new TCElseIfExpressionList(), elseExp.getVDMExpr()),
			ifExp, thenExp, elseList, elseExp, exptype);
		TRNode.setup(result);
		return result;
	}
}
