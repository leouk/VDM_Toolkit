/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.lex.LexCommentList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRType;

import vdm2isa.lex.IsaToken;

/**
 * VDM values are translated as Isabelle constants. 
 */
public class TRValueDefinition extends TRLocalDefinition
{
	private static final long serialVersionUID = 1L;
	private final TRPattern pattern;
	private final TRType type;
	private final TRExpression exp;
	private final TRDefinitionList defs;
	
	/**
	 * Default=true; translate VDM values as Isabelle abbreviations.
	 */
	public boolean abbreviation; 
	
	public TRValueDefinition(LexCommentList comments, TRPattern pattern, TRType type, TRExpression exp, TRDefinitionList defs)
	{
		super(pattern.location, comments, null, type);
		this.pattern = pattern;
		this.type = type;
		this.exp = exp;
		this.abbreviation = true;

		// these are always TRLocalDefinition within the list. 
		// these allow the totally wacky VDM like "values [A,B] = [1,2];", where A binds to 1 and B to 2! 
		this.defs = defs;
		if (this.defs.size() > 1)
			report(11111, "Multiple local names in VDM value definitions (e.g., \"[A,B] = [1,2]\") cannot be translated.");
		
		if (local) System.out.println(toString());
	}

	@Override
	public String toString()
	{
		return "TRValueDef [local=" + local + "] for " + pattern.translate() + 
			" defs(" + defs.size() +")[" + defs.get(0).getClass().getName() + "] = " + defs.translate();
	}

	@Override
    protected String getDeclaredName()
    {
		return pattern.translate();
    }

	@Override
	public IsaToken isaToken()
	{
		return IsaToken.VARIABLE;
	}

	@Override
	public String translate()
	{
		// translate the "v: T = e" as an abbreviation or definition
		StringBuilder sb = new StringBuilder();

		// translate the value expression
		String expStr = exp.translate();
		
		// global definitions (e.g. v: T = e) require invariant translation alongside its defining expression
		if (!local)
		{
			// add any annotations or comments (i.e. TRDefinition.translate(), given super.translate won't work here)
			sb.append(translatePreamble());

			sb.append(IsaTemplates.translateAbbreviation(getDeclaredName(), getTypeString(), expStr));
			sb.append("\n");

			// translate inv_v as definition
			sb.append(invTranslate());
		}
		// local definitions (e.g. let v: T = e1 in e2) only require the type info
		else
		{
			//TODO perhaps do not need this beyond checking for bad patterns; don't want to reinvent above in TRLocalDefinition
			//		neither have them as subclasses of each other or something like that?
			//defs.separator = " ";
			//sb.append(defs.translate());

			sb.append(super.translate());
			sb.append(" ");
			sb.append(IsaToken.EQUALS.toString());
			sb.append(" ");
			sb.append(expStr);
		}
        return sb.toString();
	}

	@Override
	public String invTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!local)
		{
			// translate the type invariant definition as inv_v definition, possibly with dummy names for lambdas
			// input type is possibly empty (null) in case of non function type
			String inType = null;
			if (type instanceof TRFunctionType)
			{
				inType = ((TRFunctionType)type).parameters.translate();
			}
			
			//type instanceof TRFunctionType => inType != null
			assert !(type instanceof TRFunctionType) || inType != null; 

			String varName = getDeclaredName();//.toLowerCase();
			// assemble the template
			sb.append(IsaTemplates.translateInvariantAbbreviation(varName, inType, dummyVarNames(), getInvariantString(varName)));
			sb.append("\n");
		}
		else
		{
			sb.append(super.invTranslate());
		}
		return sb.toString();
	}

	@Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseValueDefinition(this, arg);
	}
}
