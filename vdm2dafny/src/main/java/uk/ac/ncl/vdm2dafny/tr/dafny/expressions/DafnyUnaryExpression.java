package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCBooleanLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCCharLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCIntegerLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCNilExpression;
import com.fujitsu.vdmj.tc.expressions.TCQuoteLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCRealLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCStringLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCUnaryExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.lex.DafnyToken;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeDefinition;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeNames;

public class DafnyUnaryExpression extends DafnyExpression {
    private TCUnaryExpression exp;
    private FlatEnvironment env;

    public DafnyUnaryExpression(TCUnaryExpression exp, FlatEnvironment env) {
        this.exp = exp;
        this.env = env;
    }

    @Override
    public String translate() {
        DafnyExpression expr = DafnyExpression.of(exp.exp, env);
        if (    !exp.exp.getType().equals(exp.getType()) 
            &&  DafnyTypeDefinition.isLiteral(exp.exp.getType()) 
            &&  !isLiteral()) {
            return DafnyToken.parenthesise(DafnyExpression.getToken(exp).render(expr.translate()) + " as " + DafnyTypeNames.instance().getTypeName(exp.getType()));
        }
        return DafnyToken.parenthesise(DafnyExpression.getToken(exp).render(expr.translate()));
    }

    public boolean isLiteral() {
        return  exp.exp instanceof TCCharLiteralExpression
            ||  exp.exp instanceof TCRealLiteralExpression
            ||  exp.exp instanceof TCQuoteLiteralExpression
            ||  exp.exp instanceof TCStringLiteralExpression
            ||  exp.exp instanceof TCIntegerLiteralExpression
            ||  exp.exp instanceof TCBooleanLiteralExpression
            ||  exp.exp instanceof TCNilExpression;
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
}
