package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitOperationDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.definitions.TCValueDefinition;
import com.fujitsu.vdmj.tc.modules.TCExport;
import com.fujitsu.vdmj.tc.modules.TCExportAll;
import com.fujitsu.vdmj.tc.modules.TCExportedFunction;
import com.fujitsu.vdmj.tc.modules.TCExportedOperation;
import com.fujitsu.vdmj.tc.modules.TCExportedType;
import com.fujitsu.vdmj.tc.modules.TCExportedValue;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;
import uk.ac.ncl.vdm2dafny.messages.DafnyWarningMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;

public class DafnyExportDefinition extends AbstractDafnyNode {
    
    private TCExport export;
    private List<String> name;
    private boolean reveals;

    public static final List<DafnyExportDefinition> from(TCModule mod) {
        List<DafnyExportDefinition> result = new ArrayList<>();

        // If exports all, add by definition
        if (mod.exports.exports.stream().anyMatch(export -> export instanceof TCExportAll)) {
            
            if (mod.exports.exports.size() != 1 || !(mod.exports.exports.get(0) instanceof TCExportAll)) {
                DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_MALFORMED_EXPORTS, mod.exports.exports.get(0).location);
                return result;
            }
            
            List<DafnyExportDefinition> exportDefs = new ArrayList<>(); 
            for (TCDefinition def: mod.exportdefs) {
                // getting the name here is a little tricky :)
                String name;
                if (def instanceof TCValueDefinition) {
                    assert ((TCValueDefinition)def).pattern instanceof TCIdentifierPattern;
                    TCPattern pattern = ((TCValueDefinition)def).pattern;
                    name = ((TCIdentifierPattern)pattern).name.getName();
                }
                else if (def instanceof TCExplicitFunctionDefinition) {
                    name = def.name.getName();
                }
                else if (def instanceof TCTypeDefinition) {
                    name = def.name.getName();
                }
                else {
                    assert def instanceof TCExplicitOperationDefinition;
                    name = def.name.getName();
                }
                
                exportDefs.add(new DafnyExportDefinition(DafnyIdentifiers.instance().transform(name)));
            }
            result.add(new DafnyExportAllDefinition((TCExportAll)mod.exports.exports.get(0), exportDefs));
        }
        // Otherwise use the export definition.
        else {
            for (TCExport export: mod.exports.exports) {
                result.add(new DafnyExportDefinition(export));
            }
        }

        return result;
    }


    public DafnyExportDefinition(String name) {
        this.name = List.of(name);
        this.reveals = true;
        this.export = null;
    }

    /**
     * Create new export definition
     * @param export export definition
     */
    public DafnyExportDefinition(TCExport export) {
        assert (export instanceof TCExportAll) : "Cannot be exports all";
        this.export = export;
        if (export instanceof TCExportedFunction) {
            set((TCExportedFunction)export);
        }
        if (export instanceof TCExportedOperation) {
            set((TCExportedOperation)export);
        }
        if (export instanceof TCExportedValue) {
            set((TCExportedValue)export);
        }
        if (export instanceof TCExportedType) {
            set((TCExportedType)export);
        }
    }

    private void set(TCExportedFunction func) {
        this.name = func.nameList.stream().map(name -> DafnyIdentifiers.instance().transform(name)).collect(Collectors.toList());
        this.reveals = true;
    }

    private void set(TCExportedOperation op) {
        this.name = op.nameList.stream().map(name -> DafnyIdentifiers.instance().transform(name)).collect(Collectors.toList());
        DafnyTranslateCommand.warning(DafnyWarningMessage.DAFNY_OPERATIONS_CANNOT_BE_REVEALED_1P, op.location, name);
        this.reveals = false;  // operations cannot be revealed in dafny!
    }

    private void set(TCExportedValue val) {
        this.name = val.nameList.stream().map(name -> DafnyIdentifiers.instance().transform(name)).collect(Collectors.toList());
        this.reveals = true;
    }
    
    private void set(TCExportedType type) {
        this.name = List.of(DafnyIdentifiers.instance().transform(type.name));
        this.reveals = type.struct;
    }

    @Override
    public String translate() {
        return DafnyTemplates.IMPORT.render("export", Pair.of("export", this));
    }

    public TCExport getVDM() {
        return export;
    }

    public List<String> getName() {
        return name;
    }

    public boolean getReveals() {
        return reveals;
    }
    
}
