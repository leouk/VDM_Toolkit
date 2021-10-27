package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCSeqCompExpression;
import com.fujitsu.vdmj.tc.expressions.TCSetCompExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindList;

public class TRCompExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    private final TRExpression first;
    private final TRMultipleBindList binds;
    private final TRExpression predicate;
    private final boolean set; 

    public TRCompExpression(TCSetCompExpression owner, 
        TRExpression first, TRMultipleBindList bindings, 
        TRExpression predicate)
    {
        super(owner.location);
        this.first = first;
        this.binds = bindings;
        this.predicate = predicate;
        this.set = true;
    }

    public TRCompExpression(TCSeqCompExpression owner, 
        TRExpression first, TRMultipleBind bind, TRExpression predicate)
    {
        super(owner.location);
        this.first = first;
        this.binds = bind.getMultipleBindList();
        this.predicate = predicate;
        this.set = false;
    }

    @Override
    public IsaToken isaToken() {
        return set ? IsaToken.SET : IsaToken.SEQ;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(set ? IsaToken.SET_OPEN.toString() : IsaToken.SEQ_OPEN.toString());
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
        sb.append(set ? IsaToken.SET_CLOSE.toString() : IsaToken.SEQ_CLOSE.toString());
        return sb.toString();
    }

}
