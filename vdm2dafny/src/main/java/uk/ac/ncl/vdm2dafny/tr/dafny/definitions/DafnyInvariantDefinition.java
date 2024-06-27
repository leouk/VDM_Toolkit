package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;
import com.fujitsu.vdmj.typechecker.NameScope;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyParamPattern;

public class DafnyInvariantDefinition extends DafnyDefinition {
    private TCExplicitFunctionDefinition func;
    private DafnyParamDefinition parameter;
    private String implType;
    private DafnyExpression body;

    public DafnyInvariantDefinition(TCExplicitFunctionDefinition func, String implType, FlatEnvironment env) {
        this.func = func;
        this.implType = implType;
        List<DafnyParamDefinition> parameters = DafnyParamDefinition.from(func);
        assert parameters.size() == 1;
        this.parameter = parameters.get(0);
        assert func.predef == null;
        assert func.postdef == null;

        this.body = DafnyExpression.of(func.body, env);
    }

    @Override
    public String translate() {
        return DafnyTemplates.TYPES.render("invariant", Pair.of("inv", this));
    }

    @Override
    public TCDefinition getVDM() {
        return func;
    }

    @Override
    public boolean isLocal() {
        return func.nameScope.equals(NameScope.LOCAL);
    }

    public String getName() {
        return DafnyIdentifiers.instance().transform(func.name);
    }

    public DafnyParamDefinition getParam() {
        return parameter;
    } 
    
    public String getImplType() {
        return implType;
    } 

    public String getBody() {
        return body.translate();
    }

    public boolean hasReconcilablePatterns() {
        return parameter.reconciliations.size() > 0;
    }

    public List<String> getReconciledPatterns() {
        return parameter.reconciliations.stream().map(r -> r.translate()).collect(Collectors.toList());
        // return paramPatterns.stream().filter(pattern -> pattern.isReconcilable()).map(pattern -> pattern.translate()).collect(Collectors.toList());
    }

    public String getReconciliation() {
        return parameter.reconciliations.stream()
        .map(p -> 
            DafnyTemplates.DEFINITIONS.render("reconcile",
                Pair.of("pattern", p.internal.translate()),
                Pair.of("valid", !p.internal.checkValidAssignment()),
                Pair.of("value", p.reconciledVar),
                Pair.of("vars",  p.internal.getVariables())
            )
        ).collect(Collectors.joining("\n"));
    }


    
}
