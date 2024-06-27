package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCBinaryExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.lex.DafnyToken;

public class DafnyBinaryExpression extends AbstractDafnyExpression {
    private TCBinaryExpression exp;

    public DafnyBinaryExpression(TCBinaryExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
    }

    @Override
    public String translate() {
        DafnyExpression left    = DafnyExpression.of(exp.left, env);
        DafnyExpression right   = DafnyExpression.of(exp.right, env);
        
        return DafnyToken.parenthesise(DafnyExpression.getToken(exp).render(left.translate(), right.translate()));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    
}
