package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCFuncInstantiationExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeNames;

public class DafnyFuncInstantiationExpression extends AbstractDafnyExpression {

    private TCFuncInstantiationExpression exp;

    public DafnyFuncInstantiationExpression(TCFuncInstantiationExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("funcInstantiation", Pair.of("exp", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public List<String> getTypes() {
        return exp.actualTypes.stream().map(type -> DafnyTypeNames.instance().getTypeName(type)).collect(Collectors.toList());
    }

    public String getName() {
        return DafnyExpression.of(exp.function, env).translate();
    }
}
