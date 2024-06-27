package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCFieldNumberExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyFieldNumberExpression extends AbstractDafnyExpression {
    private TCFieldNumberExpression exp;

    public DafnyFieldNumberExpression(TCFieldNumberExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("tupleAccess", Pair.of("tup", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public String getExpr() {
        return DafnyExpression.of(exp.tuple, env).translate();
    }

    public String getMember() {
        // Dafny access starts at 0 not 1.
        return String.valueOf(exp.field.value - 1);
    }

}
