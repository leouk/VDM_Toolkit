package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.statements.TCDefStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyDefinition;

public class DafnyDefineStatement extends DafnyStatement {
    private TCDefStatement stmt;
    private FlatEnvironment env;
    private List<DafnyDefinition> defs;
    private DafnyStatement in;
    
    public DafnyDefineStatement(TCDefStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
        defs = DafnyDefinition.from(stmt.equalsDefs, env);
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
