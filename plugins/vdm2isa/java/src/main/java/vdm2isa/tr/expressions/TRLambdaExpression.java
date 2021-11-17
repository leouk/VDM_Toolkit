package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRMultiBindListDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.patterns.TRMultipleTypeBind;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.TRPatternList;
import vdm2isa.tr.patterns.TRTypeBindList;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeList;

/**
 * VDM Lambda expressions are complex to translate because of the need for local invariant checks and the need
 * for TCLambdaExpression type information to be passed through so that we know what kind of lambda TRFunctionType we need.
 * This is important to ensure that properly curried invariants are added for the lambda, as well as dummy variable 
 * names for the corresponding lambda invariant check. The TCLambdaExpression TRDefinition def field is not needed
 * given that paramPatterns/Definitions are sufficient.  
 */
public class TRLambdaExpression extends TRVDMLocalDefinitionListExpression {

    private final TRTypeBindList bindList;

    //private final TRFunctionType type; // same as exptype? yes!
	private final TRPatternList paramPatterns;
	private final TRDefinitionList paramDefinitions;
	private final TRDefinition def;
    private TRLambdaExpressionKind lambdaKind;

    /**
     * Determines the kind of lambda expression this represents as either:
     *      1) normal VDMSL lambdas      (i.e. as given by the VDM user)
     *      2) "simple" map comp lambda  (i.e. domain element is a variable,   {   x |-> 10 | x in set S })
     *      3) "complex" map comp lambda (i.e. domain element is an expression { x+x |-> 10 | x in set S })
     */
    protected enum TRLambdaExpressionKind { NORMAL, MAPCOMP, EXISTENTIAL_MAPCOMP }

    public TRLambdaExpression(LexLocation location, TRTypeBindList bindList, TRExpression expression,
        TRFunctionType type, TRPatternList paramPatterns, TRDefinitionList paramDefinitions, TRDefinition def)
    {
        super(location, expression, type);
        this.bindList = bindList;
        //this.type = type; // this is redundant? Given it's the exptype already? 
        this.paramPatterns = paramPatterns; 
        this.paramDefinitions = paramDefinitions; 
        if (paramDefinitions != null)
            this.paramDefinitions.setLocal(true);
        this.def = def;
        this.lambdaKind = TRLambdaExpressionKind.NORMAL;
        System.out.println(toString());
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
        return "LambdaExpr: (lambda " + String.valueOf(bindList) +  
            " & " + String.valueOf(expression) + 
            " )" +  "\n\tFcnType    = " + String.valueOf(exptype) + 
                    "\n\t\t defs    = " + String.valueOf(exptype.getDefinitions()) +
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
    protected TRType getBestGuessType()
    {
        return exptype;//type.result;
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
        //TODO don't these recordPattern context needs parenthesis? 
        sb.append(paramPatterns.recordPatternTranslate());
        sb.append(getFormattingSeparator() + "\t");
        sb.append(invTranslate());
        paramPatterns.setFormattingSeparator(old);
        paramPatterns.setSemanticSeparator(old2);
        return IsaToken.parenthesise(sb.toString());
    }

    /**
     * Local definitions invariant translation. That is, for every input bind, add an invariant 
     * check on the type; then also an invariant check on the result expression type! 
     */
    @Override
    public String localInvTranslate()
    {
        StringBuilder sb = new StringBuilder();
        // normal + "simple" map comp lambdas, check the input/output type invariants
        if (!this.lambdaKind.equals(TRLambdaExpressionKind.EXISTENTIAL_MAPCOMP))
        {
            // check the input parameters inv_Translate
            sb.append(bindList.invTranslate());
            sb.append(getInvTranslateSeparator());
            // check the result expression inv_Translate
            sb.append(this.expression.getType().invTranslate(expression.translate()));
        }
        // map comprehension lambdas require similar input/output type invariant checks
        // but in the context of an existential mapping between maplet "from" and the 
        // lambda dummy input name for the input.
        else
        {
            sb.append("TODO!");
        }
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseLambdaExpression(this, arg);
	}

    /**
     * Synthetically construct a lambda expression with minimal information about its parts, where this recreates
     * the expected internal strcuture that a TC/TRLambdaEpxression is supposed to have (i.e. reinvents what the TC
     * does for lambda expressions effectively).  
     * @param location
     * @param bindList
     * @param expression
     * @param def
     * @return
     */
    public static TRLambdaExpression newLambdaExpression(TRTypeBindList bindList, TRExpression expression)
    {
        TRMultipleBindList mbinds = new TRMultipleBindList();
        TRPatternList paramPatterns = TRPatternList.newPatternList((TRPattern[])null); 
        TRDefinitionList paramDefinitions = new TRDefinitionList();
        for (TRMultipleTypeBind tb : bindList)
		{
			mbinds.addAll(tb.getMultipleBindList());
			paramDefinitions.addAll(tb.getDefinitions());
            paramPatterns.addAll(tb.plist);
		}
        TRFunctionType fcnType = TRFunctionType.newFunctionType(expression.getType(), bindList.getTypeList());
        return new TRLambdaExpression(expression.getLocation(), bindList, expression, fcnType, 
            paramPatterns, paramDefinitions, TRMultiBindListDefinition.newBindListDef(expression.getLocation(), mbinds));
    }

    /**
     * Get the type binding list from the multiple bindings then pass the expression for the lambda
     * @param bindings
     * @param expression
     * @return
     */
    public static TRLambdaExpression newLambdaExpression(TRMultipleBindList bindings, TRExpression expression)
    {
        return TRLambdaExpression.newLambdaExpression(bindings.getTypeBindList(), expression);
    }

    /**
     * For map comprehension, we transform the inputs into a corresponding lambda (see TRMapCompExpression for details),
     * where the lambda predicate is constructed from the map comprehension structure inputs.
     * @param first
     * @param bindings
     * @param predicate
     * @param mapType
     * @return
     */
    public static TRLambdaExpression newMapCompExpression(TRMapletExpression first, TRMultipleBindList bindings,
            TRExpression predicate, TRMapType mapType) {
                // predicate can be null for when { x |-> y | x in set S }! 
        TRLambdaExpression result = TRLambdaExpression.newLambdaExpression(bindings, predicate);

        TRPatternList patterns = bindings.getPatternListList().getFlatPatternList();

        // simple map comprehension have variable expression for maplet domain 
        boolean simpleMapComp = first.left instanceof TRVariableExpression; 
        
        // "simple" map comprehension must have single bind. 
        // this avoids the complex expression case for trivial binds?
        // { x |-> 10 | x in set S, y in set T } would require existential for no need?!
        result.lambdaKind = simpleMapComp && patterns.size() == 1 ? 
            TRLambdaExpressionKind.MAPCOMP : 
            TRLambdaExpressionKind.EXISTENTIAL_MAPCOMP;
        
        // warn the user for the silly case, given it will have horrendous existential 
        // expression within the lambda-if for nothing! 
        if (simpleMapComp && patterns.size() > 1)
        {
            // if VDM unused variable warning (5000) is observed, then this warning doesn't happen
            result.warning(IsaWarningMessage.VDMSL_INVALID_EXPR_TYPE_2P, "map comprehension", 
                first.translate(), bindings.getPatternListList().getFlatPatternList().size(),
                patterns.translate());    
        }
        return result;
    }
}
