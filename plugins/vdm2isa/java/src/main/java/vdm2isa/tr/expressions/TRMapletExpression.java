package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCMapType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRType;

public class TRMapletExpression extends TRExpression 
{
	private static final long serialVersionUID = 1L;
    protected final TRExpression left;
    protected final TRExpression right; 

    public TRMapletExpression(TRExpression left, TRExpression right)
    {
        super(left != null ? left.location : LexLocation.ANY, TRMapletExpression.getMapType(left, right));
        this.left = left;
        this.right = right;
    }

    @Override
    public void setup()
    {
        super.setup();
        assert getType() instanceof TRMapType;
        TRNode.setup(left, right);
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

    public static TRType getMapType(TRExpression left, TRExpression right) {
        TRType result = TRExpression.unknownType(LexLocation.ANY);
        if (left != null && left.getType() != null && left.getType().getVDMType() != null &&
            right != null && right.getType() != null && right.getType().getVDMType() != null)
        {
            result = new TRMapType(
              new TCMapType(left.location, left.getType().getVDMType(), right.getType().getVDMType()), 
                  new TRDefinitionList(), left.getType(), right.getType(), false);
        }
        return result; 
    }
}
