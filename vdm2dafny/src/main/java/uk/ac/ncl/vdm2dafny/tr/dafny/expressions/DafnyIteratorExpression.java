package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCMultiBindListDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExists1Expression;
import com.fujitsu.vdmj.tc.expressions.TCExistsExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCForAllExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyParamDefinition;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyMultipleBind;

public class DafnyIteratorExpression extends AbstractDafnyExpression {
    private TCExpression exp;
    // private List<String> variables;
    private List<DafnyMultipleBind> binds;
    private List<DafnyParamDefinition> vars;
    private DafnyExpression predicate;
    private boolean exists1 = false;

    public DafnyIteratorExpression(TCExistsExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
        this.binds = DafnyMultipleBind.of(exp.def, fenv);
        assert exp.def instanceof TCMultiBindListDefinition;
        this.vars = DafnyParamDefinition.from((TCMultiBindListDefinition)exp.def);
        this.predicate = DafnyExpression.of(exp.predicate, fenv);
    }
    
    public DafnyIteratorExpression(TCForAllExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
        this.binds = DafnyMultipleBind.of(exp.def, fenv);
        assert exp.def instanceof TCMultiBindListDefinition;
        this.vars = DafnyParamDefinition.from((TCMultiBindListDefinition)exp.def);
        this.predicate = DafnyExpression.of(exp.predicate, fenv);
    }
    
    public DafnyIteratorExpression(TCExists1Expression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
        this.binds = DafnyMultipleBind.of(exp.def, fenv);
        assert exp.def instanceof TCMultiBindListDefinition;
        this.vars = DafnyParamDefinition.from((TCMultiBindListDefinition)exp.def);
        this.predicate = DafnyExpression.of(exp.predicate, fenv);
        exists1 = true;
    }

    @Override
    public String translate() {
        if (exists1) {
            return DafnyTemplates.EXPRESSIONS.render("exists1", Pair.of("type", this));
        }
        return DafnyTemplates.EXPRESSIONS.render("iterationType", Pair.of("type", this));
    }

    public String getVars() {
        return vars.stream().map(v -> v.translate()).collect(Collectors.joining(", "));
    }

    public String getBindings() {
        return binds.stream().map(b -> b.translate()).collect(Collectors.joining(" &&\n\t"));
    }

    public String getPredicate() {
        return predicate.translate();
    }

    public String getKeyword() {
        return tok.dafny;
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
}
