package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCFieldExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;

public class DafnyFieldExpression extends AbstractDafnyExpression {
    private TCFieldExpression exp;

    public DafnyFieldExpression(TCFieldExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("field", Pair.of("fieldExpr", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public String getId() {
        return DafnyExpression.of(exp.object, env).translate();
    }

    public String getMember() {
        return exp.memberName == null ? DafnyIdentifiers.instance().transform(exp.field) : DafnyIdentifiers.instance().transform(exp.memberName);
    }
}
