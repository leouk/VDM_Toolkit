package uk.ac.ncl.vdm2dafny.tr.dafny.state;

import com.fujitsu.vdmj.tc.statements.TCFieldDesignator;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;

public class DafnyFieldStateDesignator extends DafnyStateDesignator {
    private TCFieldDesignator designator;

    public DafnyFieldStateDesignator(TCFieldDesignator designator, FlatEnvironment env) {
        super(env);
        this.designator = designator;
    }

    @Override
    public String translate() {
        return DafnyIdentifiers.instance().transform(designator.field)
            + "." + DafnyStateDesignator.of(designator.object, env).translate();
    }
}
