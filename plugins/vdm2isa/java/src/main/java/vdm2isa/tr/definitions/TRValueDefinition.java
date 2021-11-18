/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRNilExpression;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.TRRecordPattern;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRType;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;

/**
 * VDM values are translated as Isabelle constants. 
 */
public class TRValueDefinition extends TRLocalDefinition
{
	private static final long serialVersionUID = 1L;
	private final TRPattern pattern;
	private final TRExpression exp;
	private final TRDefinitionList defs;
	private final TRType expType;

	protected TRValueDefinition(
		TCDefinition definition, 
		LexLocation location,
		TRIsaVDMCommentList comments, 
		TCAnnotationList annotations, 
		NameScope nameScope,
		boolean used,
		boolean excluded, 
		TRPattern pattern, 
		TRType type, 
		TRExpression exp,
		TRType expType, 
		TRDefinitionList defs)
	{
		// value names are null; their local definitions have the TCNameToken instead! 
		super(definition, location, comments, annotations, null, nameScope, used, excluded, type);
		this.pattern = pattern;
		this.exp = exp;
		this.expType = expType;
		//NB will this ever be null during class mapping? 
		this.defs = defs;//figureOutDefs(defs);
		//if (local) 
		//	System.out.println(toString());
	}
		
	public TRValueDefinition(
		TCValueDefinition definition, 
		TRIsaVDMCommentList comments, 
		TCAnnotationList annotations, 
		NameScope nameScope,
		boolean used,
		boolean excluded, 
		TRPattern pattern, 
		TRType type, 
		TRExpression exp,
		TRType expType, 
		TRDefinitionList defs)
	{
		this(definition, pattern.location, comments, annotations, nameScope, used, excluded, pattern, type, exp, expType, defs);		
	}

	@Override
	public String toString()
	{
		return "ValueDef [local=" + isLocal() + "] for " + 
			"\n\t patt = " + String.valueOf(pattern) + 
			"\n\t expt = " + String.valueOf(expType) +
			"\n\t defs = " + String.valueOf(defs) +
			"\n\t loc  = " + String.valueOf(getLocation());
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
    public String tldIsaComment()
    {
        return tldIsaCommentTranslate(exp);
    }

	protected String translateExpression()
	{
		// translate the value expression
		StringBuilder expStr = new StringBuilder();
		expStr.append(tldIsaComment());
		if (getType() instanceof TROptionalType && !(exp instanceof TRNilExpression))
		{
			expStr.append(IsaToken.OPTIONAL_SOME.toString());
			expStr.append(IsaToken.parenthesise(exp.translate()));
		}
		else
		{
			// as TLD, no need for record-context translation; this is for non TLD expr!
			expStr.append(exp.translate());//exp.recordPatternTranslate(pattern));
		} 
		return expStr.toString();
	}

	@Override
	public String translate()
	{
		// translate the "v: T = e" as an abbreviation or definition
		StringBuilder sb = new StringBuilder();

		// these are always TRLocalDefinition within the list. 
		// these allow the totally wacky VDM like "values [A,B] = [1,2];", where A binds to 1 and B to 2! 
		if (!(pattern instanceof TRRecordPattern) && this.defs.size() > 1)
			//TODO get from the defs instead 
			report(IsaErrorMessage.ISA_INVALID_COMPLEX_BIND_VALUE_1P, pattern.toString());

		// translate the value expression
		String expStr = translateExpression();
		
		// global definitions (e.g. v: T = e) require invariant translation alongside its defining expression
		if (!isLocal())
		{
			// add any annotations or comments (i.e. TRDefinition.translate(), given super.translate won't work here)
			sb.append(translatePreamble());

			sb.append(IsaTemplates.translateAbbreviation(getLocation(), getDeclaredName(), getTypeString(), 
				/*IsaToken.parenthesise*/(expStr)));
			sb.append(getFormattingSeparator());

			// translate inv_v as definition
			sb.append(invTranslate());
		}
		// local definitions (e.g. let v: T = e1 in e2) only require the type info
		else
		{
			//TODO perhaps do not need this beyond checking for bad patterns; don't want to reinvent above in TRLocalDefinition
			//		neither have them as subclasses of each other or something like that?
			//sb.append(defs.translate());

			sb.append(super.translate());
			sb.append(IsaToken.SPACE.toString());//getSemanticSeparator());
			sb.append(IsaToken.EQUALS.toString());
			sb.append(IsaToken.SPACE.toString());//getSemanticSeparator());
			sb.append(/*IsaToken.parenthesise*/(expStr));
		}
        return sb.toString();
	}

	@Override
	public String invTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isLocal())
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
			sb.append(IsaTemplates.translateInvariantAbbreviation(getLocation(), varName, inType, dummyVarNames(), getInvariantString(varName), false));
			sb.append(getFormattingSeparator());
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

	public TRPattern getPattern()
	{
		return pattern;
	}

	public TRExpression getExp()
	{
		return exp;
	}

	public TRDefinitionList getDefs()
	{
		return defs;
	}

	public TRType getExpType()
	{
		return expType;
	}
}
