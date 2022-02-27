/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Vector;

import com.fujitsu.vdmj.tc.definitions.TCAccessSpecifier;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import plugins.GeneralisaPlugin;
import plugins.Vdm2isaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRApplyExpression;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRExpressionList;
import vdm2isa.tr.patterns.TRBasicPattern;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.TRPatternList;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.patterns.TRUnionContext;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeList;

public class TRExplicitFunctionDefinition extends TRAbstractFunctionDefinition
{
	private static final long serialVersionUID = 1L;

	protected TRPatternListList paramPatternList;
	private final boolean isTypeInvariant;
	private final boolean isCurried;
	/**
	 * This is the type of TRFunctionType result (or somewhere in between if curried)
	 */
	protected TRType expectedResult;
	protected TRDefinitionListList paramDefinitionList;

	protected TRExplicitFunctionDefinition(TCDefinition definition, 
			TRIsaVDMCommentList comments,
			TRAnnotationList annotations,
			TCNameToken name,
			NameScope nameScope, 
			boolean used, 
			boolean excluded,
			TCNameList typeParams, 
			TRFunctionType type,
			TRPatternListList paramPatternList, 
			TRExpression body,
			TRExpression precondition,
			TRExpression postcondition, 
			boolean typeInvariant, 
			TRExpression measureExp,
			boolean isCurried, 
			TRExplicitFunctionDefinition predef,
			TRExplicitFunctionDefinition postdef,
			TRDefinitionListList paramDefinitionList,
			boolean recursive,
			boolean isUndefined,
			TRType actualResult,
			TRType expectedResult, boolean ignore)
	{	
		// get the name location, given definition might be null for synthetic cases. 
		super(definition, comments, annotations, name, nameScope, used, excluded, typeParams, type, body,
			precondition, postcondition, measureExp, predef, postdef,
			recursive, isUndefined, actualResult);
		this.paramPatternList = paramPatternList;
		this.isTypeInvariant = typeInvariant;
		this.isCurried = isCurried;
		this.paramDefinitionList = paramDefinitionList;
		this.expectedResult = expectedResult;
    }

	public TRExplicitFunctionDefinition(TCExplicitFunctionDefinition definition, 
		TRIsaVDMCommentList comments,
		TRAnnotationList annotations,
		TCNameToken name,
		NameScope nameScope, 
		boolean used, 
		boolean excluded,
		TCNameList typeParams, 
		TRFunctionType type,
		TRPatternListList paramPatternList, 
		TRExpression body,
		TRExpression precondition,
		TRExpression postcondition, 
		boolean typeInvariant, 
		TRExpression measureExp,
		boolean isCurried, 
		TRExplicitFunctionDefinition predef,
		TRExplicitFunctionDefinition postdef,
		TRDefinitionListList paramDefinitionList,
		boolean recursive,
		boolean isUndefined,
		TRType actualResult,
		TRType expectedResult)
	{	
		this(definition, comments, annotations, name, nameScope, used, excluded, 
			typeParams, type, paramPatternList, body,
			precondition, postcondition, typeInvariant, measureExp, isCurried, 
			predef, postdef, paramDefinitionList,
			recursive, isUndefined, actualResult, expectedResult, false);
	}

	@Override
	public void setup()
	{
		super.setup();
		assert this.paramPatternList != null; 

		this.paramDefinitionList = figureOutParamDefinitionList();

		// setup various bits later, as some might get created above.
		TRNode.setup(paramPatternList, paramDefinitionList, expectedResult);

		// parameters and type parameters are curried not "," separated
		//this.typeParams.setSemanticSeparator(IsaToken.SPACE.toString());
		this.paramPatternList.setSemanticSeparator(IsaToken.SPACE.toString());
	} 

	@Override
	protected TRExplicitFunctionDefinition createUndeclaredSpecification(TRSpecificationKind kind)
	{
		return TRExplicitFunctionDefinition.createUndeclaredSpecification(name, nameScope, used, excluded, typeParams,
		 			type, isCurried, paramPatternList, paramDefinitionList, kind); 
	}

