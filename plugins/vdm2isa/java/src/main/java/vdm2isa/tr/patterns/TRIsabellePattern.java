package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;

public class TRIsabellePattern extends TRPattern {
    
    private static final long serialVersionUID = 1L;

    private final String pattern;

    public TRIsabellePattern(TCIdentifierPattern owner)
    {
        super(owner);
        this.pattern = owner.toString();
    }

    @Override
    public String translate() {
        return pattern;
    }

}
