package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCTupleExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRProductType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeList;

public class TRTupleExpression extends TREnumeratedExpression {
    
	private static final long serialVersionUID = 1L;

    public TRTupleExpression(LexLocation location, TCTupleExpression tc, TRExpressionList args, TRType exptype)
    {
        super(location, tc, args, exptype);
    }

    @Override
    protected TRType getBestGuessType()
    {
        return TRProductType.newProductType(location, TRTypeList.newTypeList(members));
    }

    @Override
    public IsaToken leftBracket() {
        return IsaToken.LPAREN;
    }

    @Override
    public IsaToken rightBracket() {
        return IsaToken.RPAREN;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.CROSSPROD;
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseTupleExpression(this, arg);
	}
}
