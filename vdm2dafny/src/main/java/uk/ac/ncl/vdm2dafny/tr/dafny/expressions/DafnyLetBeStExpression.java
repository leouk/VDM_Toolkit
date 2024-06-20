package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCLetBeStExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyMultipleBind;

public class DafnyLetBeStExpression extends AbstractDafnyExpression {
    private TCLetBeStExpression exp;
    private List<String> vars;
    private List<DafnyMultipleBind> bind;
    private DafnyExpression suchThat;
    private DafnyExpression in;

    public DafnyLetBeStExpression(TCLetBeStExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
        vars = exp.def.getVariableNames().stream()
            .map(v -> DafnyIdentifiers.instance().transform(v))
            .collect(Collectors.toList());
        bind = DafnyMultipleBind.of(exp.def, env);
        suchThat = DafnyExpression.of(exp.suchThat, env);
        in = DafnyExpression.of(exp.value, env);
    }

    @Override
    public String translate() {
        return DafnyTemplates.STATEMENTS.render("letbest", Pair.of("stmt", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public List<String> getVars() {
        return vars;
    }

    public List<String> getBind() {
        return bind.stream().map(d -> d.translate()).collect(Collectors.toList());
    }

    public String getSuchThat() {
        return suchThat.translate();
    }

    public String getIn() {
        return in.translate();
    }
}
