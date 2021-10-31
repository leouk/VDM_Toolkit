package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRElseIfExpression extends TRExpression {
    
    private final TRExpression elseIfExp;
    private final TRExpression thenExp;

    public TRElseIfExpression(LexLocation location, TRExpression elseIfExp, TRExpression thenExp)
    {
        super(location);
        this.elseIfExp = elseIfExp;
        this.thenExp = thenExp;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.ELSEIF;
    }
    
    @Override
    public String translate() {
		StringBuilder sb = new StringBuilder();
        sb.append(getFormattingSeparator());
		sb.append(isaToken().toString());
		sb.append(" ");
		sb.append(IsaToken.parenthesise(elseIfExp.translate()));
		sb.append(" ");
		sb.append(IsaToken.THEN.toString());
		sb.append(getFormattingSeparator());
		sb.append(IsaToken.parenthesise(thenExp.translate()));
		return sb.toString();
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseElseIfExpression(this, arg);
    }
}
