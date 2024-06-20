package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCUndefinedExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;

public class DafnyUndefinedExpression extends AbstractDafnyExpression {
    
    public TCUndefinedExpression exp;
    
    public DafnyUndefinedExpression(TCUndefinedExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNDEFINED_SUPPORT, exp.location);
        return "*";
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
    
}
