package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.annotations.TCAnnotatedExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.vdm2dafny.messages.DafnyWarningMessage;

public class DafnyAnnotatedExpression extends AbstractDafnyExpression {
    private TCAnnotatedExpression exp;
    
    public DafnyAnnotatedExpression(TCAnnotatedExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
        DafnyTranslateCommand.warning(DafnyWarningMessage.DAFNY_NO_ANNOTATIONS_1P, exp.location, exp.annotation.name.getName());
    }

    @Override
    public String translate() {
        return DafnyExpression.of(exp.expression, env).translate();
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
    
    
}
