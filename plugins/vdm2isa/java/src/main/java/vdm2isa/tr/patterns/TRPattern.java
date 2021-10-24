package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.tc.patterns.TCPattern;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;

public abstract class TRPattern extends TRNode {
    
    private static final long serialVersionUID = 1L;

    public TRPattern(TCPattern owner)
    {
        super(owner.location);
    }

    public TRPatternList getPatternList()
    {
        TRPatternList list = new TRPatternList();
        list.add(this);
        return list; 
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    public abstract String translate();
}
