package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.patterns.TRPatternList;
import vdm2isa.tr.patterns.TRTypeBindList;
import vdm2isa.tr.types.TRFunctionType;

/**
 * VDM Lambda expressions are complex to translate because of the need for local invariant checks and the need
 * for TCLambdaExpression type information to be passed through so that we know what kind of lambda TRFunctionType we need.
 * This is important to ensure that properly curried invariants are added for the lambda, as well as dummy variable 
 * names for the corresponding lambda invariant check. The TCLambdaExpression TRDefinition def field is not needed
 * given that paramPatterns/Definitions are sufficient.  
 */
public class TRLambdaExpression extends TRExpression {

    private TRTypeBindList bindList;
    private TRExpression expression;

    private TRFunctionType type;
	private TRPatternList paramPatterns;
	private TRDefinitionList paramDefinitions;
	//private TRDefinition def;

    public TRLambdaExpression(LexLocation location, TRTypeBindList bindList, TRExpression expression,
        TRFunctionType type, TRPatternList paramPatterns, TRDefinitionList paramDefinitions)
    {
        super(location);
        this.bindList = bindList;
        this.expression = expression;
        this.type = type;
        //TODO refactor these two out as it turns out the use of bind translation is better? 
        this.paramPatterns = paramPatterns; 
        this.paramDefinitions = paramDefinitions; 
        this.paramDefinitions.setLocal(true);
        /*
        System.out.println("LambdaExpr: (lambda " + bindList.translate() + " & " + expression.translate() + " )" +
            "\n\tFcnType    = " + type.translate() +
            "\n\tParamPttrs = " + paramPatterns.translate() + 
            "\n\tParamDefs  = " + paramDefinitions.translate() +
            //"\n\tDef        = " + def.toString() + 
            "\n");
        "v74= (lambda var : nat, var2: nat & var + var2);""
        LambdaExpr: (lambda (var::VDMNat) (var2::VDMNat) & (var + var2) )
            FcnType    = VDMNat\<Rightarrow>VDMNat \<Rightarrow> VDMNat
            ParamPttrs = var,var2
            ParamDefs  = (var::VDMNat)(var2::VDMNat)
            Def        = vdm2isa.tr.definitions.TRMultiBindListDefinition@5f3b9c57
                MultiBindListDef
                    bindings: (var::VDMNat) (var2::VDMNat)
                    defs    : (var::VDMNat)(var2::VDMNat)
        */
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
        sb.append(" ");
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
