package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCLetDefExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyDefinition;

public class DafnyLetDefExpression extends AbstractDafnyExpression {
    private TCLetDefExpression exp;

    public DafnyLetDefExpression(TCLetDefExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
    }

    @Override
    public String translate() {
        return DafnyTemplates.DEFINITIONS.render("multilet", Pair.of("defs", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public List<String> getDefs() {
        return DafnyDefinition.from(exp.localDefs, env).stream().map(def -> def.translate()).collect(Collectors.toList());
    }

    public String getBody() {
        return DafnyExpression.of(exp.expression, env).translate();
    }
}
