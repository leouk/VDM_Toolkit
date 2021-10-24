package vdm2isa.tr.patterns;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.TRExpression;

public class TRMultipleSetBind extends TRMultipleBind 
{
    private static final long serialVersionUID = 1L;

    private TRExpression set;

    public TRMultipleSetBind(TRPattern pattern, TRExpression set)
    {
        this(pattern.getPatternList(), set);
    }

    public TRMultipleSetBind(TRPatternList plist, TRExpression set)
    {
        super(plist);
        this.set = set;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.INSET;
    }

    @Override
    public String translate() {
        return plist.translate() + " " + isaToken().toString() + " " + set.translate();
    }
}
