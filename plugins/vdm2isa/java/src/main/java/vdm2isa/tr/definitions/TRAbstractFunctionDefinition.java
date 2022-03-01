package vdm2isa.tr.definitions;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaItem;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.visitors.TRFunctionCallFinder;
import vdm2isa.tr.patterns.TRUnionContext;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRType;

/**
 * Initially we thought that we would need separate hierarchy between 
 * implicit and explicit function definitions. Yet, it's possible to cast
 * the parameter structure from implicit to explicit easily. 
 * 
 * Will keep the hierarchy for operations and for separation of concerns.  
 */
public abstract class TRAbstractFunctionDefinition extends TRDefinition 
{
	private static final long serialVersionUID = 1L;

	/**
	 * Only pre/post/inv can be implicitly generated when the user doesn't explicitly define them
	 * yet we must check the related (sub-)type invariants. Equality is added also because of 
	 * VDM record equality abstraction (":-"), which will require an implicit definition in Isabelle
	 * about record equality.   
	 */
	//TODO should this be extended to other bits? Probably not! 
	protected static final Set<TRSpecificationKind> 
		VALID_IMPLICITLY_GENERATED_SPEC_KIND = new HashSet<TRSpecificationKind>( 
			Arrays.asList(TRSpecificationKind.PRE, 
						TRSpecificationKind.POST, 
						TRSpecificationKind.INV, 
						TRSpecificationKind.EQ,
						TRSpecificationKind.ORD,
						TRSpecificationKind.MIN,
						TRSpecificationKind.MAX));

	//private final TCNameToken name;
	protected final TCNameList typeParams;
	protected TRFunctionType type;
	protected final TRExpression body;
	protected final TRExpression precondition;
	protected final TRExpression postcondition;
	protected final TRExpression measureExp;
	protected final boolean recursive;
	protected final boolean isUndefined;
	/**
	 * This is the type of body
	 */
	protected final TRType actualResult;

	protected TRExplicitFunctionDefinition predef;
	protected TRExplicitFunctionDefinition postdef;
	protected TRSpecificationKind implicitSpecificationKind;

	protected TRAbstractFunctionDefinition(TCDefinition definition, 
			TRIsaVDMCommentList comments,
			TRAnnotationList annotations,
			TCNameToken name,
			NameScope nameScope, 
			boolean used, 
			boolean excluded,
			TCNameList typeParams, 
			TRFunctionType type,
			TRExpression body,
			TRExpression precondition,
			TRExpression postcondition, 
			TRExpression measureExp,
			TRExplicitFunctionDefinition predef,
			TRExplicitFunctionDefinition postdef,
			boolean recursive,
			boolean isUndefined,
			TRType actualResult
            )
	{	
		// get the name location, given definition might be null for synthetic cases. 
		super(definition, name != null ? name.getLocation() : LexLocation.ANY, comments, annotations, name, nameScope, used, excluded);
		this.typeParams = typeParams;
		this.type = type;
		//this.paramPatternList = paramPatternList;
		// null body for case where user does not define the pre/post explicitly but we need its TRDefinition for implicit invariant type checks?
		this.body = body;
		this.precondition = precondition;
		this.postcondition = postcondition;
		//this.isTypeInvariant = typeInvariant;
		this.measureExp = measureExp;
		//this.isCurried = isCurried;
		this.predef = predef;
		this.postdef = postdef;
		//this.paramDefinitionList = paramDefinitionList;
		this.recursive = recursive;
		this.isUndefined = isUndefined;
		this.actualResult = actualResult;
		//this.expectedResult = expectedResult;
		this.implicitSpecificationKind = TRSpecificationKind.NONE;
		//setLocal(false); //Leave to name scope? // LetDefExpression to set this to true if/when needed
    }

    protected abstract TRExplicitFunctionDefinition 
        createUndeclaredSpecification(TRSpecificationKind kind);

