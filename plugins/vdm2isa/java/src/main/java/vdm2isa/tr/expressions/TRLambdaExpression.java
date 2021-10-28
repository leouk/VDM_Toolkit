package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
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
public class TRLambdaExpression extends TRVDMLocalDefinitionListExpression {

    private TRTypeBindList bindList;

    private TRFunctionType type;
	//private TRPatternList paramPatterns;
	//private TRDefinitionList paramDefinitions;
	//private TRDefinition def;

    public TRLambdaExpression(LexLocation location, TRTypeBindList bindList, TRExpression expression,
        TRFunctionType type 
        /*, TRPatternList paramPatterns, TRDefinitionList paramDefinitions */ /* , TRDefinition def */
        )
    {
        super(location, expression);
        this.bindList = bindList;
        this.type = type;
        // See NB's email on 28/10/2021 8:59 Subject TCLambdaExpression.paraDefinitions.implicitDefinitions
        // There is no need for those in the end. So remove them. 
        //this.paramPatterns = paramPatterns; 
        //this.paramDefinitions = paramDefinitions; 
        //this.paramDefinitions.setLocal(true);
        
        // There is no need for these either
        //this.def = def;
        
        //System.out.println(toString());
    }

    @Override 
    public String toString()
    {
        return "LambdaExpr: (lambda " + bindList.translate() + " & " + expression.translate() + " )" +
                    "\n\tFcnType    = " + type.translate() +
                    //"\n\tParamPttrs = " + paramPatterns.translate() + 
                    //"\n\tParamDefs  = " + paramDefinitions.translate() +
                    //"\n\tDef        = " + def.toString() + 
                    "\n";
        /*
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
        sb.append(tabs);
        sb.append(invTranslate());
        return IsaToken.parenthesise(sb.toString());
    }

    /**
     * Local definitions invariant translation
     */
    @Override
    public String localInvTranslate()
    {
        return bindList.invTranslate();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseLambdaExpression(this, arg);
	}
}
