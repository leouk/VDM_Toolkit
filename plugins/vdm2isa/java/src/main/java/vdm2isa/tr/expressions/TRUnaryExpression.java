package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCAbsoluteExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;

//@todo uncertain whether to have unique cases or not, like in the "literal" sense. 
public class TRUnaryExpression extends TRExpression {

    private static final long serialVersionUID = 1L;

    protected final TCExpression owner;
	protected final TRExpression exp;

	public TRUnaryExpression(TCAbsoluteExpression owner, TRExpression exp)
	{
		super(owner.location);
        this.owner = owner;
		this.exp = exp;
	}

    @Override
    public String translate() 
    {
        return IsaTemplates.tokenise(isaToken(), location, exp);
    }

    @Override
    public IsaToken isaToken() 
    {
        if (owner instanceof TCAbsoluteExpression)
            return IsaToken.ABS;
        else
			throw new RuntimeException("Invalid VDM unary expression " + owner.getClass().getName() + " = " + owner.toString());
    }
}