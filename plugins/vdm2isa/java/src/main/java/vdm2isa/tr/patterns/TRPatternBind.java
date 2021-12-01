package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.patterns.TCPatternBind;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;

public class TRPatternBind extends TRPattern {
    
    private final TRPattern pattern;
    private final TRMultipleBind bind;

    public TRPatternBind(TCPatternBind p, LexLocation location, TRPattern pattern, TRMultipleBind bind)
    {
        super(p != null ? p.pattern : null, location);
        this.pattern = pattern;
        this.bind = bind;

    }
    
    @Override
    public void setup()
    {
        super.setup();
        if (pattern == null && bind == null)
        {
            report(IsaErrorMessage.VDMSL_INVALID_PATTERN_BIND);
        }
        TRNode.setup(pattern, bind);
        System.out.println(toString());
    }

    @Override
    public String toString()
    {
        return super.toString() + 
            "\n\t pattern = " + patternTranslate() + //(pattern != null ? pattern.translate() : "null") +
            "\n\t bind    = " + String.valueOf(bind); // (bind != null ? bind.translate() : "null");
    }

    @Override
    public String patternTranslate()
    {
        return pattern.patternTranslate();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String translate() {
        return (pattern != null ? pattern.translate() : (bind != null ? bind.translate() : ""));
    }

    @Override
    public <R, S> R apply(TRPatternVisitor<R, S> visitor, S arg) {
        return visitor.casePatternBind(this, arg);
    }
}
