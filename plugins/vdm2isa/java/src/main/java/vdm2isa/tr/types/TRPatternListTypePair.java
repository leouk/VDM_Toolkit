package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.patterns.TRPatternList;

public class TRPatternListTypePair extends TRNode 
{
    private static final long serialVersionUID = 1L;

    private final TRPatternList patterns;
    private final TRType type;

    public TRPatternListTypePair(TRPatternList patterns, TRType type) {
        super(type != null ? type.location : LexLocation.ANY);
        this.patterns = patterns;
        this.type = type;
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(patterns, type);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.TYPEOF;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(patterns.translate());
        sb.append(isaToken().toString());
        sb.append(type.translate());
        return IsaToken.parenthesise(sb.toString());
    }    

    public TRPatternList getPatternsList()
    {
        return this.patterns;
    } 

    public TRType getPatternListType()
    {
        return type;
    }
}
