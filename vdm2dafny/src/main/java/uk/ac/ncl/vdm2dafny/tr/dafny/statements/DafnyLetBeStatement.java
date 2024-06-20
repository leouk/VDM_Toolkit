package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.statements.TCLetBeStStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyMultipleBind;

public class DafnyLetBeStatement extends DafnyStatement {
    private TCLetBeStStatement stmt;
    private FlatEnvironment env;
    private List<String> vars;
    private List<DafnyMultipleBind> bind;
    private DafnyExpression suchThat;
    private DafnyStatement in;

    public DafnyLetBeStatement(TCLetBeStStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
        vars = stmt.def.getVariableNames().stream()
            .map(v -> DafnyIdentifiers.instance().transform(v))
            .collect(Collectors.toList());
        bind = DafnyMultipleBind.of(stmt.def, env);
        suchThat = DafnyExpression.of(stmt.suchThat, env);
        in = DafnyStatement.of(stmt.statement, env);
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("letbest", Pair.of("stmt", this));
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }

    public List<String> getVars() {
        return vars;
    }

    public List<String> getBind() {
        return bind.stream().map(d -> d.translate()).collect(Collectors.toList());
    }

    public String getSuchThat() {
        return suchThat.translate();
    }

    public String getIn() {
        return in.translate();
    }
}