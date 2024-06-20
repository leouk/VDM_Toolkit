package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.expressions.TCApplyExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;

public class DafnyApplyExpression extends AbstractDafnyExpression {
    private TCApplyExpression exp;

    public DafnyApplyExpression(TCApplyExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        if (exp.type.isFunction(exp.location) || exp.type.isOperation(exp.location)) {
            return DafnyTemplates.EXPRESSIONS.render("apply", Pair.of("expr", this));
        }
        else if (exp.type.isSeq(exp.location)){
            return DafnyTemplates.EXPRESSIONS.render("applySeq", Pair.of("expr", this));
        }
        else if (exp.type.isMap(exp.location)) {
            return DafnyTemplates.EXPRESSIONS.render("applyMap", Pair.of("expr", this));
        }
        else {
            DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNKNOWN_EXPRESSION, exp.location, exp.toString());
            return "?";
        }
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public String getRoot() {
        return DafnyExpression.of(exp.root, env).translate();
    }

    public List<String> getParams() {
        return exp.args.stream().map(e -> DafnyExpression.of(e, env).translate()).collect(Collectors.toList());
    }
    


}
