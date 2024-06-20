package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.ArrayList;
import java.util.List;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCLambdaExpression;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;
import com.fujitsu.vdmj.tc.patterns.TCTypeBind;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeNames;

public class DafnyLambdaExpression extends AbstractDafnyExpression {
    
    private TCLambdaExpression exp;
    
    public DafnyLambdaExpression(TCLambdaExpression exp, FlatEnvironment fenv) {
        super(exp, fenv);
        this.exp = exp;
    }
    

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("lambda", Pair.of("exp", this));
    }

    @Override
    public TCExpression getVDM() {
        return exp;
    }

    public String getDefinition() {
        List<Pair<String, String>> params = new ArrayList<>(); 
        DafnyIdentifiers ident = DafnyIdentifiers.instance();
        DafnyTypeNames types = DafnyTypeNames.instance();

        for (TCTypeBind bind: exp.bindList) {
            if (!(bind.pattern instanceof TCIdentifierPattern)) {
                DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, exp.location, "pattern for lambda expressions", bind.pattern.getClass().getSimpleName());
                params.add(Pair.of("someArg", types.getTypeName(bind.type)));
            }
            else {
                TCNameToken nametok = ((TCIdentifierPattern)bind.pattern).name;
                params.add(Pair.of(ident.transform(nametok), types.getTypeName(bind.type)));
            }
        }

        return DafnyTemplates.DEFINITIONS.render("paramList", Pair.of("params", params));
    }
    

    public String getExpression() {
        return DafnyExpression.of(exp.expression, env).translate();
    }
}
