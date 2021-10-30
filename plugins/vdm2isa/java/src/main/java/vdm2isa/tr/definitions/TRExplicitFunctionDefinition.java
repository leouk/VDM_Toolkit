/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionListList;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.patterns.TCPattern;

import plugins.Vdm2isaPlugin;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.types.TRFunctionType;

public class TRExplicitFunctionDefinition extends TRDefinition
{
	private static final long serialVersionUID = 1L;

	/**
	 * Only pre/post/inv can be implicitly generated when the user doesn't explicitly define them
	 * yet we must check the related (sub-)type invariants. Equality is added also because of 
	 * VDM record equality abstraction (":-"), which will require an implicit definition in Isabelle
	 * about record equality.   
	 */
	private static final List<TRSpecificationKind> 
		VALID_IMPLICITLY_GENERATED_SPEC_KIND = 
			Arrays.asList(TRSpecificationKind.PRE, 
						TRSpecificationKind.POST, 
						TRSpecificationKind.INV, 
						TRSpecificationKind.EQ);

	private final TCNameToken name;
	private final TCNameList typeParams;
	private final TRFunctionType type;
	private final TRPatternListList parameters;
	private final TRExpression body;
	private final TRExpression precondition;
	private final TRExpression postcondition;
	private final boolean isTypeInvariant;
	private final TRExpression measureExp;
	private final boolean isCurried;
	private final boolean recursive;
	private final boolean isUndefined;
	private final TRSpecificationKind implicitSpecificationKind;
	private final TRExplicitFunctionDefinition predef;
	private final TRExplicitFunctionDefinition postdef;
	private final TCDefinitionListList paramDefinitionList;

	public TRExplicitFunctionDefinition(LexCommentList comments,
			TCAnnotationList annotations,
			TCNameToken name,
			TCNameList typeParams, TRFunctionType type,
			TRPatternListList parameters, TRExpression body,
			TRExpression precondition,
			TRExpression postcondition, boolean typeInvariant, TRExpression measureExp,
			boolean isCurried, 
			TRExplicitFunctionDefinition predef,
			TRExplicitFunctionDefinition postdef,
			TCDefinitionListList paramDefinitionList,
			boolean recursive,
			boolean isUndefined)
	{
		super(name.getLocation(), comments, annotations);
		this.name = name;
		this.typeParams = typeParams;
		this.type = type;
		this.parameters = parameters;
		// null body for case where user does not define the pre/post explicitly but we need its TRDefinition for implicit invariant type checks?
		this.body = body;
		this.precondition = precondition;
		this.postcondition = postcondition;
		this.isTypeInvariant = typeInvariant;
		this.measureExp = measureExp;
		this.isCurried = isCurried;
		this.predef = predef;
		this.postdef = postdef;
		this.paramDefinitionList = paramDefinitionList;
		this.recursive = recursive;
		this.isUndefined = isUndefined;
		this.local = false; // LetDefExpression to set this to true if/when needed
		this.implicitSpecificationKind = impliSpecificationDefinition();

		//TODO type parameters are comma separated?	
		// parameters are curried not "," separated
		this.parameters.setSeparator(" ");
		
		if (precondition != null && predef == null)
			report(11111, "Explicit funciton has declared precondition but no pre definition.");
		if (postcondition != null && postdef == null)
			report(11111, "Explicit funciton has declared postcondition but no post definition.");
		
		// if the body is null, this is an implicitly generated TRExplicitFunctionDefinition,
		// which *must* be of a specific specification kind.
		if (body == null && !VALID_IMPLICITLY_GENERATED_SPEC_KIND.contains(implicitSpecificationKind))
		{
			report(11111, "Invalid implicitly generated specificaiton check for " + name.toString() + 
				". Must be one of " + VALID_IMPLICITLY_GENERATED_SPEC_KIND.toString());
		}

		if (this.isCurried)
		{
			warning(11111, "VDM (curried) explicit function definition still with some problems!");
		}

		if (!Arrays.asList(TRSpecificationKind.PRE, TRSpecificationKind.POST, TRSpecificationKind.NONE).contains(implicitSpecificationKind)) 
			System.out.println(toString());
    }

