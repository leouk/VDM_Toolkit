package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.expressions.TCCasesExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyCasesExpression extends AbstractDafnyExpression {
    public TCCasesExpression exp;
    public DafnyExpression caseExpression;
    public List<DafnyCase> cases;

    // Dafny match expressions only allow a certain type of pattern in the case alternatives.
    public DafnyCasesExpression(TCCasesExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
        this.caseExpression = DafnyExpression.of(exp.exp, env);
        // EXTREMELY FRUSTRATING AUTO TYPE CHANGING IS DONE HERE! USE getType() NOT expType .....
        this.cases = exp.cases.stream().map(case_ -> new DafnyCase(case_, env, exp.expType)).collect(Collectors.toList());
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("cases", Pair.of("exp", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public String getCaseExpression() {
        return caseExpression.translate();
    }

    public List<DafnyCase> getCases() {
        return cases;
    }

    
}
