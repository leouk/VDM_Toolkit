/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.definitions.TRLocalDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRType;

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
		if (vardef == null)
			report(IsaErrorMessage.VDMSL_INVALID_VAREXPR_VARDEF_1P, original);
		else
			// mark as local, even if TRExplicitFunctionDefinition
			this.vardef.local = true;
		//System.out.println(toString());
	}

	@Override
	public String toString()
	{
		// avoid vardef.translate, as if a top-level definition like TRExplicitFunction will "mark" as done for Isabelle and
		// generate a "repeated" item error! 
		return super.toString() + " ; original = " + String.valueOf(original) + 
			"\n\t def = " + (vardef != null ? vardef.getClass().getName() : "null") + ":" + 
				"\n\t\t " + String.valueOf(vardef); 
	}

	protected String typeAware(String expr)
	{
        StringBuilder sb = new StringBuilder();
        // add type info extra expression if of optional type (either as variable "x" or function call "f(x)"). 
		if ((vardef instanceof TRLocalDefinition && ((TRLocalDefinition)vardef).type instanceof TROptionalType) ||
			(vardef instanceof TRExplicitFunctionDefinition && 
				((TRExplicitFunctionDefinition)vardef).getType().result instanceof TROptionalType))
		{	
			TRType t = vardef instanceof TRLocalDefinition ? ((TRLocalDefinition)vardef).type : 
						vardef instanceof TRExplicitFunctionDefinition ? ((TRExplicitFunctionDefinition)vardef).getType().result : null;
			String comment = IsaWarningMessage.ISA_OPTIONALTYPE_VARIABLE_3P.format(expr, t.getClass().getName());
			warning(IsaWarningMessage.ISA_OPTIONALTYPE_VARIABLE_3P, expr, t.getClass().getName());
			sb.append(IsaToken.comment(comment, getFormattingSeparator()));	
			sb.append(IsaToken.parenthesise(IsaToken.OPTIONAL_THE.toString() + IsaToken.parenthesise(expr)));
		}
		else
		{
			//if vardef is null, ctor reports the error; 
			sb.append(expr);
		}
		return sb.toString();		
	}

	@Override 
	public TRType getType()
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
		return typeAware(name.getName().toString());
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
			warning(11111, "not yet handling invariant translate for complex variable expr " + vardef.getClass().getName());
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
}
