/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.lex.LexCommentList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.IsaTemplates;

/**
 * VDM values are translated as Isabelle constants. 
 */
public class TRValueDefinition extends TRDefinition
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
		super(pattern.location, comments);
		this.pattern = pattern;
		this.type = type;
		this.exp = exp;

		// these are always TRLocalDefinition within the list? 
		this.defs = defs;
		this.abbreviation = true;
		
		System.out.println(toString());
	}

	@Override
	public String toString()
	{
		return "TRValueDef [local=" + local + "] for " + pattern.translate() + 
			" defs(" + defs.size() +")[" + defs.get(0).getClass().getName() + "] = " + defs.translate();
	}

	@Override
	public IsaToken isaToken()
	{
		return IsaToken.VARIABLE;
	}

	@Override
	public String translate()
	{
		// get declared and invariant variable names
		String declName = pattern.translate();

		// type string depends on TRType class
		String typeStr;
		if (type instanceof TRRecordType)
			// "v : R = mk_R(...)", the type name is the actual name, rather than the type translation 
			typeStr = ((TRRecordType)type).getName().toString();
		else
			// other types, translate it directly
			typeStr = type.translate();

		String expStr = exp.translate();
	
		// translate the "v: T = e" as an abbreviation or definition
		StringBuilder sb = new StringBuilder();
		sb.append(super.translate());
        sb.append(IsaTemplates.translateAbbreviation(declName, typeStr, expStr));
        sb.append("\n");

		// translate inv_v as definition
		sb.append(invTranslate());
        return sb.toString();
	}

	@Override
	public String invTranslate()
	{
		// get declared and invariant variable names
		String declName = pattern.translate();
		String varName = declName.toLowerCase();

		// translate the type invariant definition as inv_v definition, possibly with dummy names for lambdas
        String inType = null;
		String dummyNames = "";
        
		// invariant type string depends on the TRType class
		String invStr;
        if (type instanceof TRRecordType)
        {
			// records have to apply to the varName rather than use it as part of the type-inv-translate string
			invStr = type.invTranslate(null) + varName;
        }
        else
        {
            invStr = type.invTranslate(varName);
            // function typed abbreviations (i.e. lambdas) need different input signature for invariant! 
            if (type instanceof TRFunctionType)
            {
                inType = ((TRFunctionType)type).parameters.translate();
                dummyNames = IsaToken.dummyVarNames(((TRFunctionType)type).parameters.size(), type.location);
            }
        }
		
		// assemble the template
		StringBuilder sb = new StringBuilder();
		sb.append(IsaTemplates.translateInvariantAbbreviation(declName, inType, dummyNames, invStr));
        sb.append("\n");
		return sb.toString();
	}
}
