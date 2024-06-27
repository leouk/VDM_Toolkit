package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCSetRangeExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.lex.DafnyToken;

public class DafnySetRangeExpression extends AbstractDafnyExpression {
    private TCSetRangeExpression exp;

    public DafnySetRangeExpression(TCSetRangeExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        DafnyExpression rangeFirst = DafnyExpression.of(exp.first, env);
        DafnyExpression rangeLast = DafnyExpression.of(exp.last, env);
        return DafnyToken.parenthesise(DafnyTemplates.EXPRESSIONS.render("range", Pair.of("first", rangeFirst.translate()), Pair.of("last", rangeLast.translate())));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
}
