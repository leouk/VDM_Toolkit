package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import com.fujitsu.vdmj.tc.patterns.TCMapUnionPattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyMapUnionPattern implements DafnyPattern {
    private TCMapUnionPattern pattern;
    

    public DafnyMapUnionPattern(TCMapUnionPattern pattern) {
        this.pattern = pattern;
    }

    @Override
    public TCPattern getVDM() {
        return pattern;
    }

    @Override
    public String translate() {
        return DafnyTemplates.PATTERNS.render("munion", Pair.of("pattern", this));
    }
    
    public String getLeft() {
        return DafnyPattern.of(pattern.left).translate();
    }
    public String getRight() {
        return DafnyPattern.of(pattern.right).translate();
    }

    @Override
    public boolean invalidAssignmentPattern() {
        return false;
    }

    @Override
    public boolean invalidCase() {
        return true;
    }
}
