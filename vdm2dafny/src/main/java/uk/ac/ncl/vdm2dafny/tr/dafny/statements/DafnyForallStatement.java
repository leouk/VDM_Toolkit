package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import com.fujitsu.vdmj.tc.statements.TCForAllStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyPattern;

public class DafnyForallStatement extends DafnyStatement {
    private TCForAllStatement stmt;
    private FlatEnvironment env;

    public DafnyForallStatement(TCForAllStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("forall", Pair.of("stmt", this));
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }
    
    public String getNames() {
        return DafnyPattern.of(stmt.pattern).getVariables();
    }

    public String getBind() {
        return DafnyPattern.of(stmt.pattern).translate();
    }
    
    public String getDo() {
        return DafnyStatement.of(stmt.statement, env).translate();
    }
    
    public String getStatement() {
        return DafnyStatement.of(stmt.statement, env).translate();
    }
}
