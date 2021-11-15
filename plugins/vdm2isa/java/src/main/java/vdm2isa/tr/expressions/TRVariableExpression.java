/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.definitions.TRLocalDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRVariableExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TCNameToken name;
	private final String original;

	private final TRDefinition vardef;
	
	public TRVariableExpression(LexLocation location, TCNameToken name, String original, TRDefinition vardef, TRType exptype)
	{
		super(name.getLocation(), exptype);
		this.name = name;
		//name different from original when with complex patterns?
		this.original = original;
		// the var def will be a TRLocalDefinition (e.g. var: type) or a TRExplicitFunctionDefinition (e.g. g(x))
		this.vardef = vardef;
		if (vardef == null)
			report(IsaErrorMessage.VDMSL_INVALID_VAREXPR_VARDEF_1P, original);
		else
			// mark as local, even if TRExplicitFunctionDefinition
			this.vardef.local = true;
		System.out.println(toString());
	}

	@Override
	public String toString()
	{
		// avoid vardef.translate, as if a top-level definition like TRExplicitFunction will "mark" as done for Isabelle and
		// generate a "repeated" item error! 
		return super.toString() +
			"\n\t name     = " + String.valueOf(name) +
			"\n\t original = " + String.valueOf(original) + 
			"\n\t def      = " + String.valueOf(vardef) +
			"\n\t loc      = " + String.valueOf(getLocation()); 
	}

	@Override 
	protected TRType getBestGuessType()
	{
		TRType result; 
		if (vardef instanceof TRLocalDefinition)
			result = ((TRLocalDefinition)vardef).getType();
		else if (vardef instanceof TRExplicitFunctionDefinition)
			result = ((TRExplicitFunctionDefinition)vardef).getType().result;
		else
			result = super.getType();
		return result;
	}

	@Override
	public String translate()
	{
		return name.getName().toString();//typeAware(name.getName().toString());
	}

	/**
	 * Variable expressions can inv translate with their known types, or with specification if explicit funciton def
	 */
	@Override 
	public String invTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (vardef instanceof TRLocalDefinition)
		{
			TRLocalDefinition lvardef = (TRLocalDefinition)vardef;
			sb.append(lvardef.invTranslate());
			sb.append(getFormattingSeparator());
			// callee is responsible for issuing any extra getInvTranslateSeparators()!
		}
		else 
		{
			warning(IsaWarningMessage.PLUGIN_NYI_2P, vardef.getClass().getSimpleName() + " invariant translate", getClass().getSimpleName());
		}
		return sb.toString();
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

	public static TRVariableExpression newVariableExpr(LexLocation location, TCNameToken name, String original, TRType exptype)
	{
		return new TRVariableExpression(
                location, name, original, 
                new TRLocalDefinition(location, null, null, name, NameScope.LOCAL, true, false, exptype), 
                exptype);
	}
}
