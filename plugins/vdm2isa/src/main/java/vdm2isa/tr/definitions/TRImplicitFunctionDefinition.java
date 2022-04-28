package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRPatternListTypePairList;
import vdm2isa.tr.types.TRPatternTypePair;
import vdm2isa.tr.types.TRType;

public class TRImplicitFunctionDefinition extends TRExplicitFunctionDefinition 
{
	private static final long serialVersionUID = 1L;

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
		super(definition, comments, annotations, name, nameScope, used, excluded, 
			typeParams, type, 
            parameterPatterns != null ? 
                parameterPatterns.getParamPatternListList() : null, body,
			precondition, postcondition, false, measureExp, false, 
			predef, postdef, null /*paramDefinitionList*/,
			recursive, isUndefined, actualResult, 
                result != null ? result.getType() : null, false);
        this.parameterPatterns = parameterPatterns;
        this.result = result;
        // funnily, implicit function definitions can have bodies! 
    }

    @Override 
    public void setup()
    {
        // has to be before super.setup so that we can set paramPatternList in case
        // parameterPatterns were null at construction time
        assert parameterPatterns != null && result != null;
        this.paramPatternList = parameterPatterns.getParamPatternListList();
        this.expectedResult = result.getType();
        super.setup();
    }
    
    @Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseImplicitFunctionDefinition(this, arg);
	}	

    @Override 
	public boolean isImplicitFunction()
	{
		return true;
	}
}
