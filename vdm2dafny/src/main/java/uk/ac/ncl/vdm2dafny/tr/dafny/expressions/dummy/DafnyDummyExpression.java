package uk.ac.ncl.vdm2dafny.tr.dafny.expressions.dummy;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCIotaExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.AbstractDafnyExpression;

public class DafnyDummyExpression extends AbstractDafnyExpression {
    private TCExpression exp;

    public DafnyDummyExpression(TCExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        DafnyTranslateCommand.report(DafnyErrorMessage.PLUGIN_NYI_2P, getVDM().location, getVDM().toString() + ": " + getVDM().getClass().getSimpleName(), "translation strategies");
        return DafnyTemplates.MESSAGES.render("error", Pair.of("type", "error"), Pair.of("message", String.format("Unsupported expression in parsed program text ==> %s <==", exp.toString())));

    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

}
