/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;


import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCValueDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRMkBasicExpression;
import vdm2isa.tr.expressions.TRNilExpression;
import vdm2isa.tr.patterns.TRAbstractContextualPattern;
import vdm2isa.tr.patterns.TRBasicPattern;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.TRPatternBind;
import vdm2isa.tr.patterns.TRRecordPattern;
import vdm2isa.tr.patterns.TRStructuredPattern;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRProductType;
import vdm2isa.tr.types.TRTokenType;
import vdm2isa.tr.types.TRType;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.messages.IsaWarningMessage;

/**
 * VDM values are translated as Isabelle constants. 
 */
public class TRValueDefinition extends TRLocalDefinition
{
	private static final long serialVersionUID = 1L;
	public final TRPattern pattern;
	public final TRExpression exp;
	public final TRDefinitionList defs;
	public final TRType expType;

	protected TRValueDefinition(
		TCDefinition definition, 
		LexLocation location,
		TRIsaVDMCommentList comments, 
		TRAnnotationList annotations, 
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
		this.defs = defs;//figureOutDefs(defs);
	}
		
	public TRValueDefinition(
		TCValueDefinition definition, 
		TRIsaVDMCommentList comments, 
		TRAnnotationList annotations, 
		NameScope nameScope,
		boolean used,
		boolean excluded, 
		TRPattern pattern, 
		TRType type, 
		TRExpression exp,
		TRType expType, 
		TRDefinitionList defs)
	{
		this(definition, pattern != null ? pattern.location : LexLocation.ANY, comments, annotations, nameScope, used, excluded, pattern, type, exp, expType, defs);		
	}

	@Override
	public void setup()
	{
		super.setup();
		TRNode.setup(pattern, exp, defs, expType);
		//this.defs = figureOutDefs(defs);?
		//if (local) 
		//	System.out.println(toString());
	}

	@Override
	public String toString()
	{
		return "ValueDef [local=" + isLocal() + "] for " + 
			"\n\t patt = " + String.valueOf(pattern) + 
			"\n\t expt = " + String.valueOf(expType) +
			"\n\t defs = " + String.valueOf(defs) +
			"\n\t loc  = " + String.valueOf(getLocation()) +
			"\n\n\t FV = " + getFVS().toString() +
			"\n\t VN = " + getVNS().toString();
	}

	private TCNameSet getFVS()
	{
		return this.getVDMDefinition().getFreeVariables();
	}

	private TCNameList getVNS()
	{
		return this.getVDMDefinition().getVariableNames();
	}

