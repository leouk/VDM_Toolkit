package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCEqualsDefinition;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;
import com.fujitsu.vdmj.typechecker.NameScope;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyPattern;

public class DafnyEqualsDefinition extends DafnyDefinition {
    private TCEqualsDefinition def;

    private List<String> names;
    private DafnyPattern pattern;
    
    private DafnyExpression value;


    public DafnyEqualsDefinition(TCEqualsDefinition def, FlatEnvironment env) {
        this.def = def;
        names = def.getVariableNames().stream().map(n -> DafnyIdentifiers.instance().transform(n)).collect(Collectors.toList());
        value = DafnyExpression.of(def.test, env);
        if (def.pattern != null) {
            pattern = DafnyPattern.of(def.pattern);
        }
        else {
            pattern = DafnyPattern.of(def.typebind.pattern);
        }
    }

    @Override
    public String translate() {
        return DafnyTemplates.DEFINITIONS.render("let", Pair.of("def", this));
    }

    @Override
    public TCDefinition getVDM() {
        return def;
    }

    @Override
    public boolean isLocal() {
        return def.nameScope.equals(NameScope.LOCAL);
    }
    
    public String getNames() {
        return names.stream().collect(Collectors.joining(", "));
    }

    public String getPattern() {
        return pattern.translate();
    }

    public boolean isValidPattern() {
        return !pattern.invalidAssignmentPattern();
    }

    public String getValueDef() {
        return value.translate();
    }

    public String getName() {
        return "";
    }
}
