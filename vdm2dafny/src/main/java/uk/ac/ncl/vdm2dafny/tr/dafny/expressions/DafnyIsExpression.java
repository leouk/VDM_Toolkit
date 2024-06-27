package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCIsExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeNames;

public class DafnyIsExpression extends AbstractDafnyExpression {
    private TCIsExpression exp;
    
    public DafnyIsExpression(TCIsExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("isExp", Pair.of("exp", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
    
    public boolean isConsTest() {
        return  exp.basictype == null // Not a basic type test
            &&  exp.typedef != null // Has something in this field
            &&  exp.test.getType().isUnion(exp.location); // Check if type is union
    }

    public String getTest() {
        return DafnyExpression.of(exp.test, env).translate();
    }

    public String getType() {
        if (exp.basictype != null) {
            return DafnyTypeNames.instance().getTypeName(exp.basictype);
        }
        else if (exp.typedef != null) {
            return DafnyTypeNames.instance().getTypeName(((TCTypeDefinition)exp.typedef).type);
        } 
        else {
            return "?";
        }
    }
}
