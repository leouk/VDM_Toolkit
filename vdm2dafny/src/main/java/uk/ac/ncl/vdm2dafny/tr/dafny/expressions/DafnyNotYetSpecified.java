package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCNotYetSpecifiedExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.vdm2dafny.messages.DafnyWarningMessage;

public class DafnyNotYetSpecified extends AbstractDafnyExpression {
    private TCNotYetSpecifiedExpression exp;
    
    public DafnyNotYetSpecified(TCNotYetSpecifiedExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        DafnyTranslateCommand.warning(DafnyWarningMessage.DAFNY_NOT_YET_SPECIFIED, exp.location);
        return "// not yet specified";
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
    
}
