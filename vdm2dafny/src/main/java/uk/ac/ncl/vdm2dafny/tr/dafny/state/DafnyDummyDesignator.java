package uk.ac.ncl.vdm2dafny.tr.dafny.state;

import com.fujitsu.vdmj.tc.statements.TCStateDesignator;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;

public class DafnyDummyDesignator extends DafnyStateDesignator {
    private TCStateDesignator designator;
    
    
    public DafnyDummyDesignator(TCStateDesignator designator, FlatEnvironment env) {
        super(env);
        this.designator = designator;
    }


    @Override
    public String translate() {
        DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, designator.location, "designator", designator.toString());
        return DafnyTemplates.MESSAGES.render(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P.format("designator", designator.toString()));
    }
}
