package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import com.fujitsu.vdmj.tc.statements.TCAssignmentStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;
import uk.ac.ncl.vdm2dafny.tr.dafny.state.DafnyStateDesignator;

public class DafnyAssignStatement extends DafnyStatement {
    private TCAssignmentStatement stmt;
    private FlatEnvironment env;

    public DafnyAssignStatement(TCAssignmentStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("assign", Pair.of("stmt", this));
    }

    public String getStateDesignator() {
        return DafnyStateDesignator.of(stmt.target, env).translate();
    }

    public String getExp() {
        return DafnyExpression.of(stmt.exp, env).translate();
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }
}