	@Override 
	public boolean isImplicitFunction()
	{
		return false;
	}

	/**
	 * Update specification generic types to cater for type invariant calls passed as boolean valued functions on 
	 * each of the involved generic parameters. 
	 */
	@Override
	protected void updateSpecificationGenericParameters()
	{
		// type params is null  for functions without parameters
		if (hasTypeParameters())
		{
			type = TRFunctionType.expandGenericTypes(type, typeParams);
			paramPatternList = type.expandGenericTypesPatterns(paramPatternList);
		}
	}

	@Override
	public String toString()
	{
		return getClass().getSimpleName().toString() + " for " + 
			" \n\tname        = " + String.valueOf(name) +
			" \n\tlocal	      = " + isLocal() + 
			" \n\tused	      = " + used + 
			" \n\texcluded    = " + excluded + 
			" \n\tnamescope	  = " + (nameScope != null ? nameScope.name() : "?") +
			" \n\tkind	      = " + implicitSpecificationKind +
			" \n\ttype params = " + String.valueOf(typeParams) + 
			" \n\ttype sig    = " + String.valueOf(type) + 
			" \n\ttype sig in = " + (type != null ? String.valueOf(type.parameters) : "null") +
			" \n\ttype sig out= " + String.valueOf(type) + 
			" \n\tparameters  = " + String.valueOf(paramPatternList) + 
			" \n\tbody        = " + String.valueOf(body) + 
			" \n\tpre         = " + (precondition  != null ? precondition.getClass().getSimpleName()  + ": " + precondition.toString()  : "null") + 
			" \n\tpost        = " + (postcondition != null ? postcondition.getClass().getSimpleName() + ": " + postcondition.toString() : "null") + 
			" \n\tisTypeInv   = " + isTypeInvariant +
			" \n\tmeasure     = " + (measureExp != null ? measureExp.getClass().getSimpleName() + ": " + measureExp.toString() : "null") +
			" \n\tisCurried   = " + isCurried +
			// avoid calling translate for TLD as it creates a record of what has been translated!  
			" \n\tpredef      = " + (predef  != null ? predef.getClass().getSimpleName()  + ": \n\t========\n\t" + predef.toString() + "\n\t========\n\t"  : "null") +
			" \n\tpostdef     = " + (postdef != null ? postdef.getClass().getSimpleName() + ": \n\t========\n\t" + postdef.toString() + "\n\t========\n\t" : "null") +
			" \n\tparamDefList= " + (paramDefinitionList != null ? paramDefinitionList.toString() : "") +//paramDefinitionList.getFlatDefinitionList().toString() : "null") +
			" \n\trecursive   = " + recursive +
			" \n\tisUndefined = " + isUndefined +
			" \n\tsynthetic   = " + isImplicitlyGeneratedUndeclaredSpecification() +
			" \n\tin		  = " + location.toString();
	
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

	protected TRDefinitionListList figureOutParamDefinitionList()
	{
		// result is null when say pre/post are explicitly defined
		TRDefinitionListList result = this.paramDefinitionList;
		if (result == null)
		{
			result = new TRDefinitionListList();
			TRFunctionType ftype = type;
			Iterator<TRPatternList> piter = paramPatternList.iterator();
			while (piter.hasNext())
			{
				TRPatternList plist = piter.next();
				TRDefinitionList defs = new TRDefinitionList();
				TRTypeList ptypes = ftype.parameters;
				Iterator<TRType> titer = ptypes.iterator();

				if (plist.size() != ptypes.size())
				{
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, "explicit function", name.toString(), plist.size(), ptypes.size());
				}
				else
				{
					for(TRPattern p : plist)
					{
						defs.addAll(p.getDefinitions(titer.next(), NameScope.LOCAL));
					}
				}
				// no need to check for duplicates; assumes it's okay in VDM 
				result.add(defs); 
				if (ftype.getResultType() instanceof TRFunctionType)	
				{
					ftype = (TRFunctionType)ftype.getResultType();
				}
			}
			TRNode.setup(result);
		}
		return result;
	}

