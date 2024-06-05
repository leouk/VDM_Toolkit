package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexKeywordToken;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.lex.Token;
import com.fujitsu.vdmj.tc.expressions.TCLetBeStExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRMultiBindListDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;

/**
 * LetBeStExpressions are complicated. Their target mapping in Isabelle is the Epsilon/SOME operator via axiom of choice. 
 * Nevertheless, that operator does not allow multiple binds neither a result relative to a value expression. So for example
 * 
 * let x in S be st P(x) in x = (SOME x . x : S /\ P(x))
 * 
 * But then 
 * 
 * let x, y in S be st P(x,y) in exp(x,y) = ?
 * 
 * Therefore, we decided to use set comprehension to represent the let, and choose from the resulting set the value choice as
 * 
 * let x, y in S be st P(x,y) in exp(x,y) = (SOME v . v : { exp(x,y) | x y . x : S /\ y : S /\ P(x,y) })
 */
public class TRLetBeStExpression extends TRVDMLocalDefinitionListExpression {
    
    private static final long serialVersionUID = 1L;
    public final TRMultipleBind bind;
    public final TRExpression suchThat;
    public final TRMultiBindListDefinition def;
    private TRBinaryExpression vInSetS;

	public TRLetBeStExpression(LexLocation location, TCLetBeStExpression tc, TRMultipleBind bind, TRExpression suchThat, TRExpression value, TRMultiBindListDefinition def, TRType exptype) {
        super(location, tc, value, exptype);
        this.bind = bind;
        this.suchThat = suchThat;
        this.def = def; 
        this.vInSetS = null;
    }
    
    @Override
    public void setup()
	{
        super.setup();
        setFormattingSeparator("\n\t\t");
        setInvTranslateSeparator(IsaToken.SPACE.toString() + IsaToken.AND.toString() + IsaToken.SPACE.toString());
        // LetBeSt is represented through in set of a set comprehension constructed on the fly, with necessary adjustments to exptype for the set comp.
        String original = IsaToken.dummyVarNames(1, false, location);
        TRMultipleBindList bindings = bind.getMultipleBindList();
        this.vInSetS = TRBinaryExpression.newBinaryExpression(
            TRVariableExpression.newVariableExpr(location, /*name,*/ original, exptype),
            new LexKeywordToken(Token.INSET, location),
            TRSetCompExpression.newSetCompExpression(
                //TODO "the" awareness for expression? Hum...
                location, expression, bindings, suchThat, 
                this.def, //new TRMultipleBindListDefinition(location, null, null, null, null, false, false, bindings, defs),
                TRSetType.newSetType(location, exptype, false)),
                exptype);    
        TRNode.setup(vInSetS);

        // System.out.println(toString());
    }
        
    @Override
    public String toString()
        {
            return "LetBeStDef " + String.valueOf(bind) + " be st " + 
        "\n\t suchThat = " + String.valueOf(suchThat) + 
        "\n\t expr     = " + String.valueOf(expression) +
        "\n\t loc      = " + String.valueOf(getLocation());
    }

    @Override
    public IsaToken isaToken() {
       return IsaToken.SOME;
    }

    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(getFormattingSeparator());
        sb.append(isaToken().toString());
        sb.append(IsaToken.SPACE);
        sb.append(IsaToken.parenthesise(
            IsaToken.dummyVarNames(1, false, location) +
            IsaToken.TYPEOF.toString() +
            getType().translate()));
        sb.append(IsaToken.SPACE);
        sb.append(IsaToken.POINT);
        //TODO someone has to call the inner binds record translate? 
        sb.append(this.vInSetS.translate());
        return IsaToken.parenthesise(sb.toString());
    }

    /**
     * invariant translation is based on the binds' type(s).
     */
    @Override
    public String localInvTranslate()
    {
        return bind.invTranslate();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseLetBeStExpression(this, arg);
	}
}
