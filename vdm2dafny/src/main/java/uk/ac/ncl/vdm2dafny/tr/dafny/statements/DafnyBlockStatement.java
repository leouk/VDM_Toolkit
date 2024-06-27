package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.statements.TCBlockStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.DafnyVDMComment;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyDefinition;

public class DafnyBlockStatement extends DafnyStatement {
    private TCBlockStatement stmt;
    private FlatEnvironment env;

    public DafnyBlockStatement(TCBlockStatement stmt, FlatEnvironment env) {
        this.stmt = stmt;
        this.env = env;
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("block", Pair.of("stmt", this));
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }

    public List<DafnyVDMComment> getDeclarationComments() {
        return stmt.assignmentDefs.stream().flatMap(def -> def.comments.stream().map(comment -> new DafnyVDMComment(comment))).collect(Collectors.toList());
    }

    public List<String> getDeclarations() {
        return DafnyDefinition.from(stmt.assignmentDefs, env).stream().map(d -> d.translate()).collect(Collectors.toList());
    }

    public List<String> getStatements() {
        return stmt.statements.stream().map(s -> DafnyStatement.of(s, env).translate()).collect(Collectors.toList());
    }

}
