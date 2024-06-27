package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import java.util.ArrayList;
import java.util.List;

import com.fujitsu.vdmj.tc.statements.TCAssignmentStatement;
import com.fujitsu.vdmj.tc.statements.TCAtomicStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;
import uk.ac.ncl.vdm2dafny.tr.dafny.state.DafnyStateDesignator;

public class DafnyAtomicStatement extends DafnyStatement{
    private TCAtomicStatement stmt;
    private FlatEnvironment env;

    public DafnyAtomicStatement(TCAtomicStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("atomic", Pair.of("stmt", this));
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }

    public List<String> getLhs() {
        List<String> lhs = new ArrayList<>();
        for (TCAssignmentStatement ass : stmt.assignments) {
            lhs.add(DafnyStateDesignator.of(ass.target, env).translate());
        }
        return lhs;
    }

    public List<String> getRhs() {
        List<String> rhs = new ArrayList<>();
        for (TCAssignmentStatement ass : stmt.assignments) {
            rhs.add(DafnyExpression.of(ass.exp, env).translate());
        }
        return rhs;
    }
}
