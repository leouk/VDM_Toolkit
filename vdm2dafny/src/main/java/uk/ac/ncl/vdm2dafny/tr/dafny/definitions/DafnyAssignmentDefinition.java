package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import com.fujitsu.vdmj.tc.definitions.TCAssignmentDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;
import com.fujitsu.vdmj.typechecker.NameScope;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;

public class DafnyAssignmentDefinition extends DafnyDefinition {
    private TCAssignmentDefinition def;
    private String type; 
    private String name;
    private DafnyExpression value;

    public DafnyAssignmentDefinition(TCAssignmentDefinition def, FlatEnvironment env) {
        this.def = def;
        name = DafnyIdentifiers.instance().transform(def.name);
        type = DafnyTypeNames.instance().getTypeName(def.type);
        value = DafnyExpression.of(def.expression, env);
    }

    @Override
    public String translate() {
        return DafnyTemplates.DEFINITIONS.render("assign", Pair.of("def", this));
    }

    @Override
    public TCDefinition getVDM() {
        return def;
    }

    @Override
    public boolean isLocal() {
        return def.nameScope.equals(NameScope.LOCAL);
    }

    public String getName() {
        return name;
    }
    
    public String getType() {
        return type;
    }

    public String getValue () {
        return value.translate();
    }

}
