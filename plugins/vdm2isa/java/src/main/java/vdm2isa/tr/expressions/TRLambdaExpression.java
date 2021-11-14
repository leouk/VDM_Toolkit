package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRPatternList;
import vdm2isa.tr.patterns.TRTypeBindList;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRType;

/**
 * VDM Lambda expressions are complex to translate because of the need for local invariant checks and the need
 * for TCLambdaExpression type information to be passed through so that we know what kind of lambda TRFunctionType we need.
 * This is important to ensure that properly curried invariants are added for the lambda, as well as dummy variable 
 * names for the corresponding lambda invariant check. The TCLambdaExpression TRDefinition def field is not needed
 * given that paramPatterns/Definitions are sufficient.  
 */
public class TRLambdaExpression extends TRVDMLocalDefinitionListExpression {

    private final TRTypeBindList bindList;

    private final TRFunctionType type;
	private final TRPatternList paramPatterns;
	private final TRDefinitionList paramDefinitions;
	private final TRDefinition def;

    public TRLambdaExpression(LexLocation location, TRTypeBindList bindList, TRExpression expression,
        TRFunctionType type, TRPatternList paramPatterns, TRDefinitionList paramDefinitions, TRDefinition def,
        TRType exptype)
    {
        super(location, expression, exptype);
        this.bindList = bindList;
        this.type = type;
        this.paramPatterns = paramPatterns; 
        this.paramDefinitions = paramDefinitions; 
        if (paramDefinitions != null)
            this.paramDefinitions.setLocal(true);
        this.def = def;
        
        //System.out.println(toString());
    }

    @Override
    protected void setup()
	{
        super.setup();
	 	setFormattingSeparator("\n\t");
        setInvTranslateSeparator(" " + IsaToken.AND.toString() + " ");
	}

    @Override 
    public String toString()
    {
        return "LambdaExpr: (lambda " + String.valueOf(bindList) + //.translate() + 
            " & " + String.valueOf(expression) + //.translate() + 
            " )" +  "\n\tFcnType    = " + String.valueOf(type) + //.translate() +
                    "\n\tParamPttrs = " + String.valueOf(paramPatterns) + 
                    "\n\tParamDefs  = " + String.valueOf(paramDefinitions) +
                    "\n\tDef        = " + String.valueOf(def) +
                    "\n\tloc        = " + location.toString() + 
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
    public TRType getType()
    {
        return type;//type.result;
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
        sb.append(getFormattingSeparator());
        sb.append(isaToken().toString());
        sb.append(" ");
        sb.append(bindList.translate());
        sb.append(" ");
        sb.append(IsaToken.POINT.toString());
        String old = paramPatterns.setFormattingSeparator(getFormattingSeparator());
        String old2 = paramPatterns.setSemanticSeparator(IsaToken.SEMICOLON.toString() + IsaToken.SPACE.toString());        
        sb.append(paramPatterns.recordPatternTranslate());
        sb.append(getFormattingSeparator() + "\t");
        sb.append(invTranslate());
        paramPatterns.setFormattingSeparator(old);
        paramPatterns.setSemanticSeparator(old2);
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