	protected static TRFunctionType createUndeclaredSpecificationFunctionType(TRFunctionType type, boolean isCurried, TRSpecificationKind kind)
	{
		TRFunctionType result = null;
		switch (kind)
		{
			case PRE:
				result = type.getCurriedPreType(isCurried);
				assert result.getVDMType().equals(type.getVDMFunctionType().getCurriedPreType(true));
				break;
			case POST:
				result = type.getCurriedPostType(isCurried);
				assert result.getVDMType().equals(type.getVDMFunctionType().getCurriedPostType(true));
				break;

			case INV:
			case INIT:
				result = type.getInvariantType();
				assert result.getVDMType().equals(type.getVDMFunctionType().getPreType());
				break;

			case ORD:
			case EQ:
			case MAX:
			case MIN:
				result = type.getComparisonType();
				break;

			case MEASURE:
				result = type.getMeasureType(isCurried, type.getResultType());
				assert result.getVDMType().equals(type.getVDMFunctionType().getMeasureType(isCurried, type.getResultType().getVDMType()));
				break;

			case NONE:
			default:
				type.report(IsaErrorMessage.PLUGIN_NYI_2P, "undeclared specification function type", kind);
				result = type.getUnknownType();
		}
		assert result != null;
		return result;
	}

	protected static TRPatternListList createUndeclaredSpecificationParameters(TCNameToken name, TRPatternListList parameters, TRSpecificationKind kind)
	{
		TRPatternListList result = parameters.copy();
		if (kind == TRSpecificationKind.POST)
		{
			// add synthetic RESULT extra parameter to the last patternList
			// e.g., uncurried(x,y)== x + y, will lead to [[x,y]] then [[x,y,RESULT]]
			// 		 curried(x)(y) == x + y, will lead to [[x],[y]] then [[x],[y,RESULT]]
			result.lastElement().add(
				TRBasicPattern.identifier(
						parameters.getLocation(), 
						name.getResultName(parameters.getLocation()).toString()
				)
			);
		}
		return result;
	}

