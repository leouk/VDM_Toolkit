package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.tr.TRNode;

public abstract class TRPattern extends TRNode {
    
    public TRPattern(LexLocation location)
    {
        super(location);
    }

    public TRPatternList getPatternList()
    {
        TRPatternList list = new TRPatternList();
        list.add(this);
        return list; 
    }
}
