package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCMapletExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;

public class DafnyMapletExpression extends AbstractDafnyNode {
    private TCMapletExpression exp;
    private FlatEnvironment env;

    public DafnyMapletExpression(TCMapletExpression maplet, FlatEnvironment env) {
        this.exp = maplet;
        this.env = env;
    }

    @Override
    public String translate() {
        return DafnyExpression.of(exp.left, env).translate() + " := " + DafnyExpression.of(exp.right, env).translate();
    }

    public TCMapletExpression getVDM() {
        return exp;
    }
}