	/**
	 * Constructs corresponding definition for TRExplicitFunction of interest at the same location as this function definition. 
	 * @param kind
	 */
	protected static TRExplicitFunctionDefinition createUndeclaredSpecification(
		TCNameToken name, NameScope nameScope, boolean used, boolean excluded, TCNameList typeParams, 
		TRFunctionType type, boolean isCurried, TRPatternListList parameters, 
		TRDefinitionListList paramDefinitionList, TRSpecificationKind kind)
	{
		TCNameToken undeclaredName = null;
		switch (kind)
		{
			case PRE:
				//assert owner.predef == null && owner.precondition == null;
				undeclaredName = name.getPreName(name.getLocation());
				break;
			case POST:
				//assert owner.postdef == null && owner.postcondition == null;
				undeclaredName = name.getPostName(name.getLocation());
				break;			
			case INV:
				undeclaredName = name.getInvName(name.getLocation());
				break;
	    	case EQ:
				undeclaredName = name.getEqName(name.getLocation());
				break;
			case ORD:
				undeclaredName = name.getOrdName(name.getLocation());
				break;
			case MAX:
				undeclaredName = name.getMaxName(name.getLocation());
				break;
			case MIN:
				undeclaredName = name.getMinName(name.getLocation());
				break;
			case MEASURE:
				undeclaredName = name.getMeasureName(name.getLocation());
				break;
			case INIT:
				undeclaredName = name.getInitName(name.getLocation());
				break;
			case NONE:
				undeclaredName = name; 
				GeneralisaPlugin.report(IsaErrorMessage.ISA_INVALID_IMPLSPEC_2P, name.getLocation(), name.toString(), 
					VALID_IMPLICITLY_GENERATED_SPEC_KIND.toString());
				break;
			default:
				undeclaredName = name; 
				GeneralisaPlugin.report(IsaErrorMessage.PLUGIN_NYI_2P, name.getLocation(), 
					"implicit definition for missing specification " + kind.name(), name.toString());
				break;
		}
		assert undeclaredName != null;
		TRIsaVDMCommentList comments = null;//TRIsaCommentList.newComment(location, "implicitly constructed " + kind + " specification", false);
		
		TRFunctionType specType = TRExplicitFunctionDefinition.createUndeclaredSpecificationFunctionType(type, isCurried, kind);

		// Now create the undeclared specification as an explicit function without body (i.e. no user defined stuff).
		// The translator will then take this into account as the "missing" (now found) specification definition, and
		// treat it as if the user has given it (e.g. equivalent to as if the user had typed "pre true", "post true");  
		TRExplicitFunctionDefinition result = TRExplicitFunctionDefinition.newExplicitFunctionDefinition(
					comments,										//  LexCommentList comments,								
					null,											// 	TCAnnotationList annotations,
					undeclaredName,									// 	TCNameToken name,
					nameScope, used, excluded,						//  extra TRDefinition parameters, 
					typeParams,										// 	TCNameList typeParams, 
					specType,										// 	TRFunctionType type,
					TRExplicitFunctionDefinition.createUndeclaredSpecificationParameters(name, parameters, kind),	// 	TRPatternListList parameters, 
					null,											// 	TRExpression body,
					null,											// 	TRExpression precondition,
					null,											// 	TRExpression postcondition, 
					false,											// 	boolean typeInvariant, 
					null, 											// 	TRExpression measureExp,
					isCurried,								// 	boolean isCurried, 
					null,											// 	TRExplicitFunctionDefinition predef,
					null,											// 	TRExplicitFunctionDefinition postdef,
					paramDefinitionList,						// 	TRDefinitionListList paramDefinitionList,
					false,											// 	boolean recursive,
					false, 											// 	boolean isUndefined
					specType.getResultType(),						// actual type //@NB is this right here? 
					specType.getResultType()						// expected type
					);
		return result;
	} 
	
