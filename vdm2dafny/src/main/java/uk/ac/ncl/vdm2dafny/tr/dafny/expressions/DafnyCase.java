package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;


import com.fujitsu.vdmj.tc.expressions.TCCaseAlternative;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeObject;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyPattern;

public class DafnyCase extends AbstractDafnyNode {
    private TCCaseAlternative vdm;
    private DafnyPattern pattern;
    private DafnyExpression result;
    private DafnyTypeObject typeObj;


    public DafnyCase(TCCaseAlternative dcase, FlatEnvironment env) {
        this.vdm = dcase;
        pattern = DafnyPattern.of(dcase.pattern);
        result = DafnyExpression.of(dcase.result, env);
        if (invalid()) {
            DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, dcase.location, "pattern in cases", dcase.pattern.getClass().getSimpleName());
        }
    }
    
    public DafnyCase(TCCaseAlternative dcase, FlatEnvironment env, TCType type) {
        typeObj = new DafnyTypeObject(type);
        this.vdm = dcase;
        this.pattern = DafnyPattern.of(dcase.pattern);
        this.result = DafnyExpression.of(dcase.result, env);
        if (invalid()) {
            DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, dcase.location, "pattern in cases", dcase.pattern.getClass().getSimpleName());
        }
    }

    @Override
    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("case", Pair.of("case", this));
    }

    public String getPattern() {
        return typeObj.getPattern(pattern);
        // final String prefix = typeObj.getPatternConstructor(pattern.getVDM());

        // if (prefix != "") {
        //     return typeObj.getPatternConstructor(pattern.getVDM()) + "(" + pattern.translate() + ")";
        // }
        // return pattern.translate();
    }

    public String getResult() {
        return result.translate();
    }
    
    public boolean invalid() {
        return pattern.invalidCase();
    }

    public String getWarnings() {
        if (invalid())
        {
            DafnyTranslateCommand.report(DafnyErrorMessage.VDMSL_BAD_CASES_2P, pattern.getVDM().location, pattern.getVDM().toString(), pattern.getVDM().getClass().getSimpleName());
            return DafnyTemplates.MESSAGES.render("error", Pair.of("type", "translation"), Pair.of("message", String.format("Invalid pattern for translation to dafny --> %1$s. <--", pattern.getVDM().toString())));
        }
        return "";
    }
}
