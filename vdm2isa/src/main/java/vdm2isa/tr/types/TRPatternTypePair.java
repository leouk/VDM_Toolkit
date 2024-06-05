package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.patterns.TRPattern;

public class TRPatternTypePair extends TRNode 
{
    private static final long serialVersionUID = 1L;

    private final TRPattern pattern;
    private final TRType type;

    public TRPatternTypePair(TRPattern pattern, TRType type) {
        super(pattern != null ? pattern.location : LexLocation.ANY);
        this.pattern = pattern;
        this.type = type;
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(pattern, type);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.TYPEOF;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(pattern.translate());
        sb.append(isaToken().toString());
        sb.append(type.translate());
        return IsaToken.parenthesise(sb.toString());
    }

    public TRPattern getPattern()
    {
        return pattern;
    }

    public TRType getType()
    {
        return type;
    }
}
