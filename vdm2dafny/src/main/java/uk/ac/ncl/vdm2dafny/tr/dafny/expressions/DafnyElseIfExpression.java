package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCElseIfExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyElseIfExpression extends AbstractDafnyExpression {
    private TCElseIfExpression exp;

    public DafnyElseIfExpression(TCElseIfExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    public String getCondition() {
        return DafnyExpression.of(exp.elseIfExp, env).translate();
    }

    public String getThen() {
        return DafnyExpression.of(exp.thenExp, env).translate();
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("elseif", Pair.of("elseif", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
    
}
