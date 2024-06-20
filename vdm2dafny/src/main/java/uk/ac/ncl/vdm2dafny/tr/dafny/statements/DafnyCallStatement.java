package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.statements.TCCallStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;

public class DafnyCallStatement extends DafnyStatement {
    private TCCallStatement stmt;
    private FlatEnvironment env;

    public DafnyCallStatement(TCCallStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("call", Pair.of("stmt", this));
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }

    public String getName() {
        return DafnyIdentifiers.instance().transform(stmt.name);
    }
    
    public List<String> getArgs() {
        return stmt.args.stream().map(arg -> DafnyExpression.of(arg, env)).map(exp -> exp.translate()).collect(Collectors.toList());
    }
}
