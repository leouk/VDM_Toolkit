package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.statements.TCLetDefStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyDefinition;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyLocalDefinition;

public class DafnyLetStatement extends DafnyStatement {
    private TCLetDefStatement stmt;
    private FlatEnvironment env;
    private List<DafnyDefinition> defs;
    private DafnyStatement in;

    public DafnyLetStatement(TCLetDefStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
        defs = DafnyLocalDefinition.from(stmt.localDefs, env);
        in = DafnyStatement.of(stmt.statement, env);
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("def", Pair.of("stmt", this));
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }

    public List<String> getDefs() {
        return defs.stream().map(d -> d.translate()).collect(Collectors.toList());
    }

    public String getIn() {
        return in.translate();
    }
}
