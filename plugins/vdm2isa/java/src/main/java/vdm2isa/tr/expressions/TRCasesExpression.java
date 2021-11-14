package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRBasicPattern;
import vdm2isa.tr.types.TRType;

public class TRCasesExpression extends TRExpression {

	private static final long serialVersionUID = 1L;
    private final TRExpression exp;
    private final TRCaseAlternativeList cases;

    public TRCasesExpression(LexLocation location, TRExpression exp, TRCaseAlternativeList cases, TRExpression others, TRType exptype) {
        super(location, exptype);
        this.exp = exp;
        this.cases = cases;
        // add others as a case alternative
        if (others != null)
        {
            this.cases.add(new TRCaseAlternative(location, TRBasicPattern.underscore(location), others));
        }
    }

    @Override 
    public String toString()
    {
        return "case " + String.valueOf(exp) + " of " + String.valueOf(cases);
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseCaseExpression(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.CASE;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        warning(IsaWarningMessage.ISA_CASES_PATTERN_LIMITATION);
        sb.append(IsaToken.comment(IsaWarningMessage.ISA_CASES_PATTERN_LIMITATION.message, getFormattingSeparator()));

        sb.append(isaToken().toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(exp.translate());
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.OF.toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(cases.translate());
        
        return IsaToken.parenthesise(sb.toString());
    }
    
}
