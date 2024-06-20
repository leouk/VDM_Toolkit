package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;
import com.fujitsu.vdmj.tc.patterns.TCIgnorePattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;

public class DafnyParamPattern implements DafnyPattern {
    public boolean reconcilable;
    public String reconciledVar;
    public DafnyPattern internal;
    public TCPattern internalVDM;

    public String getName() {
        assert reconcilable;
        return reconciledVar;
    }
    
    public List<String> getVars() {
        return internalVDM.getVariableNames().stream().map(name -> DafnyIdentifiers.instance().transform(name)).collect(Collectors.toList());
    }

    public String getPattern() {
        return internal.translate();
    }

    @Override
    public String translate() {
        assert isReconcilable();
        return DafnyTemplates.FUNCTIONS.render("paramReconciliation", Pair.of("pattern", this));
    }

    public boolean isReconcilable() {
        return reconcilable;
    }

    public DafnyParamPattern(TCPattern p, String name) {
        this.reconcilable = !(p instanceof TCIdentifierPattern || p instanceof TCIgnorePattern);
        this.internal = DafnyPattern.of(p);
        this.internalVDM = p;
        this.reconciledVar = name;
    }

    public static List<DafnyParamPattern> from(TCExplicitFunctionDefinition func, String name) {
        List<DafnyParamPattern> result = new ArrayList<>();
        for (TCPatternList patternList: func.paramPatternList) {
            for (TCPattern pattern: patternList) {
                result.add(new DafnyParamPattern(pattern, name));
            }
        }
        return result;
    }

    @Override
    public TCPattern getVDM() {
        return internalVDM;
    }

    public String getVariables() {
        return getVars().stream().collect(Collectors.joining(", "));
    }

    @Override
    public boolean invalidAssignmentPattern() {
        return true;
    }

    @Override
    public boolean invalidCase() {
        return true;
    }
    
}
