package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCMultiBindListDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapCompExpression;
import com.fujitsu.vdmj.tc.expressions.TCSeqCompExpression;
import com.fujitsu.vdmj.tc.expressions.TCSetCompExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.DafnyNode;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyParamDefinition;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyMultipleBind;

public class DafnyComprehensionExpression extends AbstractDafnyExpression {
    private TCExpression vdm;
    private String type;
    private List<DafnyParamDefinition> vars; 
    private DafnyExpression predicate;
    private List<DafnyMultipleBind> bind;
    private DafnyNode expr;

    public DafnyComprehensionExpression(TCSeqCompExpression seqComp, FlatEnvironment env) {
        super(seqComp, env);
        this.vdm = seqComp;
        this.type = "/*@vdm.warning(`Sequence comprehensions do not work the same way in dafny as VDM, you may want to check this`)*/\nseq";
        
        // Define variables.
        assert seqComp.def instanceof TCMultiBindListDefinition;
        this.vars = DafnyParamDefinition.from((TCMultiBindListDefinition)seqComp.def);

        // Define predicate
        this.predicate = DafnyExpression.of(seqComp.predicate, env);
        // this.bind = seqComp.bind != null ? DafnyPattern.of(seqComp.bind.pattern) : null;
        // Define the binds.
        this.bind = DafnyMultipleBind.of(seqComp.def, env);
        this.expr = DafnyExpression.of(seqComp.first, env);
    }

    public DafnyComprehensionExpression(TCSetCompExpression setComp, FlatEnvironment env) {
        super(setComp, env);
        this.vdm = setComp;
        this.type = "set";
        
        // Define variables.
        assert setComp.def instanceof TCMultiBindListDefinition;
        this.vars = DafnyParamDefinition.from((TCMultiBindListDefinition)setComp.def);

        // Define predicate
        this.predicate = DafnyExpression.of(setComp.predicate, env);
        // this.bind = seqComp.bind != null ? DafnyPattern.of(seqComp.bind.pattern) : null;
        // Define the binds.
        this.bind = DafnyMultipleBind.of(setComp.def, env);
        this.expr = DafnyExpression.of(setComp.first, env);
    }

    public DafnyComprehensionExpression(TCMapCompExpression mapComp, FlatEnvironment env) {
        super(mapComp, env);
        this.vdm = mapComp;
        this.type = "map";
        
        // Define variables.
        assert mapComp.def instanceof TCMultiBindListDefinition;
        this.vars = DafnyParamDefinition.from((TCMultiBindListDefinition)mapComp.def);

        // Define predicate
        this.predicate = DafnyExpression.of(mapComp.predicate, env);
        // this.bind = seqComp.bind != null ? DafnyPattern.of(seqComp.bind.pattern) : null;
        // Define the binds.
        this.bind = DafnyMultipleBind.of(mapComp.def, env);
        this.expr = new DafnyMapletExpression(mapComp.first, env);
    }

    public static DafnyComprehensionExpression of(TCExpression exp, FlatEnvironment env) {
        if (exp instanceof TCMapCompExpression) {
            return new DafnyComprehensionExpression((TCMapCompExpression)exp, env);
        }
        else if (exp instanceof TCSetCompExpression) {
            return new DafnyComprehensionExpression((TCSetCompExpression)exp, env);
        }
        else if (exp instanceof TCSeqCompExpression) {
            return new DafnyComprehensionExpression((TCSeqCompExpression)exp, env);
        }
        else {
            return null;
        }
    }
    
    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("compExpression", Pair.of("comp", this));
    }

    @Override
    public TCExpression getVDM() {
        return vdm;
    }

    public String getType() {
        return type;
    }
    
    public String getVars() {
        return vars.stream().map(v -> v.translate()).collect(Collectors.joining(", "));
    }

    public String getBindings() {
        return bind.stream().map(b -> b.translate()).collect(Collectors.joining(" &&\n\t"));
    }
    
    public boolean hasPredicateTranslation() {
        return predicate != null && !predicate.translate().isBlank();
    }

    public String getPredicate() {
        return predicate.translate();
    }

    public String getExpr() {
        return expr.translate();
    }

    protected static boolean isComp(TCExpression exp) {
        return  exp instanceof TCSeqCompExpression
            ||  exp instanceof TCSetCompExpression
            ||  exp instanceof TCMapCompExpression;
    }
    
}
