package vdm2isa.tr.patterns;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRType;

public class TRMultipleTypeBind extends TRMultipleBind {
    
    private static final long serialVersionUID = 1L;

    private TRType type;

    public TRMultipleTypeBind(TRPattern pattern, TRType type)
    {
        this(pattern.getPatternList(), type);
    }

    public TRMultipleTypeBind(TRPatternList plist, TRType type)
    {
        super(plist);
        this.type = type;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.INSET;
    }

    @Override
    //TODO this will be tricky, because it has to be on the declared variable type? 
    public String translate() {
        return IsaToken.parenthesise(IsaToken.parenthesise(plist.translate()) + IsaToken.TYPEOF + type.translate()); 
    }
}
