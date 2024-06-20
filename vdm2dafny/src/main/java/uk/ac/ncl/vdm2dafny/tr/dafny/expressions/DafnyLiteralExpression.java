package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCBooleanLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCCharLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCIntegerLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCNilExpression;
import com.fujitsu.vdmj.tc.expressions.TCQuoteLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCRealLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCStringLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCVariableExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;

public class DafnyLiteralExpression extends AbstractDafnyExpression {
    private TCExpression exp;

    public DafnyLiteralExpression(TCExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
    }

    protected static boolean isLiteral(TCExpression exp) {
        return  exp instanceof TCCharLiteralExpression
            ||  exp instanceof TCRealLiteralExpression
            ||  exp instanceof TCQuoteLiteralExpression
            ||  exp instanceof TCStringLiteralExpression
            ||  exp instanceof TCIntegerLiteralExpression
            ||  exp instanceof TCBooleanLiteralExpression
            ||  exp instanceof TCNilExpression
            ||  exp instanceof TCVariableExpression;
    }
    
    private String getLiteralValue(TCExpression exp) {
        assert isLiteral(exp);
        return  exp instanceof TCCharLiteralExpression      ? "'" + ((TCCharLiteralExpression)exp).value.unicode + "'"
            :   exp instanceof TCRealLiteralExpression      ? String.valueOf(((TCRealLiteralExpression)exp).value.value)
            :   exp instanceof TCQuoteLiteralExpression     ? DafnyIdentifiers.instance().transform(((TCQuoteLiteralExpression)exp).type.value)
            :   exp instanceof TCStringLiteralExpression    ? "\"" + escapeString(((TCStringLiteralExpression)exp).value.value.replace("\\", "\\\\")) + "\""
            :   exp instanceof TCIntegerLiteralExpression   ? String.valueOf(((TCIntegerLiteralExpression)exp).value.value)
            :   exp instanceof TCBooleanLiteralExpression   ? (((TCBooleanLiteralExpression)exp).value.value ? "true" : "false")
            :   exp instanceof TCNilExpression              ? "null"
            :   exp instanceof TCVariableExpression         ? DafnyIdentifiers.instance().transform(((TCVariableExpression)exp).name)
            :   null;
    }

    public static String escapeString(String s) {
        return s.replace("\\", "\\\\")
                .replace("\t", "\\t")
                .replace("\b", "\\b")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\f", "\\f")
                .replace("\'", "\\'")
                .replace("\"", "\\\"");
    }

    @Override
    public String translate() {
        return getLiteralValue(exp);
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

}
