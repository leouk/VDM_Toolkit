package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCExists1Expression;
import com.fujitsu.vdmj.tc.expressions.TCExistsExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCForAllExpression;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindKind;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRType;

public class TRBoundedExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;
	public final TRMultipleBindList bindList;
	public final TRExpression predicate;
    public final IsaToken quantifier;
    private int rParenCount;

    protected TRBoundedExpression(LexLocation location, TCExpression tc, IsaToken quantifier, TRMultipleBindList bindList, TRExpression predicate, TRType exptype)
    {
        super(location, tc, exptype);
        this.bindList = bindList;
        this.predicate = predicate;
        this.quantifier = quantifier;
        this.rParenCount = 0;
    }
    
    public TRBoundedExpression(TCExists1Expression owner, TRMultipleBind bind, TRExpression predicate, TRType exptype)
    {
        this(owner.location, owner, IsaToken.EXISTS1, bind != null ? bind.getMultipleBindList() : null, predicate, exptype);
    }

    public TRBoundedExpression(TCExistsExpression owner, TRMultipleBindList bindList, TRExpression predicate, TRType exptype)
    {
        this(owner.location, owner, IsaToken.EXISTS, bindList, predicate, exptype);
    }

    public TRBoundedExpression(TCForAllExpression owner, TRMultipleBindList bindList, TRExpression predicate, TRType exptype)
    {
        this(owner.location, owner, IsaToken.FORALL, bindList, predicate, exptype);
    }

    @Override
    public void setup()
	{
        super.setup();
        rParenCount = 0;
	// 	setSemanticSeparator("");
	 	setFormattingSeparator(IsaToken.SPACE.toString());
	 	setInvTranslateSeparator(getFormattingSeparator() + IsaToken.IMPLIES.toString() + getFormattingSeparator());
        assert bindList != null;
        TRNode.setup(bindList, predicate); 
	}

    /**
     * Bounded expressions are necessarily boolean result; which would be the same as the predicate.getType()?
     */
    @Override
	protected TRType getBestGuessType()
	{
		return predicate.getType();//TRBasicType.boolType(location);?
    }

    @Override
    public IsaToken isaToken() {
        return quantifier;
    }

    @Override
    public String tldIsaComment()
    {
        if (requiresImplicitTypeInvariantChecks())
            return IsaToken.comment(IsaInfoMessage.VDM_IMPLICITLY_DEFINED_QUANTIFIED_INV.toString(), getFormattingSeparator());
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
        sb.append(predicate.patternContextTranslate(bindList));

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

    private static final TCExpression figureOutTCBoundedExpression(LexLocation location, IsaToken quantifier, TRMultipleBindList bindList, TRExpression predicate)
    {
        TCExpression result;
        switch (quantifier)
        {
            case EXISTS1:
                assert bindList.size() == 1;
                result = new TCExists1Expression(location, bindList.get(0).getVDMBind(), predicate.getVDMExpr());
                break;
            case EXISTS:
                result = new TCExistsExpression(location, bindList.getVDMMultipleBindList(), predicate.getVDMExpr());
                break;
            case FORALL:
                result = new TCForAllExpression(location, bindList.getVDMMultipleBindList(), predicate.getVDMExpr());
                break;
            default :
                result = null;
        }
        return result;
    }

    public static final TRBoundedExpression newBoundedExpression(LexLocation location, IsaToken quantifier, TRMultipleBindList bindList, TRExpression predicate)
    {
        assert quantifier.equals(IsaToken.EXISTS1) || quantifier.equals(IsaToken.EXISTS) || quantifier.equals(IsaToken.FORALL);
        TRBoundedExpression result = new TRBoundedExpression(location, 
            TRBoundedExpression.figureOutTCBoundedExpression(location, quantifier, bindList, predicate), 
            quantifier, bindList, predicate, predicate.getType());//TRBasicType.boolType(location));
        TRNode.setup(result);
        return result;
    }
}
