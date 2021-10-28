package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.patterns.TCPattern;

import vdm2isa.tr.TRNode;

public abstract class TRPattern extends TRNode {
    
    private static final long serialVersionUID = 1L;

    public TRPattern(LexLocation location)
    {
        super(location);

    }
    
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

    /**
     * Patterns do not support invariant translation in general. Some type-bound patterns do and can extend this behaviour.
     */
    @Override
    public String invTranslate()
    {
        report(11111, "Pattern " + toString() + " does not support Isabelle invariant translation.");
        return "";
    }
}
