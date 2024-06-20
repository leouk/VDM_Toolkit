package uk.ac.ncl.vdm2dafny.tr.dafny.state;

import com.fujitsu.vdmj.tc.statements.TCFieldDesignator;
import com.fujitsu.vdmj.tc.statements.TCIdentifierDesignator;
import com.fujitsu.vdmj.tc.statements.TCMapSeqDesignator;
import com.fujitsu.vdmj.tc.statements.TCStateDesignator;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;

public abstract class DafnyStateDesignator extends AbstractDafnyNode {
    protected FlatEnvironment env;
    public DafnyStateDesignator(FlatEnvironment env) {
        this.env = env;
    }


    public static DafnyStateDesignator of(TCStateDesignator designator, FlatEnvironment env) {
        if (designator instanceof TCFieldDesignator) {
            return new DafnyFieldStateDesignator((TCFieldDesignator)designator, env);
        }
        else if (designator instanceof TCIdentifierDesignator) {
            return new DafnyIdentifierStateDesignator((TCIdentifierDesignator)designator, env);
        }
        else if (designator instanceof TCMapSeqDesignator) {
            return new DafnyMapSeqStateDesignator((TCMapSeqDesignator)designator, env);
        }
        return new DafnyDummyDesignator(designator, env);
    }
}