	@Override
    protected String getDeclaredName()
    {
		assert getPattern() != null; 
		return getPattern().translate();
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

	protected String typeAware(String expr)
	{
		// translate the value expression
		StringBuilder expStr = new StringBuilder();
		expStr.append(tldIsaComment());
		if (getType() instanceof TROptionalType && !(exp instanceof TRNilExpression))
		{
			expStr.append(IsaToken.OPTIONAL_SOME.toString());
			expStr.append(IsaToken.parenthesise(expr));
		}
		else
		{
			// as TLD, no need for record-context translation; this is for non TLD expr!
			expStr.append(expr);//exp.translate());//exp.patternContextTranslate(pattern));
		} 
		return expStr.toString();
	}

	private TRPattern figureOutPattern(int index, TCNameToken localName)
	{
		assert index >= 0 && index < getDefs().size();
		TRPattern result; 
		//String identifier;// = localName.getName();//localName.toString(): no type parameters!
		if (pattern instanceof TRBasicPattern)
		{
			result = TRBasicPattern.identifier(localName.getLocation(), pattern.translate());
			warning(IsaWarningMessage.PLUGIN_NYI_2P, "basic pattern name projection", "complex value definition");
		}
		else if (pattern instanceof TRRecordPattern)
		{
			//TODO stopped here. 
			result = pattern;
			//warning(IsaWarningMessage.PLUGIN_NYI_2P, "record pattern name projection", "complex value definition");
		}
		else if (pattern instanceof TRStructuredPattern)
		{
			// use local name
			result = TRBasicPattern.identifier(localName.getLocation(), localName.getName());
			//if ! those then warn?
			//getVDMDef().findName(localName)
			//pattern.getPatternList().get(index).getPattern().equals(localName.getName());
			//TODO cater for @NB's weird case [-,-,a] = [1,2,3]!  
		}
		else if (pattern instanceof TRPatternBind)
		{
			result = TRBasicPattern.identifier(localName.getLocation(), pattern.translate());			
			warning(IsaWarningMessage.PLUGIN_NYI_2P, "pattern bind name projection", "complex value definition");
		}
		else 
		{
			result = TRBasicPattern.identifier(localName.getLocation(), IsaToken.dummyVarNames(1, false, localName.getLocation()));
			report(IsaErrorMessage.VDMSL_INVALID_PATTERN);//TODO better error please?! 
		}
		return result;
	}

	private TRType figureOutPatternType(TRPattern p, TRType localType)
	{
		TRType result = localType;
		if (p instanceof TRRecordPattern)
		{
			result = expType;
		}
		return result;
	}

		/**
	 * Translate the value expression taking into account which definition index to consider. 
	 * These will be > 0 or != null for structured/complex patterns (e.g. mk_(x,y) = v)  
	 * @param defindex
	 * @return
	 */
	private String figureOutExpression(int index, TRType localType)
	{
		assert index >= 0 && index < getDefs().size();
		String result = exp.translate();
		// if (pattern instanceof TRBasicPattern)
		// {
		// 	warning(IsaWarningMessage.PLUGIN_NYI_2P, "basic pattern expression projection", "complex value definition");
		// }
		// else if (pattern instanceof TRRecordPattern)
		// {
		// 	warning(IsaWarningMessage.PLUGIN_NYI_2P, "record pattern expression projection", "complex value definition");
		// }
		//else 
		if (pattern instanceof TRStructuredPattern)
		{	
			TRStructuredPattern spattern = (TRStructuredPattern)pattern;
			// associated TRLocalDefinition index *must* be within the pattern's size! 
			assert index < spattern.getPatternList().size(); 
			switch (spattern.isaToken())
			{
				case CROSSPROD:
					// translate the expression and project it's field out
					result = TRProductType.fieldProjection(index, spattern.getPatternList().size(), result);
					break;
				case SET:
					//break;
				case SEQ:
					//break;
				case CONCATENATE:
					//break;
				case MAPLET:
					//break;
				case UNION:
					//break;
				case MUNION:
					//break;
				case MAP:
					//break;
				default:
					report(IsaErrorMessage.PLUGIN_NYI_2P, "structured pattern expression projection", spattern.isaToken().toString());
					break;				
			}
		}
		// this could be checked to see whether the value definition is "flat"! 
		// if (!localType.compatible(result.getType()))
		// {
		// 	report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, localType.getName(), result.getType().getName());
		// }
		return typeAware(result);
	}

	private TRDefinitionList figureOutDefs()
	{
		TRDefinitionSet result = new TRDefinitionSet(defs);
		// check defs structure: empty/null is bad
		// if (result == null || result.isEmpty())
		// {
        //     report(IsaErrorMessage.VDMSL_INVALID_VALUEDEF_3P, "value", "definitions", "cannot be null or empty");
		// }
		// catering for the ignore pattern case like "- : nat = 10;"
		if (result.isEmpty())
		{
			if (!pattern.isIgnore()) 
			{
				report(IsaErrorMessage.VDMSL_INVALID_VALUEDEF_3P, "value", "definitions", "empty definitions must have `ignore` (-) pattern");
			}
			// local dummy ignores (e.g. let -: T = v in P) is okay, but global ones will cause trouble (e.g. -: nat = 10); 
			else if (!isLocal())
			{
				report(IsaErrorMessage.ISA_INVALID_IGNORE_VALUEDEF);
			}
			// add to the result regardless; also add to defs, so that it won't break in other places! 
			assert defs.isEmpty();
			// or should I not translate ignore stuff? 
			defs.add(this);
			result.add(this);
		}
		// not with locals only is bad
		else if (!result.allAreLocalDefinition())
		{
            report(IsaErrorMessage.VDMSL_INVALID_VALUEDEF_3P, "value", "definitions", "must all be local definitions");
		}
		// create the value definition for every local defintion to include its adequately projected expression
		// depending on the pattern involved, be that local or global definitions! 
		// e.g. LOCAL : let "mk_(x,y) = v" in P =vdm2isa=> let "x = fst v, y = snd v" in P 
		// 		GLOBAL: [A,B] = [1,2] 			=vdm2isa=> abbreviation A: VDMNat = 1, abbreviation B: VDMNat = 2 
		//
		// This also caters for the "normal case", where only LocalDef exits: pick it with the expression as-is 
		else if (result.size() == 1)
		{
			// if it's a record pattern, it's fine: it's handled by records; 
			
			//This is okay: the pattern itself on the LHS is the definition! 
			// // if it's a structured pattern, then something is wrong with the AST because defs.size() == 1
			// if (pattern instanceof TRStructuredPattern)
			// {
			// 	report(IsaErrorMessage.VDMSL_INVALID_VALUEDEF_3P, "value", pattern.toString(), "does not have corresponding definitions");
			// }

			// this will cater for record patterns as well! 
			result.clear();
			result.add(this);
		}
		else if (result.size() > 1)
		{
			// figure out the definitions reshape based on complex pattern (if any)
			// given certain patterns might have more locals than we want defs to, 
			// use a set instead of list (e.g. mk_R(x,y) = r, will create one variable only
			// and the patternContextTranslate() figures the rest out)
			//
			// for structured pattern though (e.g. mk_(x,y) = t), the definition list has two names.
			// but actually it should be a dummy name for the structured pattern and let the pattern
			// context figure the rest out. That means, TRValueDefinition translate has to take that
			// into account (i.e. defList.size() > 1, but pattern is structured). 
			//
			// on the other hand, if the value definition is global (e.g. values mk_(x,y) = mk_(10,5)),
			// then the separation of value names into multiple value defs still applies! 
			// that is: the only case where we don't separate the values into multiple definitions is 
			// for local strucrtured patterns
			//
			// all non-local are split; and all non-strucrtured are split 
			if (!(isLocal() && pattern instanceof TRStructuredPattern))
			{
				result = new TRDefinitionSet();
				// definition sets will "loose" order. For now revert inclusion? 
				//for(int i = 0; i < defs.size(); i++)
				for(int i = defs.size() - 1; i >= 0; i--)
				{
					TRLocalDefinition ld = (TRLocalDefinition)defs.get(i);
					TRPattern patt = figureOutPattern(i, ld.name);
					TRType patternType = figureOutPatternType(patt, ld.type); 
					//TRExpression e = figureOutExpression(i, ld.type);
					//figure expression string out rather than try to "construct" new one; simpler. 
					result.add(newValueDefinition(ld, patt, patternType/*ld.getType()*/));
				}
			}
			else
			{
				// if local and structured, only issue one definition!  
				result.clear();
				result.add(this);
			}
		}
		// figuring out doesn't loose definitions; and all are value definitions
		// might be smaller for cases involving ignore pattern (e.g mk_(-,x) = v) 
		// or record pattern (e.g. mk_R(x,y) = r).
		// forgot to cater for empty defs (e.g., -: nat = 10)!?! Adding this to that case too. 
		
		// defs is empty or results within defs
		assert 
			//(defs.isEmpty() && result.size() == 1) 
			//|| 
			(!defs.isEmpty() && result.size() <= defs.size()); 

		// overall result cannot be empty and must be uniform
		assert !result.isEmpty() && result.allAre(this/*TRValueDefinition.class; TREqualsDefinition.class*/);
		TRDefinitionSet.setup(result);
		return result.asList();
	}

	protected TRValueDefinition newValueDefinition(TRLocalDefinition ld, TRPattern patt, TRType patternType)
	{
		assert (getVDMDefinition() instanceof TCValueDefinition);
		return TRValueDefinition.newValueDefinition(getVDMValueDefinition(), 
			ld.getLocation(), comments, annotations, nameScope, used, excluded, patt, patternType/*ld.getType()*/, 
			exp, this.expType, TRDefinitionList.newDefList(ld));
	}

	@Override
	public String translate()
	{
		// translate the "v: T = e" as an abbreviation or definition
		StringBuilder sb = new StringBuilder();

		TRDefinitionList defList = figureOutDefs();
		
		// global definitions (e.g. v: T = e) require invariant translation alongside its defining expression
		if (!isLocal())
		{
			// these are always TRLocalDefinition within the list. 
			// these allow the totally wacky VDM like "values [A,B] = [1,2];", where A binds to 1 and B to 2! 
			// if (!(pattern instanceof TRRecordPattern) && this.defs.size() > 1)
			// 	//TODO get from the defs instead 
			// 	report(IsaErrorMessage.ISA_INVALID_COMPLEX_BIND_VALUE_1P, pattern.toString());

			// add any annotations or comments (i.e. TRDefinition.translate(), given super.translate won't work here)
			sb.append(translatePreamble());

			// unpick value def apart
			for(int i = 0; i < defList.size(); i++)
			{
				// presume value definitions have been properly figured out
				TRDefinition d = defList.get(i);
				assert d instanceof TRValueDefinition;
				TRValueDefinition vdef = (TRValueDefinition)d;

				// presume things have been flattened out whilst figuring defs out
				// must also take into account ignore pattern case, which will have an empty getDefs()! 
				// this is sorted out whilst figuring patterns out. 
				assert
					//(vdef.getDefs().isEmpty() && vdef.getPattern().isIgnore())
					//|| 
					(vdef.getDefs().size() == 1 && vdef.getDefs().allAreLocalDefinition() && vdef.getPattern() instanceof TRBasicPattern);

				// presume the vdef.getType() (as the local def inner/flattened type)
				String expStr = figureOutExpression(i, vdef.getType());

				// translate the abbreviation definition per vdef
				sb.append(IsaTemplates.translateAbbreviation(getLocation(), vdef.getDeclaredName(), vdef.getTypeString(), 
							/*IsaToken.parenthesise*/(expStr)));
				sb.append(getFormattingSeparator());

				// translate inv_v as the definition
				sb.append(vdef.invTranslate());
			}
		}
		// local definitions (e.g. let v: T = e1 in e2) only require the type info
		// they may also require expansion if using structured/record pattern on the LHS
		else
		{
			// reached bottom line 
			// see also figureOutDefs() when defList.size() > 1 and pattern is structured
			// this latter case relies on whoever issues the value translation to cater for pattern contexts? 
			if (defList.size() == 1)
			{
				if (pattern instanceof TRAbstractContextualPattern)
				{
					sb.append(getFormattingSeparator());
					sb.append(IsaToken.comment(
							IsaInfoMessage.ISA_PATTERN_CONTEXT_1P.format(
									isLocal() ? "let-bind definition" : "value definition"), getFormattingSeparator()));
				}
				sb.append(super.translate());
				sb.append(IsaToken.SPACE.toString());
				sb.append(IsaToken.EQUALS.toString());
				sb.append(IsaToken.SPACE.toString());
				sb.append(exp.typeConvertTranslate(null, getType()));	
			}
			// unpick value def apart until you reach bottom line
			else 
			{
				TRDefinition d = defList.get(0);
				// presume value definitions have been properly figured out
				assert d instanceof TRValueDefinition;
				TRValueDefinition vdef = (TRValueDefinition)d;
				// presume things have been flattened out whilst figuring defs out 
				assert vdef.getDefs().size() == 1 && vdef.getDefs().allAreLocalDefinition() ;//&& vdef.getPattern() instanceof TRBasicPattern;

				sb.append(vdef.translate());
				for(int i = 1; i < defList.size(); i++)
				{
					sb.append(getSemanticSeparator());

					// presume value definitions have been properly figured out
					assert defList.get(i) instanceof TRValueDefinition;
					vdef = (TRValueDefinition)defList.get(i);
					// presume things have been flattened out whilst figuring defs out 
					assert vdef.getDefs().size() == 1 && vdef.getDefs().allAreLocalDefinition();// && vdef.getPattern() instanceof TRBasicPattern;

					sb.append(vdef.translate());
				}
			}
		}
        return sb.toString();
	}

	@Override
	public String invTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isLocal())
		{
			String varName = getDeclaredName();
			String dummyNames = (type instanceof TRFunctionType ? "" : dummyVarNames());
			sb.append(IsaTemplates.translateInvariantAbbreviation(getLocation(), varName, null, dummyNames, getInvariantString(varName), false));
			sb.append(getFormattingSeparator());
			// // translate the type invariant definition as inv_v definition, possibly with dummy names for lambdas
			// // input type is possibly empty (null) in case of non function type
			// String inType = null;
			// if (type instanceof TRFunctionType)
			// {
			// 	inType = ((TRFunctionType)type).parameters.translate();
			// }
			
			// //type instanceof TRFunctionType => inType != null
			// assert !(type instanceof TRFunctionType) || inType != null; 

			// String varName = getDeclaredName();//.toLowerCase();
			// // assemble the template
			// sb.append(IsaTemplates.translateInvariantAbbreviation(getLocation(), varName, inType, dummyVarNames(), getInvariantString(varName), false));
			// sb.append(getFormattingSeparator());
		}
		else
		{
			sb.append(super.invTranslate());
		}
		return sb.toString();
	}

	private void checkForInnerTokenType()
	{
		// if VDMToken, has to prefix the type string with its generic type instantiation 
		if (type instanceof TRTokenType)
		{
			TRTokenType tt = (TRTokenType)type;
			if (this.exp instanceof TRMkBasicExpression)
			{
				TRMkBasicExpression mbe = (TRMkBasicExpression)exp;
				tt.setInnerTokenType(mbe.arg.getType());
			}
			else 
			{
				report(IsaErrorMessage.ISA_INVALID_TOKENEXPR_1P, exp.translate());
			}
		}
	}

	@Override
	protected String getTypeString()
    {
		checkForInnerTokenType();
		return super.getTypeString();
    }

	@Override
	protected String getInvariantString(String varName)
    {
		checkForInnerTokenType();
		return super.getInvariantString(varName);
    }

	@Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseValueDefinition(this, arg);
	}

	public TCValueDefinition getVDMValueDefinition()
	{
		return (TCValueDefinition)getVDMDefinition();
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

	public static final TRValueDefinition newValueDefinition(TCValueDefinition definition, 
		LexLocation location, 
		TRIsaVDMCommentList comments, 
		TRAnnotationList annotations, 
		NameScope nameScope,
		boolean used,
		boolean excluded, 
		TRPattern pattern, 
		TRType type, 
		TRExpression exp,
		TRType expType, 
		TRDefinitionList defs)
	{
		TRValueDefinition result = 
				new TRValueDefinition(definition, location, comments, annotations, nameScope, used, 
									  excluded, pattern, type, exp, expType, defs);
		TRNode.setup(result);
		return result;
	}
}
