package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCProductType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRProductType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeList;

public class TRTupleExpression extends TREnumeratedExpression {
    
	private static final long serialVersionUID = 1L;

    public TRTupleExpression(LexLocation location, TRExpressionList args, TRType exptype)
    {
        super(location, args, exptype);
    }

    @Override
    protected TRType getBestGuessType()
    {
        TRTypeList typeList = TRTypeList.newTypeList(members);
        return new TRProductType(new TCProductType(location, typeList.getVDMTypeList()), new TRDefinitionList(), typeList);
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
