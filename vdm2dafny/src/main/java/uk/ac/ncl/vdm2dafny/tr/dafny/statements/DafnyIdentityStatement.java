package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import com.fujitsu.vdmj.tc.statements.TCSkipStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyIdentityStatement extends DafnyStatement {
    private TCSkipStatement stmt;
    
    public DafnyIdentityStatement(TCSkipStatement stmt) {
        this.stmt = stmt;
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("skip", Pair.of("stmt", this));
    }

    @Override
    public TCStatement getVDM() {
        return stmt;
    }
    
}
