package uk.ac.ncl.vdm2dafny.tr.dafny.state;

import com.fujitsu.vdmj.tc.statements.TCIdentifierDesignator;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;

public class DafnyIdentifierStateDesignator extends DafnyStateDesignator {
    private TCIdentifierDesignator designator;

    public DafnyIdentifierStateDesignator(TCIdentifierDesignator designator, FlatEnvironment env) {
        super(env);
        this.designator = designator;
    }

    @Override
    public String translate() {
        return DafnyIdentifiers.instance().transform(designator.name);
    }
    
}
