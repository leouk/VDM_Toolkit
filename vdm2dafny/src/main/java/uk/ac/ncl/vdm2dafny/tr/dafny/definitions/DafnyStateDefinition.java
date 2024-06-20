package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;


import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCStateDefinition;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;

public class DafnyStateDefinition extends DafnyDefinition {
    private TCStateDefinition state;
    // private DafnyFunctionDefinition invdef;
    // private DafnyFunctionDefinition initdef;
    // private List<DafnyField> fields;
    
    public DafnyStateDefinition(TCStateDefinition state) {
        this.state = state;
        DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, state.location, "definition", state.getClass().getSimpleName());
        // this.invdef = new DafnyFunctionDefinition(state.invdef);
        // this.initdef = new DafnyFunctionDefinition(state.initdef);
        // this.fields = state.fields.stream().map(field -> new DafnyField(field, DafnyEnvironment.instance().globalEnv())).collect(Collectors.toList());
    }

    @Override
    public String translate() {
        return DafnyTemplates.MESSAGES.render("error", 
            Pair.of("type", "state"), 
            Pair.of("message", DafnyErrorMessage.DAFNY_UNSUPPORTED_2P.format("definition", state.getClass().getSimpleName()))
        );
    }

    @Override
    public TCDefinition getVDM() {
        return state;
    }

    @Override
    public boolean isLocal() {
        return false;
    }

    @Override
    public String getName() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getName'");
    }
    
}