    @Override
	public String toString()
	{
		return "TRExplicitFuncDef for " + 
			" \n\tname        = " + String.valueOf(name) +
			" \n\tlocal		  = " + local + 
			" \n\tkind		  = " + implicitSpecificationKind +
			" \n\ttype params = " + String.valueOf(typeParams) + 
			" \n\ttype        = " + (type != null ? type.translate() : "null") + 
			" \n\tparameters  = " + String.valueOf(parameters) + 
			" \n\tbody        = " + (body != null ? body.translate() : "null") + 
			" \n\tpre         = " + (precondition  != null ? precondition.getClass().getName()  + ": " + precondition.translate()  : "null") + 
			" \n\tpost        = " + (postcondition != null ? postcondition.getClass().getName() + ": " + postcondition.translate() : "null") + 
			" \n\tisTypeInv   = " + isTypeInvariant +
			" \n\tmeasure     = " + (measureExp != null ? measureExp.getClass().getName() + ": " + measureExp.translate() : "null") +
			" \n\tisCurried   = " + isCurried +
			// avoid calling translate for TLD as it creates a record of what has been translated!  
			" \n\tpredef      = " + (predef  != null ? predef.getClass().getName()  + ": \n========" + predef.toString() + "\n========"/*predef.translate()*/  : "null") +
			" \n\tpostdef     = " + (postdef != null ? postdef.getClass().getName() + ": \n========" + postdef.toString() + "\n========"/*postdef.translate()*/ : "null") +
			" \n\tparamDefList= " + String.valueOf(paramDefinitionList) +
			" \n\trecursive   = " + recursive +
			" \n\tisUndefined = " + isUndefined;
	
		// f: nat -> nat
		// f(x) == x + 1;
		//
		// TRExplicitFuncDef for f 
		// 	type params = null 
		// 	type        = VDMNat \<Rightarrow> VDMNat 
		// 	parameters  = [x] 
		// 	body        = (x + (1::VDMNat1)) 
		// 	pre         = null 
		// 	post        = null 
		// 	isTypeInv   = false 
		// 	measure     = null 
		// 	isCurried   = false 
		// 	predef      = null 
		// 	postdef     = null 
		// 	paramDefList= [x = nat]
	}

	/**
	 * Determines wether this TRExplicitFunctionDefinition is one of those constructed by the typechecker.
	 * Depending on which kind (if any), then translation has to take into account different considerations. 
	 * Decision is based on VDM naming conventions (e.g., pre_, post_, inv_, ord_, eq_, etc.).
	 * @return the kind of implicit specification associated with this definition
	 */
	private TRSpecificationKind impliSpecificationDefinition()
	{
		TRSpecificationKind result = TRSpecificationKind.NONE;

		// presumes Settings.release = VDM_10 and dialect = VDMSL. This is checked by Vdm2isaPlugin.run anyhow
		if (name.isReserved())
		{
			String fcnName = name.getName();
			if (fcnName.startsWith("pre_")) 
				result = TRSpecificationKind.PRE;
			else if (fcnName.startsWith("post_"))
				result = TRSpecificationKind.POST;
			else if (fcnName.startsWith("inv_"))
				result = TRSpecificationKind.INV;
			else if (fcnName.startsWith("init_"))
				result = TRSpecificationKind.INIT;
			else if (fcnName.startsWith("measure_"))
				result = TRSpecificationKind.MEASURE;
			else if (fcnName.startsWith("eq_"))
				result = TRSpecificationKind.EQ;
			else if (fcnName.startsWith("ord_"))
				result = TRSpecificationKind.ORD;
			else if (fcnName.startsWith("min_"))
				result = TRSpecificationKind.MIN;
			else if (fcnName.startsWith("max_"))	
				result = TRSpecificationKind.MAX;
		}
		return result;
	} 

	/**
	 * VDM constant functions (e.g., f:() -> nat) are translated as Isabelle constants.  
	 * @return if this is a constant function
	 */
	protected boolean isConstantFunction()
	{
		return type.parameters.isEmpty();
	}

