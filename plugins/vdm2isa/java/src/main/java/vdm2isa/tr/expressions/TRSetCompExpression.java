package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCSeqCompExpression;
import com.fujitsu.vdmj.tc.expressions.TCSetCompExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindList;

public class TRSetCompExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    private final TRExpression first;
    private final TRMultipleBindList binds;
    private final TRExpression predicate;

    public TRSetCompExpression(LexLocation location, 
        TRExpression first, TRMultipleBindList bindings, 
        TRExpression predicate)
    {
        super(location);
        this.first = first;
        this.binds = bindings;
        this.predicate = predicate;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.SET;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.SET_OPEN.toString());
        sb.append(" ");
        sb.append(first.translate());
        sb.append(" ");
        sb.append(IsaToken.POINT.toString());
        sb.append(" ");
        sb.append(binds.translate());
        if (predicate != null)
        {
            sb.append(" ");
            sb.append("|");
            sb.append(" ");
            sb.append(predicate.translate());
        }
        sb.append(" ");
        sb.append(IsaToken.SET_CLOSE.toString());
        return sb.toString();
    }

}
