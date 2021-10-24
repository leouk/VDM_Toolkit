package vdm2isa.tr.patterns;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.TRExpression;

public class TRMultipleSeqBind extends TRMultipleBind 
{
    private static final long serialVersionUID = 1L;

    private TRExpression seq;

    public TRMultipleSeqBind(TRPattern pattern, TRExpression set)
    {
        this(pattern.getPatternList(), set);
    }

    public TRMultipleSeqBind(TRPatternList plist, TRExpression seq)
    {
        super(plist);
        this.seq = seq;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.INSET;
    }

    @Override
    public String translate() {
        return plist.translate() + " " + isaToken().toString() + " " + 
            IsaToken.parenthesise(IsaToken.ELEMS.toString() + " " + seq.translate());
    }
}
