package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCLocalDefinition;
import com.fujitsu.vdmj.tc.definitions.TCValueDefinition;
import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;
import com.fujitsu.vdmj.typechecker.NameScope;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyPattern;

public class DafnyValueDefinition extends DafnyDefinition {
    private TCValueDefinition vdm;
    private DafnyExpression exp;
    private DafnyPattern pattern;

    public DafnyValueDefinition(TCValueDefinition valueDef) {
        vdm = valueDef;
        pattern = DafnyPattern.of(vdm.pattern);
        // type = DafnyTypeNames.instance().getTypeName(vdm.type);
        exp = DafnyExpression.of(valueDef.exp, DafnyEnvironment.instance().globalEnv());
    }

    @Override
    public String translate() {
        return DafnyTemplates.DEFINITIONS.render("let", Pair.of("def", this));
    }

    @Override
    public TCDefinition getVDM() {
        return vdm;
    }

    @Override
    public boolean isLocal() {
        return vdm.nameScope.equals(NameScope.LOCAL);
    }

    public String getPattern() {
        return pattern.translate();
    }

    public boolean isValidPattern() {
        return !pattern.invalidAssignmentPattern();
    }

    public String getNames() {
        List<DafnyParamDefinition> paramDefs = new ArrayList<>();
        for (TCDefinition def: vdm.getDefinitions()) {
            assert def instanceof TCLocalDefinition;
            paramDefs.add(new DafnyParamDefinition((TCLocalDefinition)def));
        }
        return paramDefs.stream().map(r -> r.translate()).collect(Collectors.joining(", "));
    }

    public String getValueDef() {
        return exp.translate();
    }

    public String getName() {
        assert pattern.getVDM() instanceof TCIdentifierPattern;
        return pattern.getVariables();
    }
}
