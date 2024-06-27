package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.ArrayList;
import java.util.List;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCLocalDefinition;
import com.fujitsu.vdmj.tc.definitions.TCMultiBindListDefinition;
import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;
import com.fujitsu.vdmj.tc.patterns.TCIgnorePattern;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;
import com.fujitsu.vdmj.tc.types.TCType;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyWarningMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyParamPattern;

public class DafnyParamDefinition extends DafnyDefinition {
    public String name;
    public String type;
    public final List<DafnyParamPattern> reconciliations;

    // Explicit definitions
    public DafnyParamDefinition(TCLocalDefinition definition) {
        name = DafnyIdentifiers.instance().transform(definition.name);
        type = DafnyTypeNames.instance().getTypeName(definition.type);
        reconciliations = new ArrayList<>();
    }
    
    public DafnyParamDefinition(TCDefinition definition) {
        assert definition instanceof TCLocalDefinition;
        name = DafnyIdentifiers.instance().transform(definition.name);
        type = DafnyTypeNames.instance().getTypeName(((TCLocalDefinition)definition).type);
        reconciliations = new ArrayList<>();
    }

    public DafnyParamDefinition(String name, TCType type) {
        this.name = DafnyIdentifiers.instance().transform(name);
        this.type = DafnyTypeNames.instance().getTypeName(type);
        reconciliations = new ArrayList<>();
    }
    
    // Implicit definitions
    // public DafnyParamDefinition(TCDefinition definition, TCPatternListTypePair pattern, TCType parameterType) {
    //     varNames = definition.getVariableNames().stream().map(name -> name.getName()).collect(Collectors.toList());
    //     paramType = DafnyTypeNames.instance().getTypeName(parameterType);
    //     identity = varNames.size() == 1;
    // }

    public static List<DafnyParamDefinition> from(TCExplicitFunctionDefinition func) {
        assert func.paramPatternList.size() == 1;
        TCPatternList patterns = func.paramPatternList.get(0);
        List<DafnyParamDefinition> result = new ArrayList<>();
        int idx = 0;
        
        for (int i = 0; i < patterns.size(); i++) {
            // No reconciliation needed
            if (patterns.get(i) instanceof TCIdentifierPattern) {
                TCIdentifierPattern ipattern = (TCIdentifierPattern)patterns.get(i);
                result.add(new DafnyParamDefinition(/* name */ DafnyIdentifiers.instance().transform(ipattern.name), /* type */ func.type.parameters.get(i)));
            } 
            else {
                DafnyParamDefinition tmp = new DafnyParamDefinition(/* name */ getDummyName(func) + String.valueOf(idx), /* type */ func.type.parameters.get(i));
                // Ignore ignore patterns :)
                if (!(patterns.get(i) instanceof TCIgnorePattern)) {
                    tmp.addReconciliation(new DafnyParamPattern(patterns.get(i), getDummyName(func) + String.valueOf(idx)));
                    result.add(tmp);
                }
            }
        }

        // for (TCDefinitionList defs: func.paramDefinitionList) {
        //     for (TCDefinition def: defs) {
        //         result.add(new DafnyParamDefinition((TCLocalDefinition)def));
        //     }
        // }
        return result;
    }

    public static List<DafnyParamDefinition> from(TCMultiBindListDefinition defs) {
        List<DafnyParamDefinition> result = new ArrayList<>();
        for (TCDefinition def: defs.defs) {
            assert def instanceof TCLocalDefinition;
            result.add(new DafnyParamDefinition((TCLocalDefinition)def));
        }
        return result;
    }

    private final void addReconciliation(DafnyParamPattern p) {
        this.reconciliations.add(p);
    }

    private static final String getDummyName(TCExplicitFunctionDefinition func) {
        return getDummyName(func, "arg");   
    }
    
    private static final String getDummyName(TCImplicitFunctionDefinition func) {
        return "arg";  //TODO implicit functions 
    }
    
    private static final String getDummyName(TCExplicitFunctionDefinition func, String dummy) {
        if (func.paramPatternList.get(0).stream().filter(p -> p instanceof TCIdentifierPattern).anyMatch(p -> ((TCIdentifierPattern)p).name.getName().startsWith(dummy)))
            return getDummyName(func, dummy + "_");
        return dummy;
    }
    
    public static List<DafnyParamDefinition> from(TCImplicitFunctionDefinition func) {
        DafnyTranslateCommand.warning(DafnyWarningMessage.DAFNY_NYI_2P, func.location, "pattern reconciliation", "implicit functions");
        List<DafnyParamDefinition> result = new ArrayList<>();
        // assert func.parameterPatterns.size() == 1;
        // TCDefinitionList patterns = func.paramDefinitions;
        // int idx = 0;
        // for (int i = 0; i < patterns.size(); i++) {
        //     // No reconciliation needed
        //     if (patterns.get(i) instanceof TCIdentifierPattern) {
        //         TCIdentifierPattern ipattern = (TCIdentifierPattern)patterns.get(i);
        //         result.add(new DafnyParamDefinition(/* name */ DafnyIdentifiers.instance().transform(ipattern.name), /* type */ func.type.parameters.get(i)));
        //     } 
        //     else {
        //         DafnyParamDefinition tmp = new DafnyParamDefinition(/* name */ getDummyName(func) + String.valueOf(idx), /* type */ func.type.parameters.get(i));
        //         tmp.addReconciliation(new DafnyParamPattern(patterns.get(i), getDummyName(func) + String.valueOf(idx)));
        //         result.add(tmp);
        //     }
        // }
        return result;
    }

    @Override
    public String translate() {
        return DafnyTemplates.DEFINITIONS.render("param", Pair.of("param", this));
    }

    @Override
    public TCDefinition getVDM() {
        throw new UnsupportedOperationException("Unimplemented method 'getVDM'");
    }

    @Override
    public boolean isLocal() {
        return true;
    }

    public String getName() {
        return name;
    }
    
    public String getType() {
        return type;
    }
}
