package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCSubseqExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnySubseqExpression extends AbstractDafnyExpression {
    private TCSubseqExpression exp;
    
    public DafnySubseqExpression(TCSubseqExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }
    
    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("subseq", Pair.of("exp", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public String getSeq() {
        return DafnyExpression.of(exp.seq, env).translate();
    }
    
    public String getFrom() {
        return DafnyExpression.of(exp.from, env).translate();
    }
    
    public String getTo() {
        return DafnyExpression.of(exp.to, env).translate();
    }
}