	@Override
	protected String paramsInvTranslate(TRSpecificationKind kind)
	{
		StringBuilder paramsStr = new StringBuilder();

		// will this alone sort out renamed typesm but has to be copied
		//type.parameters.setAtTopLevelDefinition(!kind.equals(TRSpecificationKind.INV));
		TRTypeList parameterscp = type.parameters.copy(!kind.equals(TRSpecificationKind.INV));
		 
		if (isCurried)
		{
			// if curried there are more names than parameters on the first entry
			if (type.getResultType() instanceof TRFunctionType)
			{
				assert !paramPatternList.isEmpty();

				// get the curried parameters
				List<List<String>> curriedVarNames = paramPatternList.varNameTranslate();
				ListIterator<List<String>> iter = curriedVarNames.listIterator();

				// translate the outmost parameters first
				List<String> varNames = iter.next();
				paramsStr.append(parameterscp.invTranslate(varNames));
				// get the innermost parameters next
				TRType next = type.getResultType();
				while (next instanceof TRFunctionType && iter.hasNext())
				{
					// copy it for the case where we have to remove RESULT; remove RESULT from parameters as it will be treated in the next.result 
					varNames = new Vector<String>(iter.next());
					if (kind == TRSpecificationKind.POST)
					{
						String resultName = name.getResultName(location).toString();
						boolean removed = varNames.remove(resultName);
						if (!removed)
						{
							warning(IsaWarningMessage.VDMSL_MISSING_RESULT_IN_POST_1P, resultName);
						}
					}
					paramsStr.append(parameterscp.getFormattingSeparator());
					paramsStr.append(parameterscp.getInvTranslateSeparator());
					paramsStr.append(((TRFunctionType)next).parameters.invTranslate(varNames));
					next = ((TRFunctionType)next).getResultType();
				}

				if (kind == TRSpecificationKind.POST && Vdm2isaPlugin.linientPost)
				{
					warning(IsaWarningMessage.PLUGIN_NYI_2P, "linient post condition for curried definitions", name.toString());
				}
			} 
			else
			{
				// should never happen for a type checked VDM?
				report(IsaErrorMessage.VDMSL_INVALID_CURRIED_FCNTYPE_2P, this.name.toString(), this.type.getResultType().getClass().getSimpleName());
			}
		}
		else
		{
			// if not curried flat list and translate
			List<String> varNames = paramPatternList.flatVarNameTranslate();

			if (kind.equals(TRSpecificationKind.MIN) || kind.equals(TRSpecificationKind.MAX))
			{
				paramsStr.append(IsaToken.LPAREN.toString());
				paramsStr.append(IsaToken.IF.toString());
				paramsStr.append(IsaToken.SPACE.toString());
			}

			// for TRNamedType for records, we need to adjust the inner call to the inv_R of original record,
			// rather than explicitly redefining inv_R! Fix parameterscp in TRTypeDEfinition.
			paramsStr.append(parameterscp.invTranslate(varNames));

			if (kind.equals(TRSpecificationKind.MIN) || kind.equals(TRSpecificationKind.MAX))
			{
				paramsStr.append(IsaToken.SPACE.toString());
				paramsStr.append(IsaToken.THEN.toString());
				paramsStr.append(getFormattingSeparator()+"\t");
			}
			else if (kind.equals(TRSpecificationKind.POST) && Vdm2isaPlugin.linientPost)
			{
				// include "pre_f x =>" within post (i.e. ignore RESULT from varNames) 
				assert name.getName().startsWith("post_");
				String preCall = "pre_" + name.getName().substring("post_".length()) + " ";
				String resultName = name.getResultName(location).toString();
				boolean removed = varNames.remove(resultName);
				if (!removed)
				{
					warning(IsaWarningMessage.VDMSL_MISSING_RESULTVAR_1P, resultName);
				}
				// transform "[x,y]" into "x y", "[x]" into "x", "[]" into ""
				String varList = varNames.toString().replace(',', ' ');
				assert varList.length() >= 2;
				paramsStr = new StringBuilder(IsaToken.parenthesise(
						preCall + varList.substring(1, varList.length()-1) + " " +
						IsaToken.IMPLIES.toString() + " " + // getFormattingSeparator() +
						paramsStr.toString()));
				//TODO this will possibly create "messy" formatting if separator includes \n! 
			}
		}
		return paramsStr.toString();
	}

	@Override
	protected String translateParameters()
	{
		// even for union pattern translate, we can "abosrb" the parameter name within the union case selection
		// i.e. parameter name can be the same as the selected union parameter name without capturing it. 
		boolean oldFreshness = paramPatternList.setDummyFreshness(false, true);
		String fcnParams   = paramPatternList.translate();
		paramPatternList.setDummyFreshness(false,true);//oldFreshness, true);
		return fcnParams;
	}

	@Override
	protected boolean parametersNeedsPatternContext()
	{
		return paramPatternList.needsPatternContext();
	}
		
	@Override
	protected String translateParametersPatternContext()
	{
		String fmtsep = paramPatternList.setFormattingSeparator("\n\t\t\t");
		String result = paramPatternList.patternContextTranslate(null);
		paramPatternList.setFormattingSeparator(fmtsep);
		return result;
	}

