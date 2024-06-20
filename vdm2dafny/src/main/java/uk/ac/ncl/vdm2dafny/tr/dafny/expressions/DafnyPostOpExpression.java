package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCPostOpExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyPostOpExpression extends AbstractDafnyExpression {
    private TCPostOpExpression exp;

    public DafnyPostOpExpression(TCPostOpExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("postop", Pair.of("exp", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public String getPre() {
        return DafnyExpression.of(exp.preexpression, env).translate();
    }
    
    public String getPost() {
        return DafnyExpression.of(exp.postexpression, env).translate();
    }
    
}
