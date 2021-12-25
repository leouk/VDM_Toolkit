package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRType;

public class TRImplicitFunctionDefinition extends TRExplicitFunctionDefinition 
{

    public TRImplicitFunctionDefinition(TCExplicitFunctionDefinition definition, TRIsaVDMCommentList comments,
            TRAnnotationList annotations, TCNameToken name, NameScope nameScope, boolean used, boolean excluded,
            TCNameList typeParams, TRFunctionType type, TRPatternListList paramPatternList, TRExpression body,
            TRExpression precondition, TRExpression postcondition, boolean typeInvariant, TRExpression measureExp,
            boolean isCurried, TRExplicitFunctionDefinition predef, TRExplicitFunctionDefinition postdef,
            TRDefinitionListList paramDefinitionList, boolean recursive, boolean isUndefined, TRType actualResult,
            TRType expectedResult) {
        super(definition, comments, annotations, name, nameScope, used, excluded, typeParams, type, paramPatternList, body,
                precondition, postcondition, typeInvariant, measureExp, isCurried, predef, postdef, paramDefinitionList,
                recursive, isUndefined, actualResult, expectedResult);
    }
    
}
