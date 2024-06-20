package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.ArrayList;
import java.util.List;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCMuExpression;
import com.fujitsu.vdmj.tc.expressions.TCRecordModifier;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;

public class DafnyMuExpression extends AbstractDafnyExpression {
    
    private TCMuExpression exp;
    
    public DafnyMuExpression(TCMuExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("mu", Pair.of("exp", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }
    
    public String getRoot() {
        return DafnyExpression.of(exp.record, env).translate();
    }
    
    public List<Pair<String, String>> getModifiers () {
        List<Pair<String, String>> modifiers = new ArrayList<>();
        for (TCRecordModifier mod : exp.modifiers) {
            modifiers.add(Pair.of(
                DafnyIdentifiers.instance().transform(mod.tag), 
                DafnyExpression.of(mod.value, env).translate()
                ));
        }
        return modifiers;
    }

}
