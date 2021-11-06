package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExists1Expression;
import com.fujitsu.vdmj.tc.expressions.TCExistsExpression;
import com.fujitsu.vdmj.tc.expressions.TCForAllExpression;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindKind;
import vdm2isa.tr.patterns.TRMultipleBindList;

public class TRBoundedExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;
	private final TRMultipleBindList bindList;
	private final TRExpression predicate;
    private final IsaToken owner;
    private int rParenCount;
     
    public TRBoundedExpression(TCExists1Expression owner, TRMultipleBind bind, TRExpression predicate)
    {
        super(owner.location);
        this.bindList = bind.getMultipleBindList();
        this.predicate = predicate;
        this.owner = IsaToken.EXISTS1;
    }

    public TRBoundedExpression(TCExistsExpression owner, TRMultipleBindList bindList, TRExpression predicate)
    {
        super(owner.location);
        this.bindList = bindList;
        this.predicate = predicate;
        this.owner = IsaToken.EXISTS;
    }

    public TRBoundedExpression(TCForAllExpression owner, TRMultipleBindList bindList, TRExpression predicate)
    {
        super(owner.location);
        this.bindList = bindList;
        this.predicate = predicate;
        this.owner = IsaToken.FORALL;
    }

    @Override
    protected void setup()
	{
        super.setup();
        rParenCount = 0;
	// 	setSemanticSeparator("");
	 	setFormattingSeparator(" ");
	 	setInvTranslateSeparator(getFormattingSeparator() + IsaToken.IMPLIES.toString() + getFormattingSeparator());
	}

    @Override
    public IsaToken isaToken() {
        return owner;
    }

    @Override
    public String tldIsaComment()
    {
        if (requiresImplicitTypeInvariantChecks())
            return IsaToken.comment("Implicitly defined type invariant checks for quantified type binds", getFormattingSeparator());
        else
           return super.tldIsaComment();
    }
    
    @Override
    public boolean requiresImplicitTypeInvariantChecks()
    {
        // if found type binds, issue comment about extra invariant checks for subtype soundness
        return bindList.foundBinds(TRMultipleBindKind.TYPE);
    }

        /**
     * [quantifier] + [bindings] + [.] formatting separated
     */
    protected String boundedPatternsTranslate(String patterns)
    {
        assert patterns != null && !patterns.isEmpty();

        StringBuilder sb = new StringBuilder();

        sb.append(IsaToken.LPAREN.toString());
        sb.append(isaToken().toString());
        sb.append(getFormattingSeparator());
        
        sb.append(patterns);
        sb.append(getFormattingSeparator());

        sb.append(getFormattingSeparator());
        sb.append(IsaToken.POINT.toString());
        sb.append(getFormattingSeparator());

        // do not translate predicate or RPAREN; caller must issue rParenCount  
        rParenCount++;
        return sb.toString();
    }

    /**
     * Bounded binds translation requires care: it depends on what kind of bind (e.g., forall set bind can only have 1 variable),
     * and might need extra type invariant checks (e.g., type binds require check about it's invariant).
     */
    @Override
    public String translate() {
        // return IsaToken.parenthesise(isaToken().toString() + " " + 
        // bindList.translate() + IsaToken.POINT + " " + predicate.translate());
        StringBuilder sb = new StringBuilder();

        // restart the RPAREN count 
        this.rParenCount = 0;
        boolean oldP = bindList.setParenthesise(false);

        // if only type binds, no need for multiple quantifiers
        if (bindList.areBindsUniform(TRMultipleBindKind.TYPE))
        {
            // type binds require parenthesis! 
            // e.g. "forall x in set S & P" => "! (x : S) . P" is wrong! Has to be "! x : S . P" for set binds, whereas
            //      "forall x:T & P" => "! x::T . P" is wrong! Has to be "! (x::T) . P" for type binds 
            
            //spurious now with getParenthesise() in type bind always returning true, but leave for clarity
            bindList.setParenthesise(true);
            sb.append(boundedPatternsTranslate(bindList.translate()));
        }
        // if mixed binds, then will have multiple quantifiers, e.g. x:nat, y in set S => ! x::VDMNat . ! y : S
        else 
        {
            // for each bind individually translate each pattern
            for(int i = 0; i < bindList.size(); i++)
            {
                for(int j = 0; j < bindList.get(i).plist.size(); j++)
                {
                    sb.append(boundedPatternsTranslate(bindList.get(i).patternTranslate(j, false)));
                }
            }
        }

        // if found type bind add implication to predicate and an extra parenthesis pair
        // e.g. forall x: nat, y: nat, z in set S & P(x,y,z)
        if (requiresImplicitTypeInvariantChecks())
        {
            sb.append(IsaToken.LPAREN.toString());
            rParenCount++;

            // type binds require invariant checks before the user predicate!
            // presume the bind list has the right inv separator in place  
            // for mixed type + set/seq binds, add inv checks for each bind kind! 
            sb.append(bindList.invTranslate());
            sb.append(getInvTranslateSeparator());
        }
        // add the bounded predicate
        sb.append(predicate.translate());

        // otherwise we would have empty binds, which will be caught within TRMultipleBindList. Avoid reissuing the error
        if (this.rParenCount > 0)
        {
            sb.append(IsaTemplates.replicate(IsaToken.RPAREN.toString(), this.rParenCount));
        }

        bindList.setParenthesise(oldP);

        return sb.toString();
    }

    @Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseBoundedExpression(this, arg);
	}
}
