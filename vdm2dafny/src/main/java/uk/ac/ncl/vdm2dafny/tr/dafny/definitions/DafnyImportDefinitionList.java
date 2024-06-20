package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.modules.TCImport;
import com.fujitsu.vdmj.tc.modules.TCImportAll;
import com.fujitsu.vdmj.tc.modules.TCImportFromModule;
import com.fujitsu.vdmj.tc.modules.TCModule;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;

public class DafnyImportDefinitionList extends ArrayList<DafnyImportDefinition> {

    public static final DafnyImportDefinitionList from(TCModule mod) {
        DafnyImportDefinitionList result = new DafnyImportDefinitionList();
        if (mod.imports == null) {
            return result;
        }
        for (TCImportFromModule importModule: mod.imports.imports) {
            for (TCImport i: importModule.signatures) {
                if (i instanceof TCImportAll) {
                    result.add(new DafnyImportDefinition(((TCImportAll)i).from.name.getName()));
                }
                else {
                    result.add(new DafnyImportDefinition(i));
                }
            }
        }

        return result;
    }    

    public String translate() {
        if (this.size() == 0) return "";
        // Get modules that are not being imported in full.
        Set<String> modules = stream().filter(imp -> !imp.isAll()).map(imp -> imp.getModule()).collect(Collectors.toSet());
        // Get modules that are being imported in full
        Set<String> all = stream().filter(imp -> imp.isAll()).map(imp -> imp.getModule()).collect(Collectors.toSet());
        
        // setup list for renamed types
        List<String> renamed = new ArrayList<>();
        // setup map for non-renamed types to bulk import.
        Map<String, Set<String>> nonRenamed = new HashMap<>();

        String warnings = "";

        for (DafnyImportDefinition imp: this) {
            if (imp.renamed) {
                if (all.contains(imp.getModule())) {
                    DafnyTranslateCommand.report(DafnyErrorMessage.VDMSL_STUPID_IMPORTS_1P, imp.getVDM().location, imp.getModule());
                }
                renamed.add(imp.translate());
            }
        }
        
        for (String module: modules) {
            nonRenamed.put(module, new HashSet<>());
            
            for (DafnyImportDefinition imp: this) {
                if (!imp.renamed && !imp.isAll()) {
                    if (imp.getModule().equals(module)) {
                        nonRenamed.get(module).add(imp.getName());
                    }
                    if (all.contains(imp.getModule())) {
                        DafnyTranslateCommand.report(DafnyErrorMessage.VDMSL_STUPID_IMPORTS_1P, imp.getVDM().location, imp.getModule());
                    }
                }
            }
        }


        final int nonRenamedSize = nonRenamed.entrySet().stream()
            .map(e -> e.getValue().size())
            .reduce(0, (subtotal, elmt) -> subtotal + elmt);
        return DafnyTemplates.IMPORT.render("imports", 
            Pair.of("warnings", warnings),
            Pair.of("hasRenamed", renamed.size() > 0), 
            Pair.of("renamed", renamed), 
            Pair.of("hasNonRenamed", nonRenamedSize > 0), 
            Pair.of("nonRenamed", nonRenamed.entrySet()), 
            Pair.of("hasAll", all.size() > 0),
            Pair.of("all", all));
    }
}
