package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitOperationDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaItem;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRStatement;
import vdm2isa.tr.patterns.TRPatternList;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.patterns.TRRecordPattern;
import vdm2isa.tr.types.TROperationType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeList;
import vdm2isa.tr.types.TRTypeSet;


public class TRExplicitOperationDefinition extends TRExplicitFunctionDefinition {

    private static final long serialVersionUID = 1L;
	// public TROperationType type;
	public final TRTypeList unresolved;
	public final TRPatternList parameterPatterns;
	// public final TRExpression precondition;
	// public final TRExpression postcondition;
	//public final TRStatement body;

	// public TRExplicitFunctionDefinition predef;
	// public TRExplicitFunctionDefinition postdef;
	public TRDefinitionList paramDefinitions;
	public TRStateDefinition state;

	private TRType actualResult = null;
	public boolean isConstructor = false;
	public TRTypeSet possibleExceptions = null;
    //public TRPatternListList paramPatternList;

    public TRExplicitOperationDefinition(
        TCDefinition definition,
        TRIsaVDMCommentList comments,
        TRAnnotationList annotations,
        TCNameToken name,
        NameScope nameScope, 
        boolean used, 
        boolean excluded,

        // For this class
        TRPatternList parameterPatterns,
        TRDefinitionList paramDefinitions,
        TROperationType type,
        TRTypeList unresolved,
        TRStatement body,
        TRExpression precondition,
        TRExpression postcondition, 
        TRExplicitFunctionDefinition predef,
        TRExplicitFunctionDefinition postdef,
        TRStateDefinition state,
        boolean isConstructor,
        boolean ignore
    ) {
        //super(definition, name != null ? name.getLocation() : LexLocation.ANY, comments, annotations, name, nameScope, used, excluded);
        super(
            definition, 
			comments,
			annotations,
			name,
			nameScope, 
			used, 
			excluded,
			null, // typeParams
			type,
			TRPatternListList.newPatternListList(parameterPatterns),  // paramPatternList
			body, // body
			precondition,
			postcondition, 
			false, // typeInvariant
			null,
			false, 
			predef,
			postdef,
			null, // paramDefinitionList
			false,
			body != null ? false : true,
			type.getInnerType(),
			type.getInnerType(), 
            false
        );
        this.parameterPatterns = parameterPatterns;
        this.paramDefinitions = paramDefinitions;
        // this.type = type;
		this.unresolved = unresolved;

        // this.precondition = precondition;
        // this.postcondition = postcondition;
        // this.predef = predef;
        // this.postdef = postdef;
        this.state = state;
        this.isConstructor = isConstructor;

    }

    public TRExplicitOperationDefinition(
        TCExplicitOperationDefinition definition,
        TRIsaVDMCommentList comments,
        TRAnnotationList annotations,
        TCNameToken name,
        NameScope nameScope, 
        boolean used, 
        boolean excluded,

        // For this class
        TRPatternList parameterPatterns,
        TRDefinitionList paramDefinitions,
        TROperationType type,
        TRTypeList unresolved,
        TRStatement body,
        TRExpression precondition,
        TRExpression postcondition, 
        TRExplicitFunctionDefinition predef,
        TRExplicitFunctionDefinition postdef,
        TRStateDefinition state,
        boolean isConstructor
    ) {
        this(
            (TCDefinition) definition,
            comments,
            annotations,
            name,
            nameScope, 
            used, 
            excluded,

            // For this class
            parameterPatterns,
            paramDefinitions,
            type,
            unresolved,
            body, // TRStatement body,
            precondition,
            postcondition, 
            predef,
            postdef,
            state,
            isConstructor,
            false
        );
    }

    @Override
    public void setup(){
        paramPatternList = TRPatternListList.newPatternListList(TRPatternListList.newPatternListList(parameterPatterns, TRPatternList.newPatternList(
            TRRecordPattern.RecordPatternGenerator(TRStateDefinition.state.recordType,TRStateDefinition.state.recordType.location))).getFlatPatternList());
        paramPatternList.setSemanticSeparator(IsaToken.SPACE.toString());
        super.setup();
        setFormattingSeparator("\n\t");
        TRNode.setup(predef, postdef, precondition, postcondition, type, state, paramDefinitions, parameterPatterns, unresolved);
    }

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseExplicitOperationDefinition(this, arg);
    }

    @Override
	protected boolean parametersNeedsPatternContext()
	{
		return true;
	}

    // @Override
    public String t() {
        StringBuilder sb = new StringBuilder();
        // translate the precondition
		if (predef != null) 
		{
            //System.out.println(predef.toString());
            //System.out.println(precondition.toString());
			sb.append(predef.translate());
			sb.append("\n");
        }
		// } else {
        //     //@JK
        //     // I think it needs to have state ammended to parameters and the parameterPatterns
        //     // and the return type in type and paramaters in type also ammended to remove the 
        //     // void and add state. Otherwise it is adding a lot of difficulty to the code gen.
        //     // Is that possible to generate new type and params with the changes?
        //     // I am really confused as to why it is not generating any body at all and think it 
        //     // has something to do with the missing typeParams but I don't know how to find or make them

        //     TRFunctionType invType = TRFunctionType.getInvariantType(type);
        //     TRPatternListList parameters = TRPatternListList.newPatternListList(parameterPatterns, TRPatternList.newPatternList(state.invPattern));
            
        //     predef =  TRExplicitFunctionDefinition.createUndeclaredSpecification(
        //         name, nameScope, used, excluded, null, invType, false , parameters, 
        //         new TRDefinitionListList(), TRSpecificationKind.PRE
        //     );

        //     //System.out.println(predef.toString());

        //     sb.append(predef.translate());
		// 	sb.append("\n");
        // }

		// translate the postcondition
		if (postdef != null)
		{
			sb.append(postdef.translate());
			sb.append("\n");
		}

        sb.append(super.translate());
        
        //@JK
        // Replaces with newly definied parameters and parameter patterns that have the state included?
        String fcnName     = name.getName();
        String stateType = state.name.toString();
		String fcnInType   = type.parameters.translate();
		String fcnOutType  = type.getResultType().translate();
        //(type.getResultType() instanceof TRVoidType) ? type.getResultType() : type.getResultType().translate() + IsaToken.SPACE.toString() + IsaToken.TFUN.toString() + IsaToken.SPACE.toString() + stateType;
		
        //@JK
        //This is a hack cause I need to add an extra parammeter pattern
        String fcnParams = tp();//+ IsaToken.SPACE.toString() + stateType;

        sb.append(IsaTemplates.translateDefinition(
                //TODO not yet ideal, given multiple equations are possible, but okay for now. 
                false ? IsaItem.FUNCTION : IsaItem.DEFINITION,
                this.getLocation(), fcnName, fcnInType, fcnOutType, fcnParams, 
                "Empty body", isLocal()));
        
        return sb.toString();
    }

	protected String tp()
	{
		// even for union pattern translate, we can "abosrb" the parameter name within the union case selection
		// i.e. parameter name can be the same as the selected union parameter name without capturing it. 
        // TRPatternListList parameters = TRPatternListList.newPatternListList(parameterPatterns, TRPatternList.newPatternList(TRBasicPattern.dummyPattern(location, false)));
        // paramPatternList.setSemanticSeparator(IsaToken.SPACE.toString());
        boolean oldFreshness = paramPatternList.setDummyFreshness(false, true);
        String fcnParams = paramPatternList.translate();
		paramPatternList.setDummyFreshness(false,true);//oldFreshness, true);
		return fcnParams;
	}

    @Override 
	public boolean isImplicitFunction()
	{
		return false;
	}
}