	/**
	 * Implicit checks for pre/post. They are similar with minor differences, so parameterised here to avoid repetition
	 * at possibly the cost of making it slightly harder to follow. 
	 * @param kind
	 * @param formattingSeparator
	 * @return
	 */
	protected String translateImplicitChecks(TRSpecificationKind kind, String formattingSeparator)
	{
		StringBuilder fcnBody = new StringBuilder();

		if (kind == TRSpecificationKind.PRE && isConstantFunction())
		{
			// constant function preconditions do not require invariant checks (no parameters)
		}	
		else
		{
			// pre/post checks on input (including RESULT for post) types
			// there is no need to check type.result type because for PRE/POST defs that's always bool! 
			fcnBody.append(formattingSeparator);
			fcnBody.append(IsaToken.comment("Implicitly defined type invariant checks", formattingSeparator));
			
			List<String> varNames = parameters.varNameTranslate();
			String paramsStr = type.parameters.invTranslate(varNames, formattingSeparator);
			if (kind == TRSpecificationKind.POST && Vdm2isaPlugin.linientPost)
			{
				// include "pre_f x =>" within post (i.e. ignore RESULT from varNames) 
				assert name.getName().startsWith("post_");
				String preCall = "pre_" + name.getName().substring("post_".length()) + " ";
				boolean removed = varNames.remove("RESULT");//varNames.remove(varNames.size()-1)
				if (!removed)
				{
					warning(11111, "Could not find \"RESULT\" variable in implicit post condition specification definition");
				}
				// transform "[x,y]" into "x y", "[x]" into "x", "[]" into ""
				String varList = varNames.toString().replace(',', ' ');
				assert varList.length() >= 2;
				paramsStr = IsaToken.parenthesise(
						preCall + varList.substring(1, varList.length()-1) + " " +
						IsaToken.IMPLIES.toString() + " " + // formattingSeparator +
						paramsStr);
				//TODO this will possibly create "messy" formatting if separator includes \n! 
			}
			fcnBody.append(paramsStr);
			
			// if there is a user defined body, add the missing conjunction for it
			if (!isImplicitlyGenerated())
			{
				fcnBody.append(" ");
				fcnBody.append(IsaToken.AND.toString());
			}
		}
		return fcnBody.toString();
	}

	/**
	 * For situations where the user does not define pre/posts, like in 
	 * 		f: nat -> nat
	 * 		f(x) == x;
	 * We still have to translate a pre/post_f calls to check type invariants. 
	 * Implicitily generated pre/post TRExplicitFunctionDefinition *must* have null body and pre/post/inv names!
	 *  
	 * @return true when pre/post are being implicitly generated
	 */
	protected boolean isImplicitlyGenerated()
	{
		return body == null;
	}

	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		
		// add any comments and annotations
		sb.append(super.translate());
		
		//TODO implcit type invariant checks on both pre and post

		// translate the precondition
		if (predef != null) 
		{
			sb.append(predef.translate());
			sb.append("\n");
		}

		// translate the postcondition
		if (postdef != null)
		{
			sb.append(postdef.translate());
			sb.append("\n");
		}

		// translate the explicit function definition taking into consideration TRSpecificationKind
		// constant functions are translated as constant definitions (not abbreviations) with null inType string.		
		String fcnName     = name.getName();
		String fcnInType   = isConstantFunction() ? null : type.parameters.translate();
		String fcnOutType  = type.result.translate();
		String fcnParams   = parameters.translate();
		String formattingSeparator = "\n\t "; // " " "\n\t" "\n\t\t" etc.
		StringBuilder fcnBody = new StringBuilder();
		switch (implicitSpecificationKind)
		{
			// ready; do nothing else
			case NONE:
				break;

			// include implicit function parameters invariant checks
			case PRE:
			case POST:
				fcnBody.append(translateImplicitChecks(implicitSpecificationKind, formattingSeparator));	
				break;

			case INV:
				//TODO
				break;
			case EQ:
				break;
			case ORD:
				break;
			case MEASURE:
				break;
			case INIT:
				break;
			case MAX:
				break;
			case MIN:
				break;			
		}
		// include the user declared body after including implicit considerations
		fcnBody.append(formattingSeparator);
		fcnBody.append(IsaToken.comment("User defined body", formattingSeparator));
		fcnBody.append(body.translate());

		// translate definition according to discovered (possibly implicit) considerations. fcnInType is null for constant functions
		sb.append(IsaTemplates.translateDefinition(fcnName, fcnInType, fcnOutType, fcnParams, fcnBody.toString()));

		return sb.toString();
	}

	@Override
	public String invTranslate() {
		StringBuilder sb = new StringBuilder();
		//TODO perhaps not needed? Maybe in let locally defined? 
		warning(11111, "TODO: processing explicit function invTranslate please!");
		return sb.toString();
	}

	@Override
	public IsaToken isaToken() {
		return IsaToken.FUN;
	}

	@Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseExplicitFunctionDefinition(this, arg);
	}

	public TRPatternListList getParameters()
	{
		return parameters;
	}

	public TRFunctionType getType()
	{
		return type;
	}

	public TRExpression getBody()
	{
		return body;
	}

	public TRExplicitFunctionDefinition getPredef()
	{
		return predef;
	}

	public TRExplicitFunctionDefinition getPostdef()
	{
		return postdef;
	}

	public TRExplicitFunctionDefinition getMeasureDef()
	{
		return null;	// TODO!!
	}
}
