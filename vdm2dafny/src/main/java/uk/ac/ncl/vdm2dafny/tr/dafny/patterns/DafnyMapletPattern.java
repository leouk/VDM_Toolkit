package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import com.fujitsu.vdmj.tc.patterns.TCMapletPattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyMapletPattern implements DafnyPattern {
    private TCMapletPattern pattern;

    public DafnyMapletPattern(TCMapletPattern pattern) {
        this.pattern = pattern;
    }

    @Override
    public TCPattern getVDM() {
        return pattern;
    }

    @Override
    public String translate() {
        return DafnyTemplates.PATTERNS.render("maplet", Pair.of("pattern", this));
    }

    public String getFrom() {
        return DafnyPattern.of(pattern.from).translate();
    }
    
    public String getTo() {
        return DafnyPattern.of(pattern.to).translate();
    }

    @Override
    public boolean invalidAssignmentPattern() {
        return true;
    }

    @Override
    public boolean invalidCase() {
        return true;
    }

}
