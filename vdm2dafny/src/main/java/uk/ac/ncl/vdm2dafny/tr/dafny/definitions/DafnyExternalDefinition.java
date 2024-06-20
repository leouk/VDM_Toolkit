package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.stream.Collectors;

import com.fujitsu.vdmj.lex.Token;
import com.fujitsu.vdmj.tc.TCNode;
import com.fujitsu.vdmj.tc.statements.TCExternalClause;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;

public class DafnyExternalDefinition extends AbstractDafnyNode {
    private TCExternalClause clause;

    
    public DafnyExternalDefinition(TCExternalClause clause) {
        this.clause = clause;
    }

    @Override
    public String translate() {
        return DafnyTemplates.DEFINITIONS.render("externals", Pair.of("clause", this));
    }

    public String getMode() {
        return  clause.mode.is(Token.WRITE) ? "modifies"
            :   clause.mode.is(Token.READ)  ? "reads"
            :   "unknown clause";
    }

    public String getIdentifiers() {
        return clause.identifiers.stream()
            .map(id -> DafnyIdentifiers.instance().transform(id))
            .collect(Collectors.joining(", "));
    }

    public TCNode getVDM() {
        return clause;
    }
}
