package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.Set;

import com.fujitsu.vdmj.tc.expressions.TCEqualsExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCGreaterEqualExpression;
import com.fujitsu.vdmj.tc.expressions.TCGreaterExpression;
import com.fujitsu.vdmj.tc.expressions.TCLessEqualExpression;
import com.fujitsu.vdmj.tc.expressions.TCLessExpression;
import com.fujitsu.vdmj.tc.types.TCInvariantType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.lex.DafnyToken;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeNames;

public class DafnyCompareExpression extends AbstractDafnyExpression {
    private final static Set<DafnyToken> VALID_COMPARISONS = Set.of(DafnyToken.LE,DafnyToken.LT,DafnyToken.GT,DafnyToken.GE,DafnyToken.EQUALS);

    protected final static boolean is(TCExpression exp) {
        return 
            exp instanceof TCGreaterEqualExpression
        ||  exp instanceof TCGreaterExpression
        ||  exp instanceof TCLessEqualExpression
        ||  exp instanceof TCLessExpression
        ||  exp instanceof TCEqualsExpression
        ;
    }
    
    public final static DafnyCompareExpression of(TCExpression exp, FlatEnvironment env) {
        return 
            exp instanceof TCGreaterEqualExpression ? new DafnyCompareExpression((TCGreaterEqualExpression)exp, env)
        :   exp instanceof TCGreaterExpression      ? new DafnyCompareExpression((TCGreaterExpression     )exp, env)
        :   exp instanceof TCLessEqualExpression    ? new DafnyCompareExpression((TCLessEqualExpression   )exp, env)
        :   exp instanceof TCLessExpression         ? new DafnyCompareExpression((TCLessExpression        )exp, env)
        :   exp instanceof TCEqualsExpression       ? new DafnyCompareExpression((TCEqualsExpression      )exp, env)
        :   null;
    }

    private TCExpression exp;
    private FlatEnvironment env;
    private DafnyExpression left;
    private DafnyExpression right;

    private boolean isOrd;
    private boolean isEq;

    private void setOrd(TCType ltype, TCType rtype) {
        isOrd = ltype.equals(rtype)
        &&
        ltype instanceof TCInvariantType && ltype.isOrdered(ltype.location)
        &&
        rtype instanceof TCInvariantType && rtype.isOrdered(ltype.location);
    }
    
    private void setEq(TCType ltype, TCType rtype) {
        isEq = ltype.equals(rtype)
        &&
        ltype instanceof TCInvariantType && ltype.isEq(ltype.location)
        &&
        rtype instanceof TCInvariantType && rtype.isEq(ltype.location);
    }

    public DafnyCompareExpression(TCGreaterEqualExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        setOrd(exp.ltype, exp.rtype);
        setEq(exp.ltype, exp.rtype);
        left = DafnyExpression.of(exp.left, env);
        right = DafnyExpression.of(exp.right, env);
    }
    
    public DafnyCompareExpression(TCGreaterExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        setOrd(exp.ltype, exp.rtype);
        setEq(exp.ltype, exp.rtype);
        left = DafnyExpression.of(exp.left, env);
        right = DafnyExpression.of(exp.right, env);
    }

    public DafnyCompareExpression(TCLessEqualExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        setOrd(exp.ltype, exp.rtype);
        setEq(exp.ltype, exp.rtype);
        left = DafnyExpression.of(exp.left, env);
        right = DafnyExpression.of(exp.right, env);
    }

    public DafnyCompareExpression(TCLessExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        setOrd(exp.ltype, exp.rtype);
        setEq(exp.ltype, exp.rtype);
        left = DafnyExpression.of(exp.left, env);
        right = DafnyExpression.of(exp.right, env);
    }
    
    public DafnyCompareExpression(TCEqualsExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        setOrd(exp.ltype, exp.rtype);
        setEq(exp.ltype, exp.rtype);
        left = DafnyExpression.of(exp.left, env);
        right = DafnyExpression.of(exp.right, env);
    }

    @Override
    public String translate() {
        assert VALID_COMPARISONS.contains(tok);
        if (isOrd || isEq) {
            return translateOrd();
        }
        else {
            return "(" + tok.render(left.translate(), right.translate()) + ")";
        }
    }


    public String translateOrd() {
        assert isOrd;
        return DafnyTemplates.EXPRESSIONS.render("compare", Pair.of("exp", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public String getLeft() {
        assert isOrd;
        switch (tok) {
            case EQUALS:assert isEq;  return left.translate();
            case LE:    assert isEq;
            case LT:    assert isOrd; return left.translate();
            case GE:    assert isEq;  // invert conditions if using ord_ for greater checks
            case GT:    assert isOrd; return right.translate();
            default:    return "/*@vdm.error(Should never see this.)*/";
        }
    }

    public String getTypeName() {
        return DafnyTypeNames.instance().getTypeName(left.getVDM().getType());
    }

    public String getRight() {
        switch (tok) {
            case EQUALS:assert isEq;  return right.translate();
            case LE:    assert isEq;
            case LT:    assert isOrd; return right.translate();
            case GE:    assert isEq;  // invert conditions if using ord_ for greater checks
            case GT:    assert isOrd; return left.translate();
            default:    return "/*@vdm.error(Should never see this.)*/";
        }
    }

    public List<String> getOps() {
        assert isOrd || isEq;
        switch (tok) {
            case EQUALS:return List.of("eq");
            case GT:    
            case LT:    return List.of("ord");
            case LE: 
            case GE:    return List.of("ord", "eq");
            default:    return List.of("/*@vdm.error(Should never see this.)*/");
        }
    }

    
}
