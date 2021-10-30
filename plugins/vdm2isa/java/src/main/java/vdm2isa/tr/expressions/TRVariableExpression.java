/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRVariableExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TCNameToken name;
	private final String original;

	private final TRDefinition vardef;
	
	public TRVariableExpression(LexLocation location, TCNameToken name, String original, TRDefinition vardef)
	{
		super(name.getLocation());
		this.name = name;
		//NB when would original ever be different from name? 
		this.original = original;
		// the var def will be a TRLocalDefinition (e.g. var: type) or a TRExplicitFunctionDefinition (e.g. g(x))
		this.vardef = vardef;
		// mark as local, even if TRExplicitFunctionDefinition
		this.vardef.local = true;
		//System.out.println(toString());
	}

	@Override
	public String toString()
	{
		// avoid vardef.translate, as if a top-level definition like TRExplicitFunction will "mark" as done for Isabelle and
		// generate a "repeated" item error! 
		return super.toString() + " ; original = " + original + 
			"\n\t def = " + vardef.getClass().getName() + ":" + 
				"\n\t\t " + vardef.toString(); 
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

	public TRDefinition getVarDef()
	{
		return vardef;
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseVariableExpression(this, arg);
	}
}
