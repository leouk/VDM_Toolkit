package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCCaseAlternative;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCTupleExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.types.TRType;

public class TRCaseAlternative extends TRExpression {
	
    private static final long serialVersionUID = 1L;
    public final TRPattern pattern;
    public final TRExpression result;
    private boolean casesTrueAlternative;

    private static TCTupleExpression figureOutCaseAlternative(TCCaseAlternative tc)
    {
        TCExpressionList args = new TCExpressionList();
        if (tc.cexp != null)
            args.add(tc.cexp);
        assert tc.result != null;
        args.add(tc.result);
        // ignore pattern for now. 
        TCTupleExpression result = new TCTupleExpression(tc.location, args);
        return result;
    }

    public TRCaseAlternative(LexLocation location, TCCaseAlternative tc, TRPattern pattern, TRExpression result) {
        super(location, figureOutCaseAlternative(tc), result != null ? result.getType() : TRExpression.unknownType(location));
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
    public String oldtranslate() {
        StringBuilder sb = new StringBuilder();
        sb.append(pattern.oldtranslate());
        sb.append(IsaToken.SPACE.toString());
        sb.append(isaToken().toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(result.patternContextTranslate(pattern));
        // no parenthesising per case, but on the overal case expression
        return casesTrueAlternative ? IsaToken.parenthesise(sb.toString()) : sb.toString();
    }

    public static final TRCaseAlternative newCaseAlternative(LexLocation location, TRPattern pattern, TRExpression resultExpr)
    {
        TCCaseAlternative tc = new TCCaseAlternative(null, pattern.getVDMPattern(), resultExpr.getVDMExpr());
        TRCaseAlternative result = new TRCaseAlternative(location, tc, pattern, resultExpr);
        TRNode.setup(result);
        return result;
    }
}
