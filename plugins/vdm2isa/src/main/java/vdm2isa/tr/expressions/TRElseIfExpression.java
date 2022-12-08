package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCElseIfExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeSet;
import vdm2isa.tr.types.TRUnionType;

public class TRElseIfExpression extends TRExpression {
    
    public final TRExpression elseIfExp;
    public final TRExpression thenExp;

    public TRElseIfExpression(LexLocation location, TCElseIfExpression tc, TRExpression elseIfExp, TRExpression thenExp, TRType exptype)
    {
        super(location, tc, exptype);
        this.elseIfExp = elseIfExp;
        this.thenExp = thenExp;
    }

    public TCElseIfExpression getVDMElseIfExpression()
    {
        return (TCElseIfExpression)getVDMExpr();
    }

    @Override 
    public void setup()
    {
        super.setup();
        TRNode.setup(elseIfExp, thenExp);
    }

    /**
	 * Choose the then type, is the resulting type (could not have been else); this is to attempt to solve the "(the (pattern))" problem
	 */
	@Override
	protected TRType getBestGuessType()
	{
        //NB what is the right VDM type for the elseif union?
        return TRUnionType.newUnionType(location, new TRTypeSet(thenExp.getType(), elseIfExp.getType()));
	}

    @Override
    public IsaToken isaToken() {
        return IsaToken.ELSEIF;
    }
    
    @Override
    public String oldtranslate() {
		StringBuilder sb = new StringBuilder();
        sb.append(getFormattingSeparator());
		sb.append(isaToken().toString());
		sb.append(" ");
		sb.append(IsaToken.parenthesise(elseIfExp.oldtranslate()));
		sb.append(" ");
		sb.append(IsaToken.THEN.toString());
		sb.append(getFormattingSeparator());
		sb.append(IsaToken.parenthesise(thenExp.oldtranslate()));
		return sb.toString();
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseElseIfExpression(this, arg);
    }
}