	@Override
	public void setup()
	{
		super.setup();
		assert this.type != null && this.name != null ; //&& this.paramPatternList != null; 
		this.implicitSpecificationKind = impliSpecificationDefinition();

		// check stuff is consistent to expectations
		if ((precondition != null && predef == null) || (precondition == null && predef != null))
			report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_2P, "Explicit function", "precondition");
		if ((postcondition != null && postdef == null) || (postcondition == null && postdef != null))
			report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_2P, "Explicit function", "postcondition");
		
		// if the body is null, this is an implicitly generated TRExplicitFunctionDefinition,
		// which *must* be of a specific specification kind. 
        // unless this class is an implicit specification, which might not have body
		if (isImplicitlyGeneratedUndeclaredSpecification() && 
            !isImplicitFunction() && 
			!VALID_IMPLICITLY_GENERATED_SPEC_KIND.contains(implicitSpecificationKind))
		{
			report(IsaErrorMessage.ISA_INVALID_IMPLSPEC_2P, name.toString(),
				VALID_IMPLICITLY_GENERATED_SPEC_KIND.toString());
		}

		// only create undeclared specification for those who need it: when precondition/predef are null but
		// have body that's the case (f: nat -> nat f(x) == x; no pre/post); which will then create it, but that
		// in itself won't have pre/predef and no body! So if not guarded here, would loop! 
		if (!isImplicitlyGeneratedUndeclaredSpecification() && 
            !isSpecificationDefinition())
		{
			// user defined pre/posts will have TRExplicitFunctionDefinitions with precondition==null and prefef==null and body !=null!
			if (this.precondition == null && this.predef == null)
				this.predef = createUndeclaredSpecification(TRSpecificationKind.PRE); 
			if (postcondition == null && postcondition == null)
				this.postdef = createUndeclaredSpecification(TRSpecificationKind.POST); 
		}
		
		// updates specification for any generic parameters
		updateSpecificationGenericParameters();
				
		// setup various bits later, as some might get created above.
		TRNode.setup(type, body, precondition, postcondition, measureExp, predef, postdef, actualResult);

		setFormattingSeparator("\n\t\t");
		
		// if (implicitSpecificationKind in {PRE,POST,NONE} => local) then print (i.e. no top-level print please)
		if (!Arrays.asList(
				TRSpecificationKind.PRE 
				,TRSpecificationKind.POST
				,TRSpecificationKind.NONE
				,TRSpecificationKind.INV
				,TRSpecificationKind.EQ
				,TRSpecificationKind.ORD
				,TRSpecificationKind.MAX
				,TRSpecificationKind.MIN
				,TRSpecificationKind.MEASURE
			).contains(implicitSpecificationKind)
			|| isLocal()
			//|| true
			) 
			System.out.println(toString());
	} 

	protected boolean hasTypeParameters()
	{
		return typeParams != null && !typeParams.isEmpty();
	}

	/**
	 * Update specification generic types to cater for type invariant calls passed as boolean valued functions on 
	 * each of the involved generic parameters. 
	 */
	protected abstract void updateSpecificationGenericParameters();

	/**
	 * Determines wether this TRExplicitFunctionDefinition is one of those constructed by the typechecker.
	 * Depending on which kind (if any), then translation has to take into account different considerations. 
	 * Decision is based on VDM naming conventions (e.g., pre_, post_, inv_, ord_, eq_, etc.).
	 * @return the kind of implicit specification associated with this definition
	 */
	protected final TRSpecificationKind impliSpecificationDefinition()
	{
		TRSpecificationKind result = TRSpecificationKind.NONE;

		// presumes Settings.release = VDM_10 and dialect = VDMSL. This is checked by GeneralisaPlugin.run anyhow
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
	 * For situations where the user does not define pre/posts, like in 
	 * 		f: nat -> nat
	 * 		f(x) == x;
	 * We still have to translate a pre/post_f calls to check type invariants. 
	 * Implicitily generated pre/post TRExplicitFunctionDefinition *must* have null body and pre/post/inv names!
	 *  
	 * @return true when pre/post are being implicitly generated
	 */
	public boolean isImplicitlyGeneratedUndeclaredSpecification()
	{
        // can't have the instance check here as this will confuse negated cases
        //&& !(this instanceof TRImplicitFunctionDefinition);//&& getVDMDefinition() == null;
		return body == null; 
	}

    public abstract boolean isImplicitFunction();

    /**
	 * If inferred specification kind is not NONE, it means this is a TRExplicitFunctionDeclaration for either
	 * user defined specification (e.g., pre/post etc.) or implicitly generated undeclared specification 
	 * (e.g., missing pre/post checks on input types etc.). Testing this is important to avoid looping (e.g. pre_post_pre_f).
	 * @return
	 */
	protected boolean isSpecificationDefinition()
	{
		return implicitSpecificationKind != TRSpecificationKind.NONE;
	}

	protected abstract String paramsInvTranslate(TRSpecificationKind kind);

	/**
	 * Implicit checks for pre/post. They are similar with minor differences, so parameterised here to avoid repetition
	 * at possibly the cost of making it slightly harder to follow. 
	 * @param kind
	 * @return
	 */
	//TODO should/could this be pushed to say TRType tree for the implicitly defined checks belonging there? Would be more elegant,
	//	   but would demand an extra TRExplicitFunctionDefinition? Hum... Not sure.
	protected String translateImplicitChecks(TRSpecificationKind kind)
	{
		StringBuilder fcnBody = new StringBuilder();
		
		// constant function without explicit pre gets just True
		if (kind == TRSpecificationKind.PRE && isConstantFunction() && isImplicitlyGeneratedUndeclaredSpecification())
		{
			// undeclared pre of constant functions get "True" 
			fcnBody.append(IsaToken.TRUE.toString());
		}	
		else if (VALID_IMPLICITLY_GENERATED_SPEC_KIND.contains(kind))
		{
			// pre/post checks on input (including RESULT for post) types
			// there is no need to check type.result type because for PRE/POST defs that's always bool! 
			fcnBody.append(getFormattingSeparator());
			fcnBody.append(IsaToken.comment(IsaInfoMessage.VDM_IMPLICITLY_DEFINED_INV_2P.format(
				isImplicitlyGeneratedUndeclaredSpecification() ? "undeclared" : "", name.toString()), getFormattingSeparator()));
			
			// translate the parameters taking currying into account!
			//String old = parameterscp.setFormattingSeparator(getFormattingSeparator()); //uncomment if want to see differently "shaped" output
			String paramsStr = paramsInvTranslate(kind);
			//parameterscp.setFormattingSeparator(old);
			fcnBody.append(paramsStr);

			// System.out.println("Implicit translation with: " + 
			// 	"\n\t params = " + parameters.getFlatPatternList().size() + 
			// 	"\n\t types  = " + parameterscp.size() +
			// 	"\n\t vars   = " + varNames.toString() +
			// 	"\n\t" + toString());

			// if there is a user defined body, add the missing conjunction for it, so long as not pre of constant function! 
			if (!isConstantFunction() && !isImplicitlyGeneratedUndeclaredSpecification() &&
				!kind.equals(TRSpecificationKind.MIN) && !kind.equals(TRSpecificationKind.MAX))
			{
				// " \<and>"
				fcnBody.append(type.parameters.getFormattingSeparator());
				fcnBody.append(type.parameters.getInvTranslateSeparator());
			}
		}
		return fcnBody.toString();
	}

	/**
	 * Add any top-level isa comment that inner expressions might want, if we have an explicitly defined body. 
	 */
	@Override
    public String tldIsaComment()
    {
        return body != null ? tldIsaCommentTranslate(body) : super.tldIsaComment();
    }

    protected abstract String translateParameters();

    protected abstract boolean parametersNeedsPatternContext();

    protected abstract String translateParametersPatternContext();

	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		
		// add any comments and annotations
		sb.append(super.translate());
		
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

		String old = getFormattingSeparator();
		
       	// make sure no union types at TLD
		type.checkForUnionTypes();

		// translate the explicit function definition taking into consideration TRSpecificationKind
		// constant functions are translated as constant definitions (not abbreviations) with null inType string.		
		String fcnName     = name.getName();
		String fcnInType   = isConstantFunction() ? null : type.parameters.translate();
		String fcnOutType  = type.getResultType().translate();
		
        String fcnParams = translateParameters();

		StringBuilder fcnBody = new StringBuilder();
		switch (implicitSpecificationKind)
		{
			// ready; do nothing else
			case NONE:
				break;

			// include implicit function parameters invariant checks
			case PRE:
			case POST:
			case INV:
			case EQ:
			case ORD:
				fcnBody.append(translateImplicitChecks(implicitSpecificationKind));	
				break;

			case MAX:
			case MIN:
				fcnBody.append(translateImplicitChecks(implicitSpecificationKind));
				break;
			case MEASURE:
				// no implicit checks, given these return non-boolean results!
				break;
			case INIT:
				break;			
		}
		
		// user defined specification body translation, take record / union into account
		// implicitly generated undeclared specifications have no body
		if (!isImplicitlyGeneratedUndeclaredSpecification())
		{
			// include any record patterns within a single let definition for all of them
			// but only if there is user body, given the implicit checks rely on TRecordType's own structuring. 
			// e.g. f(mk_R(x,y), mk_R(z,w)) == e becomes 
			//		let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0); z = (x\<^sub>R dummy1); w = (y\<^sub>R dummy1) in e  
			boolean hasPatternContext = parametersNeedsPatternContext();
			if (hasPatternContext)
			{
				fcnBody.append(getFormattingSeparator());
				fcnBody.append(IsaToken.comment(IsaInfoMessage.ISA_PATTERN_CONTEXT_1P.format("function parameters"), getFormattingSeparator()));
				fcnBody.append(IsaToken.LPAREN.toString());
				fcnBody.append(translateParametersPatternContext());
			}
			// include the user declared body after including implicit considerations
			fcnBody.append(getFormattingSeparator());
			fcnBody.append(IsaToken.comment(IsaInfoMessage.VDM_EXPLICIT_FUNCTION_USER_DEFINED_BODY_1P.format(name.toString()), getFormattingSeparator()));
			fcnBody.append(tldIsaComment());

			if (hasUnionTypes())
			{
				//TODO union types with with type parameters won't add extended check; leave it for now 
				fcnBody.append(unionTypesTranslate(body, null));
			}
			else
			{
                assert body != null;
				String bodyStr = body.translate();
				if (hasTypeParameters())
				{
					//TODO should this be added everywhere? Not for now. 
					StringBuilder paramTypeCheckStr = new StringBuilder();
					paramTypeCheckStr.append(name.getPostName(location).toString());
					paramTypeCheckStr.append(IsaToken.SPACE.toString());
					paramTypeCheckStr.append(fcnParams);
					paramTypeCheckStr.append(IsaToken.SPACE.toString());
					paramTypeCheckStr.append(IsaToken.parenthesise(bodyStr));
					
					fcnBody.append(IsaToken.comment(IsaInfoMessage.VDM_EXPLICIT_FUNCTION_IMPLICIT_PARAMETER_TYPE_INV_CHECK_1P.format(name.toString()), getFormattingSeparator()));
					fcnBody.append(body.extendedCheckTranslate(paramTypeCheckStr.toString()));
				}
				else
				{
					fcnBody.append(bodyStr);
				}
			}

			if (hasPatternContext)
			{
				// let expression requires parenthesis 
				fcnBody.append(IsaToken.RPAREN.toString());
			}
		}

		switch (implicitSpecificationKind)
		{
			// ready; do nothing else
			case NONE:
			case PRE:
			case POST:
			case INV:
			case EQ:
			case ORD:
				break;

			// these are not boolean typed, hence need an else for undefined in case type test fails
			case MAX:
			case MIN:
				// add the "rest" of the implicit check
				fcnBody.append(getFormattingSeparator()+"\t");
				fcnBody.append(IsaToken.ELSE.toString());
				fcnBody.append(getFormattingSeparator()+"\t");
				fcnBody.append(IsaToken.UNDEFINED.toString());
				fcnBody.append(IsaToken.RPAREN.toString());
				break;

			case MEASURE:
				// no implicit checks, given these return non-boolean results!
				break;
			case INIT:
				break;			
		}

        // there are four cases to consider:
        // 1) implicit function without body = don't issue definition (i.e. user defined implicit without body)
        // 2) implicit function with a body  = issue definition (i.e. user defined implicit with explicit body)
        // 3) explicit function without body = issue definition (i.e. implicitly defined pre/post)
        // 4) explicit function with a body  = issue definition (i.e. user defined explicit function or pre/post)
        if (!(isImplicitFunction() && getBody() == null))
        {
            // translate definition according to discovered (possibly implicit) considerations. fcnInType is null for constant functions
            sb.append(IsaTemplates.translateDefinition(
                //TODO not yet ideal, given multiple equations are possible, but okay for now. 
                recursive ? IsaItem.FUNCTION : IsaItem.DEFINITION,
                this.getLocation(), fcnName, fcnInType, fcnOutType, fcnParams, fcnBody.toString(), isLocal()));
        }

        String lemmasDefs = translateDefLemmas();//t.getDefLemmas().toString().replace(',', ' ').replaceAll("\\[", "").replaceAll("\\]","");
        //sb.append(IsaTemplates.translateLemmasDefinition(location, IsaToken.INV.toString() + name.toString(), lemmasDefs));
        //sb.append("\n");

		setFormattingSeparator(old);

		return sb.toString();
	}

    public String translateDefLemmas()
	{
		StringBuilder sb = new StringBuilder();

   		// add lemmas statement!
		Map<TRSpecificationKind, TCNameSet> callMap = this.getCallMap();
		List<String> lemmaNames = new Vector<String>(3);//NONE+PRE+POST vs INV+EQ+ORD?
		for(Map.Entry<TRSpecificationKind, TCNameSet> entry : callMap.entrySet())
		{
            // sb.append(s);
			// // add "_def" to all strings without it. 
			// if (!s.endsWith(IsaToken.ISAR_DEF.toString()) && 
			// 	!s.endsWith(IsaToken.ISAR_LEMMAS_DEFS.toString()))
			// {
			// 	sb.append(IsaToken.ISAR_DEF.toString());
			// }
			// sb.append(IsaToken.SPACE.toString());

			switch (entry.getKey())
			{
				case NONE:
				case PRE:
				case POST:
				case INV:
				case EQ:
				case ORD:
					break;

				// do nothing cases
				//case MEASURE:
				//case INIT:
				default:
					break;
			}
		}
		return sb.toString();
	}

	// @Override
	// public String setFormattingSeparator(String sep)
	// {
	// 	// if (getFormattingSeparator() != null && sep != null && getFormattingSeparator().equals("\n\t\t") && !sep.equals("\n\t\t"))
	// 	// {
	// 	// 	Throwable t = new Throwable(); 
	// 	// 	System.out.println("Change format sep from " + getFormattingSeparator().length() + getFormattingSeparator() + " to " + sep.length() + sep); 
	// 	// 	t.printStackTrace();
	// 	// }
	// 	return super.setFormattingSeparator(sep);
	// }

	@Override
	public IsaToken isaToken() {
		return IsaToken.FUN;
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

	@Override
	public abstract boolean hasUnionTypes();

	@Override
	public abstract String unionTypesTranslate(TRExpression unionBody, TRUnionContext innerContext);

	@Override
	public Map<TRSpecificationKind, TCNameSet> getCallMap()
	{
		TRFunctionCallFinder finder = new TRFunctionCallFinder();
		Map<TRSpecificationKind, TCNameSet> found = super.getCallMap();//new HashMap<TRSpecificationKind, TCNameSet>();

		if (body != null)
		{
			TCNameSet foundPerKind = new TCNameSet();
			foundPerKind.addAll(body.apply(finder, null));
			if (!foundPerKind.isEmpty())
				found.put(TRSpecificationKind.NONE, foundPerKind);
		}
		
		if (predef != null && !predef.isImplicitlyGeneratedUndeclaredSpecification())
		{
			assert predef.getBody() != null;
			TCNameSet foundPerKind = new TCNameSet();
			foundPerKind.addAll(predef.getBody().apply(finder, null));
			if (!foundPerKind.isEmpty())
				found.put(TRSpecificationKind.PRE, foundPerKind);
		}
		
		if (postdef != null && !postdef.isImplicitlyGeneratedUndeclaredSpecification())
		{
			assert postdef.getBody() != null;
			TCNameSet foundPerKind = new TCNameSet();
			foundPerKind.addAll(postdef.getBody().apply(finder, null));
			if (!foundPerKind.isEmpty())
				found.put(TRSpecificationKind.POST, foundPerKind);
		}

		if (measureExp != null)
		{
			TCNameSet foundPerKind = new TCNameSet();
			foundPerKind.addAll(measureExp.apply(finder, null));
			if (!foundPerKind.isEmpty())
				found.put(TRSpecificationKind.MEASURE, foundPerKind);
		}

		return found;
	}
}
