package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCMapletExpression;
import com.fujitsu.vdmj.tc.expressions.TCTupleExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRType;

public class TRMapletExpression extends TRExpression 
{
	private static final long serialVersionUID = 1L;
    public final TCMapletExpression maplet;
    public final TRExpression left;
    public final TRExpression right; 

    //@NB why isn't maplet expression in TCExpression?
    private static TCTupleExpression figureOutMapletExpression(TCMapletExpression exp)
    {
        TCExpressionList args = new TCExpressionList();
        args.add(exp.left);
        args.add(exp.right);
        TCTupleExpression result = new TCTupleExpression(exp.location, args);
        return result; 
    }

    public TRMapletExpression(TCMapletExpression exp, TRExpression left, TRExpression right)
    {
        super(left != null ? left.location : LexLocation.ANY, 
            figureOutMapletExpression(exp), 
            TRMapletExpression.getMapType(left, right));
        this.maplet = exp;
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
        return TRMapType.newMapType(left.getType(), right.getType(), false);
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

    public static final TRType getMapType(TRExpression left, TRExpression right) {
        TRType result = TRExpression.unknownType(LexLocation.ANY);
        if (left != null && left.getType() != null && left.getType().getVDMType() != null &&
            right != null && right.getType() != null && right.getType().getVDMType() != null)
        {
            result = TRMapType.newMapType(left.getType(), right.getType(), false);
        }
        TRNode.setup(result);
        return result; 
    }
}
