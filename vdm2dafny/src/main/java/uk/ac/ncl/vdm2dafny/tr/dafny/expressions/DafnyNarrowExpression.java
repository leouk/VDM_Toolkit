package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCNarrowExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.lex.DafnyToken;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeNames;

public class DafnyNarrowExpression extends AbstractDafnyExpression{
    private TCNarrowExpression exp;

    public DafnyNarrowExpression(TCNarrowExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        return DafnyToken.parenthesise(
            DafnyToken.parenthesise(DafnyExpression.of(exp.test, env).translate()) + 
            " as " + 
            DafnyTypeNames.instance().getTypeName(exp.basictype));
        // (exp as type)
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
    
}
