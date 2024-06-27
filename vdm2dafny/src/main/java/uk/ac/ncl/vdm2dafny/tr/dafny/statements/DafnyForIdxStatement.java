package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import com.fujitsu.vdmj.tc.statements.TCForIndexStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;

public class DafnyForIdxStatement extends DafnyStatement {
    private TCForIndexStatement stmt;
    private FlatEnvironment env;

    public DafnyForIdxStatement(TCForIndexStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("forIdx", Pair.of("stmt", this));
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }
    
    public String getIteratorName() {
        return DafnyIdentifiers.instance().transform(stmt.var);
    }
    
    public String getFrom() {
        return DafnyExpression.of(stmt.from, env).translate();
    }
    
    public String getTo() {
        return DafnyExpression.of(stmt.to, env).translate();
    }
    
    public String getStatement() {
        return DafnyStatement.of(stmt.statement, env).translate();
    }
}
