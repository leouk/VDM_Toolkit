package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import com.fujitsu.vdmj.tc.patterns.TCExpressionPattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;

import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;

public class DafnyExpressionPattern implements DafnyPattern {
    private TCExpressionPattern pat;
    
    
    public DafnyExpressionPattern(TCExpressionPattern pat) {
        this.pat = pat;
    }

    @Override
    public TCPattern getVDM() {
        return pat;
    }

    @Override
    public String translate() {
        return DafnyExpression.of(pat.exp, DafnyEnvironment.instance().globalEnv()).translate();
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
