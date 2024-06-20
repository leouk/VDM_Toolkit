package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCUnionPattern;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyUnionPattern implements DafnyPattern {
    private TCUnionPattern pattern;
    

    public DafnyUnionPattern(TCUnionPattern pattern) {
        this.pattern = pattern;
    }

    @Override
    public TCPattern getVDM() {
        return pattern;
    }

    @Override
    public String translate() {
        return DafnyTemplates.PATTERNS.render("union", Pair.of("pattern", this));
    }
    
    public String getLeft() {
        return DafnyPattern.of(pattern.left).translate();
    }
    public String getRight() {
        return DafnyPattern.of(pattern.right).translate();
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
