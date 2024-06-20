package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import com.fujitsu.vdmj.tc.statements.TCElseIfStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;

public class DafnyElseIfStatement extends DafnyStatement {
    private TCElseIfStatement stmt;
    private FlatEnvironment env;

    public DafnyElseIfStatement(TCElseIfStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("elseif", Pair.of("stmt", this));
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }
    
    public String getCondition() {
        return DafnyExpression.of(stmt.elseIfExp, env).translate();
    }
    public String getBody() {
        return DafnyStatement.of(stmt.thenStmt, env).translate();
    }
}
