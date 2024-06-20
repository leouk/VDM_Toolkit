package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCMkTypeExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeNames;

public class DafnyMkTypeExpression extends AbstractDafnyExpression {
    private TCMkTypeExpression exp;

    public DafnyMkTypeExpression(TCMkTypeExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;   
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("mkType", Pair.of("cons", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
    
    public String getType() {
        return DafnyTypeNames.instance().getTypeName(exp.getType());
    }

    public List<String> getArgs() {
        return exp.args.stream().map(e -> DafnyExpression.of(e, env).translate()).collect(Collectors.toList());
    }
}
