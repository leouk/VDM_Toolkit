package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.types.TCMapType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRType;

public class TRMapletExpression extends TRExpression 
{
	private static final long serialVersionUID = 1L;
    private final TRExpression left;
    private final TRExpression right; 

    public TRMapletExpression(TRExpression left, TRExpression right)
    {
        super(left.location, 
            new TRMapType(
                new TCMapType(left.location, left.getType().getVDMType(), right.getType().getVDMType()), 
                new TRDefinitionList(), left.getType(), right.getType(), false));
        this.left = left;
        this.right = right;
    }

    @Override
    protected TRType getBestGuessType()
    {
        return new TRMapType(exptype.getVDMType(), new TRDefinitionList(), left.getType(), right.getType(), false);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.MAPLET;
    }

    @Override
    public String translate() {
        //@todo add spacing control on the Isa token?
        return left.translate() + isaToken().toString() + right.translate();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMapletExpression(this, arg);
	}
}
