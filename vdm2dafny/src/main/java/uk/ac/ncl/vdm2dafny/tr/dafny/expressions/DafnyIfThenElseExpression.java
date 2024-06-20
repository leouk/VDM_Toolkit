package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCIfExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyIfThenElseExpression extends AbstractDafnyExpression {
    private TCIfExpression exp;
    private List<DafnyElseIfExpression> elseIfs;

    public DafnyIfThenElseExpression(TCIfExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
        this.elseIfs = exp.elseList.stream().map(elseif -> new DafnyElseIfExpression(elseif, fenv)).collect(Collectors.toList());
    }
    
    public String getCondition() {
        return DafnyExpression.of(exp.ifExp, env).translate();
    }

    public String getThen() {
        return DafnyExpression.of(exp.thenExp, env).translate();
    }

    public boolean hasElseIf() {
        return elseIfs.size() > 0;
    }

    public List<DafnyElseIfExpression> getElseIfs() {
        return elseIfs;
    }

    public String getElseCase() {
        return DafnyExpression.of(exp.elseExp, env).translate();
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("ifthenelse", Pair.of("iexp", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    
}
