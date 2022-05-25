package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.definitions.TCImplicitOperationDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRStatement;
import vdm2isa.tr.types.TROperationType;
import vdm2isa.tr.types.TRPatternListTypePairList;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeSet;


public class TRImplicitOperationDefinition extends TRExplicitOperationDefinition {


    private TRPatternListTypePairList parameterPatterns;

    public TRImplicitOperationDefinition(
        TCImplicitOperationDefinition definition,
        TRIsaVDMCommentList comments,
        TRAnnotationList annotations,
        TCNameToken name,
        NameScope nameScope, 
        boolean used, 
        boolean excluded,

        // For this class
        TRPatternListTypePairList parameterPatterns,
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
        super(
            definition, 
			comments,
			annotations,
			name,
			nameScope, 
			used, 
			excluded,
            parameterPatterns != null ? parameterPatterns.getParamPatternListList().getFlatPatternList() : null,
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
        this.parameterPatterns = parameterPatterns;
    }

    @Override
    public void setup(){
        super.setup();
        setFormattingSeparator("\n\t");
        TRNode.setup(this.parameterPatterns);
    }

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseImplicitOperationDefinition(this, arg);
    } 
    
    @Override 
	public boolean isImplicitFunction()
	{
		return true;
	}
}
