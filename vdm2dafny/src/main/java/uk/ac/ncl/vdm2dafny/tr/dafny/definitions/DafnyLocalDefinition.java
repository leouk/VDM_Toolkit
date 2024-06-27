package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCLocalDefinition;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyLocalDefinition extends DafnyDefinition {
    public TCDefinition localDef;
    private String type; 
    private String name;
    private DafnyValueDefinition valueDef;

    public DafnyLocalDefinition(TCDefinition localDef) {
        assert check(localDef);
        TCLocalDefinition ldef = (TCLocalDefinition)localDef;
        name = DafnyIdentifiers.instance().transform(ldef.name);
        type = DafnyTypeNames.instance().getTypeName(ldef.type);
        valueDef = new DafnyValueDefinition(ldef.valueDefinition);
    } 

    private boolean check(TCDefinition def) {
        return (def instanceof TCLocalDefinition);    
    }

    @Override
    public String translate() {
        return DafnyTemplates.DEFINITIONS.render("let", Pair.of("def", this));
    }

    @Override
    public TCDefinition getVDM() {
        return localDef;
    }

    @Override
    public boolean isLocal() {
        return true;
    }

    public String getType() {
        return type;
    }

    public String getName() {
        return name;
    }

    public String getValueDef() {
        return valueDef.translate();
    }

    public String getPattern () {
        return getName() + ": " + getType();
    }
    
}
