package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.patterns.TRPatternList;
import vdm2isa.tr.patterns.TRTypeBindList;
import vdm2isa.tr.types.TRFunctionType;

public class TRLambdaExpression extends TRExpression {

    private TRTypeBindList bindList;
    private TRExpression expression;

    private TRFunctionType type;
	private TRPatternList paramPatterns;
	private TRDefinitionList paramDefinitions;
	private TRDefinition def;

    public TRLambdaExpression(LexLocation location, TRTypeBindList bindList, TRExpression expression,
        TRFunctionType type, TRPatternList paramPatterns, TRDefinitionList paramDefinitions, TRDefinition def)
    {
        super(location);
        this.bindList = bindList;
        this.expression = expression;
        this.type = type;
        this.paramPatterns = paramPatterns; 
        this.paramDefinitions = paramDefinitions; 
        System.out.println("LambdaExpr: (lambda " + bindList.translate() + " & " + expression.translate() + " )" +
            "\n\tFcnType    = " + type.translate() +
            "\n\tParamPttrs = " + paramPatterns.translate() + 
            "\n\tParamDefs  = " + paramDefinitions.translate() +
            "\n\tDef        = " + def.toString() + 
            "\n");
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.LAMBDA;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        // lambda x: nat, y: nat1 & x + y
        // =
        // (% (x::VDMNat) (y::VDMNat1) . 
        //      (if (inv_VDMNat x) /\ (inv_VDMNat1 y) then
        //          (x + y)
        //       else 
        //          undefined
        //      )
        // )
        sb.append("\n\t");
        sb.append(isaToken().toString());
        sb.append(" ");
        sb.append(bindList.translate());
        sb.append(IsaToken.POINT.toString());
        sb.append("\n\t\t");
        sb.append(IsaToken.LPAREN.toString());
        sb.append(IsaToken.IF.toString());
        sb.append(" ");
        sb.append(bindList.invTranslate());
        sb.append(" ");
        sb.append(IsaToken.THEN.toString());
        sb.append("\n\t\t\t");
        sb.append(expression.translate());        
        sb.append("\n\t\t ");
        sb.append(IsaToken.ELSE.toString());
        sb.append("\n\t\t\t");
        sb.append(IsaToken.UNDEFINED.toString());
        sb.append("\n\t\t"); 
        sb.append(IsaToken.RPAREN.toString());
        sb.append("\n\t");
        return IsaToken.parenthesise(sb.toString());
    }
}
