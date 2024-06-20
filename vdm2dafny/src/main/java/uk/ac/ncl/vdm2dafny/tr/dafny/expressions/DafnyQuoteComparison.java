package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCEqualsExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCQuoteLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCVariableExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;

public class DafnyQuoteComparison extends AbstractDafnyExpression {
    public TCEqualsExpression exp;
    public DafnyLiteralExpression var;
    public DafnyLiteralExpression quot;

    public DafnyQuoteComparison(TCEqualsExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
        // Check for errors.
        if (!(exp.left instanceof TCVariableExpression) && !(exp.right instanceof TCQuoteLiteralExpression)) {
            if (!(exp.left instanceof TCQuoteLiteralExpression) && !(exp.right instanceof TCVariableExpression)) {
                // Incorrect quote comparison.
                DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_QUOTE_COMPARISON_2P, exp.location, exp.left.getClass().getSimpleName(), exp.right.getClass().getSimpleName());
            }
            else {
                // This is in the form <QUOT> = VAR
                this.var  = (DafnyLiteralExpression)DafnyLiteralExpression.of(exp.right, env);
                this.quot = (DafnyLiteralExpression)DafnyLiteralExpression.of(exp.left, env);
            }
        }
        else {
            // This is in the form VAR = <QUOT>
            this.var  = (DafnyLiteralExpression)DafnyLiteralExpression.of(exp.left, env);
            this.quot = (DafnyLiteralExpression)DafnyLiteralExpression.of(exp.right, env);
        }
    }

    public static final boolean is(TCExpression exp) {
        if (exp instanceof TCEqualsExpression) {
            final TCEqualsExpression eqexp = (TCEqualsExpression)exp;
            return (eqexp.left instanceof TCVariableExpression && eqexp.right instanceof TCQuoteLiteralExpression)
                || (eqexp.right instanceof TCQuoteLiteralExpression && eqexp.right instanceof TCVariableExpression);

        }
        return false;
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("quoteComparison", Pair.of("exp", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public String getVar() {
        return var.translate();
    }

    public String getQuot() {
        return quot.translate();
    }
}
