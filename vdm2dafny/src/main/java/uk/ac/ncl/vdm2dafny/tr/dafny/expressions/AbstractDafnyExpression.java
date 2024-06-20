package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.lex.DafnyToken;

public abstract class AbstractDafnyExpression extends DafnyExpression {
    protected FlatEnvironment env;
    protected DafnyToken tok;

    public AbstractDafnyExpression(TCExpression exp, FlatEnvironment fenv) {
        this.tok = DafnyExpression.getToken(exp);
        this.env = fenv;
    }
}