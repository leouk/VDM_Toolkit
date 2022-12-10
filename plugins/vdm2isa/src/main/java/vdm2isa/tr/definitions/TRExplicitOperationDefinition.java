package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitOperationDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
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
import vdm2isa.tr.patterns.TRPatternList;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.patterns.TRRecordPattern;
import vdm2isa.tr.statements.TRStatement;
import vdm2isa.tr.types.TROperationType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeSet;


public class TRExplicitOperationDefinition extends TRExplicitFunctionDefinition {

    private static final long serialVersionUID = 1L;
	public final TRPatternList parameterPatterns;
	
	public TRDefinitionList paramDefinitions;
	public TRStateDefinition state;

	public TRTypeSet possibleExceptions = null;

    protected TRExplicitOperationDefinition(
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
        TRStatement body,
        TRExpression precondition,
        TRExpression postcondition, 
        TRExplicitFunctionDefinition predef,
        TRExplicitFunctionDefinition postdef,
        TRStateDefinition state,
        TRType actualResult,
        TRTypeSet possibleExceptions,
        boolean ignore
    ) {
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
			actualResult,
			type.getInnerType(), 
            ignore
        );
        this.parameterPatterns = parameterPatterns;
        this.paramDefinitions = paramDefinitions;
		this.state = state;
        this.possibleExceptions = possibleExceptions;
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
        TRStatement body,
        TRExpression precondition,
        TRExpression postcondition, 
        TRExplicitFunctionDefinition predef,
        TRExplicitFunctionDefinition postdef,
        TRStateDefinition state,
        TRType actualResult,
        TRTypeSet possibleExceptions
    ) {
        this(
            definition, 
			comments,
			annotations,
			name,
			nameScope, 
			used, 
			excluded,
            parameterPatterns,
            paramDefinitions,
            type,
			body,
			precondition,
			postcondition, 
			predef,
			postdef,
            state,
			actualResult,
			possibleExceptions,
            false
        );
    }

    @Override
    public void setup(){
        super.setup();
        assert getVDMDefinition() != null && (getVDMDefinition() instanceof TCExplicitOperationDefinition || getVDMDefinition() instanceof TCImplicitFunctionDefinition);
        paramPatternList = TRPatternListList.newPatternListList(TRPatternListList.newPatternListList(parameterPatterns, TRPatternList.newPatternList(
            TRRecordPattern.RecordPatternGenerator(TRStateDefinition.state.recordType,TRStateDefinition.state.recordType.location))).getFlatPatternList());
        paramPatternList.setSemanticSeparator(IsaToken.SPACE.toString());
        //TODO: check, but this can't be done later on! 
//        super.setup();
        setFormattingSeparator("\n\t");
        TRNode.setup(state, paramDefinitions, parameterPatterns, possibleExceptions);
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
        
        if (this.recursive)
        {
            sb.append(IsaTemplates.translateRecFunDefinition(
                this.getLocation(), fcnName, fcnInType, fcnOutType, fcnParams, 
                "Empty body", isLocal()));
        }
        else
        {
            sb.append(IsaTemplates.translateNonRecFunctionDefinition(IsaItem.DFUNCTION,
                this.getLocation(), fcnName, fcnInType, fcnOutType, fcnParams, 
                "Empty body", isLocal()));       
        }
        
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
