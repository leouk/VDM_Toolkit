package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.statements.TCIfStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;

public class DafnyIfStatement extends DafnyStatement {
    private final TCIfStatement stmt;
    private final FlatEnvironment env;

    public DafnyIfStatement(TCIfStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
    }

    public String getIfExp() {
        return DafnyExpression.of(stmt.ifExp, env).translate();
    }

    public String getIfBody() {
        return DafnyStatement.of(stmt.thenStmt, env).translate();
    }
    
    public List<String> getElseIfs() {
        return stmt.elseList.stream().map(elseif -> DafnyStatement.of(elseif, env).translate()).collect(Collectors.toList());
    }

    public boolean hasElses() {
        return stmt.elseStmt != null;
    }

    public String getElseBody() {
        assert hasElses();
        return DafnyStatement.of(stmt.elseStmt, env).translate();
    }


    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("ifthenelse", Pair.of("stmt", this));
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }
    
}
