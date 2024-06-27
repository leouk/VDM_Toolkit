package uk.ac.ncl.vdm2dafny.tr.dafny.state;

import com.fujitsu.vdmj.tc.statements.TCMapSeqDesignator;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;

public class DafnyMapSeqStateDesignator extends DafnyStateDesignator {
    private TCMapSeqDesignator designator;

    public DafnyMapSeqStateDesignator(TCMapSeqDesignator designator, FlatEnvironment env) {
        super(env);
        this.designator = designator;
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("mapseqDesignator", Pair.of("designator", this));
    }
    
    public String getRoot() {
        return DafnyStateDesignator.of(designator.mapseq, env).translate();
    }

    public String getExp() {
        return DafnyExpression.of(designator.exp, env).translate();
    }
}
