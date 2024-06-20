package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import com.fujitsu.vdmj.tc.statements.TCErrorStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;

public class DafnyErrorStatement extends DafnyStatement {
    public TCErrorStatement err;

    public DafnyErrorStatement(TCErrorStatement err, FlatEnvironment env) {
        this.err = err;
    }

    @Override
    public String translate() {
        DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, err.location, "operation", err.getClass().getSimpleName());
        // just translate comments
        return DafnyTemplates.STATEMENTS.render("comment", Pair.of("obj", this));
    }

    @Override
    public TCStatement getVDM() {
        return err;
    }
    
}
