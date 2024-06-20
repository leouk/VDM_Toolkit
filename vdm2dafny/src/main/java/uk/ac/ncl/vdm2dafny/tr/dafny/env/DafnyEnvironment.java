package uk.ac.ncl.vdm2dafny.tr.dafny.env;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

public class DafnyEnvironment {
    private static DafnyEnvironment INSTANCE = null;
    private String currentlyWorkingIn;
    private DafnyEnvironment() {}
    
    private FlatEnvironment env = new FlatEnvironment(new TCDefinitionList());

    public static final DafnyEnvironment instance() {
        if (INSTANCE == null)
            INSTANCE = new DafnyEnvironment();
        return INSTANCE;
    }

    public FlatEnvironment globalEnv() {
        return env;
    }

    public FlatEnvironment addToEnv(TCDefinition def) {
        env.add(def);
        return env;
    }

    public void setWorkingLocation(String newLocation) {
        currentlyWorkingIn = newLocation;
    }
    
    public String getModule() {
        return currentlyWorkingIn;
    }

    public boolean sameModule(TCNameToken tok) {
        return tok.getModule().equals(currentlyWorkingIn);
    }
}
