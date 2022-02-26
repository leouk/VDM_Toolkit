package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRUnionContext;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRPatternListTypePairList;
import vdm2isa.tr.types.TRPatternTypePair;
import vdm2isa.tr.types.TRType;

public class TRImplicitFunctionDefinition extends TRAbstractFunctionDefinition 
{
    private final TRPatternListTypePairList parameterPatterns;
    private final TRPatternTypePair result;
 
    public TRImplicitFunctionDefinition(TCImplicitFunctionDefinition definition, TRIsaVDMCommentList comments,
            TRAnnotationList annotations, TCNameToken name, NameScope nameScope, boolean used, boolean excluded,
            TCNameList typeParams, TRPatternListTypePairList parameterPatterns, TRPatternTypePair result,
            TRFunctionType type, TRExpression body,
            TRExpression precondition, TRExpression postcondition, 
            TRExpression measureExp,
            TRExplicitFunctionDefinition predef, TRExplicitFunctionDefinition postdef,
            boolean recursive, boolean isUndefined, TRType actualResult) 
    {
        super(definition, comments, annotations, name, nameScope, used, excluded, typeParams, type, body,
                precondition, postcondition, measureExp, predef, postdef,
                recursive, isUndefined, actualResult);
        this.parameterPatterns = parameterPatterns;
        this.result = result;
        // funnily, implicit function definitions can have bodies! 
    }
    
    @Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseImplicitFunctionDefinition(this, arg);
	}

    @Override
    protected TRExplicitFunctionDefinition createUndeclaredSpecification(TRSpecificationKind kind) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    protected void updateSpecificationGenericParameters() {
        // TODO Auto-generated method stub
        
    }

    @Override
    protected String paramsInvTranslate(TRSpecificationKind kind) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    protected String translateParameters() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    protected boolean parametersNeedsPatternContext() {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    protected String parametersPatternContextTranslate() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public boolean hasUnionTypes() {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public String unionTypesTranslate(TRExpression unionBody, TRUnionContext innerContext) {
        // TODO Auto-generated method stub
        return null;
    }
}
