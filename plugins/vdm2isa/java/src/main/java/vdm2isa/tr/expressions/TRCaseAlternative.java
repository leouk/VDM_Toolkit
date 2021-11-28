package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.types.TRType;

public class TRCaseAlternative extends TRExpression {
	
    private static final long serialVersionUID = 1L;
    private final TRPattern pattern;
    private final TRExpression result;
    private boolean casesTrueAlternative;

    public TRCaseAlternative(LexLocation location, TRPattern pattern, TRExpression result) {
        super(location, result != null ? result.getType() : TRExpression.unknownType(location));
        this.pattern = pattern;
        this.result = result;
        this.casesTrueAlternative = false;
    }    

    @Override 
    public void setup()
    {
        super.setup();
        TRNode.setup(pattern, result);
    }

    @Override
    protected TRType getBestGuessType()
    {
        return result.getType();
    }

    @Override 
    public String toString()
    {
        return String.valueOf(pattern) + " " + isaToken().toString() + " " + String.valueOf(result);
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseCaseAlternative(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return casesTrueAlternative ? IsaToken.IMPLIES : IsaToken.FUN;
    }

    protected void setCasesTrueAlternative(boolean b)
    {
        this.casesTrueAlternative = b;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(pattern.translate());
        sb.append(IsaToken.SPACE.toString());
        sb.append(isaToken().toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(result.recordPatternTranslate(pattern));
        // no parenthesising per case, but on the overal case expression
        return casesTrueAlternative ? IsaToken.parenthesise(sb.toString()) : sb.toString();
    }
}
