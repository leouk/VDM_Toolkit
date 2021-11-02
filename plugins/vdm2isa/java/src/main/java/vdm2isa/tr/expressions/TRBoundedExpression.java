package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExists1Expression;
import com.fujitsu.vdmj.tc.expressions.TCExistsExpression;
import com.fujitsu.vdmj.tc.expressions.TCForAllExpression;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.patterns.TRMultipleSetBind;
import vdm2isa.tr.patterns.TRMultipleTypeBind;

public class TRBoundedExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;
	private final TRMultipleBindList bindList;
	private final TRExpression predicate;
    private final IsaToken owner;
     
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

     protected void setup()
	{
	// 	setSemanticSeparator("");
	 	setFormattingSeparator(" ");
	// 	setInvTranslateSeparator("");
	}

    @Override
    public IsaToken isaToken() {
        return owner;
    }

    /**
     * If bind translating with indexes, there will be various quantified formulae! 
     * This should only be called if the binds list size is greater than 1.
     * @param index
     * @return
     */
    protected String bindTranslate(int index)
    {
        StringBuilder sb = new StringBuilder();
        //if (bindList.size() <= 1)
        //    report(11111, "Translation of multiple binds in \"" + isaToken().vdmToken().toString() + "\" expression bind list must contain at least two binds.");
        //else 
        //if (index >= bindList.size() - 1)
        //    report(11111, "Translation of multiple binds in \"" + isaToken().vdmToken().toString() + "\" expression must not include the last bind (" + index + ").");
        //else
        //{
            assert index >= 0 && index < bindList.size() - 1;
            // first LPAREN is done externally
            if (index > 0)
            {
                sb.append(IsaToken.LPAREN.toString());
            }
            // translate the quantifier and the specific bind
            sb.append(isaToken().toString());
            sb.append(getFormattingSeparator());
            sb.append(bindList.get(index).translate());
            sb.append(getFormattingSeparator());
            sb.append(IsaToken.POINT.toString());
            sb.append(getFormattingSeparator());
            // do not translate predicate or RPAREN
        //}
        return sb.toString();
    }

    /**
     * Bounded binds translation requires care: it depends on what kind of bind (e.g., forall set bind can only have 1 variable),
     * and might need extra type invariant checks (e.g., type binds require check about it's invariant).
     */
    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.LPAREN.toString());
        int count = 0;
        if (foundNonTypeBinds())
        {
            for(; count < bindList.size(); count++)
            {
                sb.append(bindTranslate(count));
            }
        }
        else
        {
            sb.append(bindList.translate());
            sb.append(getFormattingSeparator());
        }
        boolean foundTypeBind = foundSomeTypeBinds();
        // if found type bind add implication to predicate and an extra parenthesis pair
        if (foundTypeBind)
        {
            sb.append(IsaToken.LPAREN.toString());
            count++;

            // type binds require invariant checks before the user predicate! 
            for(TRMultipleBind b : bindList)
            {
                if (b instanceof TRMultipleTypeBind)
                {
                    sb.append(b.invTranslate());
                    sb.append(b.getInvTranslateSeparator());
                }
            }
            
            sb.append(getFormattingSeparator());
            sb.append(IsaToken.IMPLIES.toString());
            sb.append(getFormattingSeparator());
        }
        sb.append(predicate.translate());
        // if one required bind went through, it will add its own LPAREN, so close the last;
        // if >1 was required, then we will need count-1 RPAREN closed please
        if (count > 1)
        {
            sb.append(IsaTemplates.replicate(IsaToken.RPAREN.toString(), count-1));
        }
        // final overal expression right parenthesis
        sb.append(IsaToken.RPAREN.toString());
        return sb.toString();
    }

    /**
     * If any bind is not type bind, requires multiple quantifiers and parenthesis 
     * @return
     */
	private boolean foundNonTypeBinds() {
        for(TRMultipleBind b : bindList)
        {
            if (!(b instanceof TRMultipleTypeBind))
                return true;
        }
        return false;
    }

    private boolean foundSomeTypeBinds() {
        for(TRMultipleBind b : bindList)
        {
            if (b instanceof TRMultipleTypeBind)
                return true;
        }
        return false;
    }

    @Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseBoundedExpression(this, arg);
	}
}
