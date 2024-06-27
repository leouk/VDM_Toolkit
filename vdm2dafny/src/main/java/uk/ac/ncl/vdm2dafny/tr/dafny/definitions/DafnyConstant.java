package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import com.fujitsu.vdmj.tc.definitions.TCValueDefinition;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyConstant extends DafnyValueDefinition {

    public DafnyConstant(TCValueDefinition valueDef) {
        super(valueDef);
        // Check no patterns now.
    }

    @Override
    public String translate() {
        return DafnyTemplates.DEFINITIONS.render("const", Pair.of("decl", this));
    }
    
}