	@Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseExplicitFunctionDefinition(this, arg);
	}

	public TRPatternListList getParameters()
	{
		return paramPatternList;
	}

	public TRExpressionList getParametersExpressionList()
	{
		return TRExpressionList.newExpressionList(getParameters().getFlatPatternList(), getType().parameters);
	}


	@Override
	public boolean hasUnionTypes()
	{
		return paramDefinitionList.hasUnionTypes();
	}

	@Override
	public String unionTypesTranslate(TRExpression unionBody, TRUnionContext innerContext)
	{
		StringBuilder sb = new StringBuilder();
		sb.append(getFormattingSeparator());
		sb.append(IsaToken.comment(IsaInfoMessage.ISA_UNION_TYPE_PROJECTION.toString(), getFormattingSeparator()));
		String fmtsep = paramDefinitionList.setFormattingSeparator("\n\t\t\t");
		sb.append(paramDefinitionList.unionTypesTranslate(body, innerContext));
		paramDefinitionList.setFormattingSeparator(fmtsep);
		return IsaToken.parenthesise(sb.toString());
	}

	public static final TRExplicitFunctionDefinition newExplicitFunctionDefinition(
		TRIsaVDMCommentList comments,
		TRAnnotationList annotations,
		TCNameToken name,
		NameScope nameScope, 
		boolean used, 
		boolean excluded,
		TCNameList typeParams, 
		TRFunctionType type,
		TRPatternListList paramPatternList, 
		TRExpression body,
		TRExpression precondition,
		TRExpression postcondition, 
		boolean typeInvariant, 
		TRExpression measureExp,
		boolean isCurried, 
		TRExplicitFunctionDefinition predef,
		TRExplicitFunctionDefinition postdef,
		TRDefinitionListList paramDefinitionList,
		boolean recursive,
		boolean isUndefined,
		TRType actualResult,
		TRType expectedResult)
	{
		return TRExplicitFunctionDefinition.newExplicitFunctionDefinition(
			new TCExplicitFunctionDefinition(
				annotations != null ? annotations.getVDMAnnotationList() : null, 
				TCAccessSpecifier.DEFAULT, 
				name, 
				typeParams, 
				type != null ? type.getVDMFunctionType() : null, 
				paramPatternList != null ? paramPatternList.getVDMPatternListList() : null, 
				body != null ? body.getVDMExpr() : null, 
				precondition != null ? precondition.getVDMExpr() : null, 
				postcondition != null ? postcondition.getVDMExpr() : null, 
				typeInvariant, 
				measureExp != null ? measureExp.getVDMExpr() : null), 
			comments, annotations, name, nameScope, used, excluded, typeParams, type, 
			paramPatternList, body, precondition, postcondition, typeInvariant, measureExp, 
			isCurried, predef, postdef, paramDefinitionList, recursive, isUndefined, 
			actualResult, expectedResult);
	}

	public static final TRExplicitFunctionDefinition newExplicitFunctionDefinition(TCExplicitFunctionDefinition definition, 
		TRIsaVDMCommentList comments,
		TRAnnotationList annotations,
		TCNameToken name,
		NameScope nameScope, 
		boolean used, 
		boolean excluded,
		TCNameList typeParams, 
		TRFunctionType type,
		TRPatternListList paramPatternList, 
		TRExpression body,
		TRExpression precondition,
		TRExpression postcondition, 
		boolean typeInvariant, 
		TRExpression measureExp,
		boolean isCurried, 
		TRExplicitFunctionDefinition predef,
		TRExplicitFunctionDefinition postdef,
		TRDefinitionListList paramDefinitionList,
		boolean recursive,
		boolean isUndefined,
		TRType actualResult,
		TRType expectedResult)
	{
		TRExplicitFunctionDefinition result = new TRExplicitFunctionDefinition(definition, comments, annotations, name, nameScope, used, excluded, typeParams, type, paramPatternList, body, precondition, postcondition, typeInvariant, measureExp, isCurried, predef, postdef, paramDefinitionList, recursive, isUndefined, actualResult, expectedResult);
		TRNode.setup(result);
		return result;
	}

	public static final TRApplyExpression newExplicitFunctionDefinitionCall(
		TRExplicitFunctionDefinition edef)
	{
		return TRExplicitFunctionDefinition.newExplicitFunctionDefinitionCall(
			edef, edef.getParametersExpressionList());
	} 

	public static final TRApplyExpression newExplicitFunctionDefinitionCall(
		TRExplicitFunctionDefinition edef, TRExpressionList args)
	{
		assert !edef.isCurried;
		return TRApplyExpression.newApplyExpression(
			edef.name.toString(), args, 
			edef.type.getResultType());
	} 

}
