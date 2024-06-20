package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import com.fujitsu.vdmj.tc.modules.TCImport;
import com.fujitsu.vdmj.tc.modules.TCImportAll;
import com.fujitsu.vdmj.tc.modules.TCImportedFunction;
import com.fujitsu.vdmj.tc.modules.TCImportedOperation;
import com.fujitsu.vdmj.tc.modules.TCImportedType;
import com.fujitsu.vdmj.tc.modules.TCImportedValue;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;

public class DafnyImportDefinition extends AbstractDafnyNode {
    
    private TCImport imp;
    protected String name;
    protected String rename;
    protected String from;
    protected boolean renamed = false;
    private boolean isAll = false;
    
    public DafnyImportDefinition(String from) {
        isAll = true;
        this.from = DafnyIdentifiers.instance().transform(from);
    }

    /**
     * Create new export definition
     * @param export export definition
     */
    public DafnyImportDefinition(TCImport imp) {
        assert (imp instanceof TCImportAll) : "Cannot be exports all";
        this.imp = imp;
        if (imp instanceof TCImportedFunction) {
            set((TCImportedFunction)imp);
        }
        if (imp instanceof TCImportedOperation) {
            set((TCImportedOperation)imp);
        }
        if (imp instanceof TCImportedValue) {
            set((TCImportedValue)imp);
        }
        if (imp instanceof TCImportedType) {
            set((TCImportedType)imp);
        }
    }

    private void set(TCImportedFunction func) {
        from = DafnyIdentifiers.instance().transform(func.from.name.getName());
        name = DafnyIdentifiers.instance().transform(func.name);
        renamed = func.renamed != null;
        rename = renamed ? DafnyIdentifiers.instance().transform(func.renamed.getName()) : null;
        if (renamed) {
            rename = DafnyIdentifiers.instance().transform(func.renamed.getName());
            DafnyIdentifiers.instance().addTransformation(func.name, func.renamed.getName());
        }
        else {
            rename = "";
        }
    }

    private void set(TCImportedOperation op) {
        from = DafnyIdentifiers.instance().transform(op.from.name.getName());
        name = DafnyIdentifiers.instance().transform(op.name);
        renamed = op.renamed != null;
        rename = renamed ? DafnyIdentifiers.instance().transform(op.renamed.getName()) : null;
        if (renamed) {
            rename = DafnyIdentifiers.instance().transform(op.renamed.getName());
            DafnyIdentifiers.instance().addTransformation(op.name, op.renamed.getName());
        }
        else {
            rename = "";
        }
    }

    private void set(TCImportedValue val) {
        from = DafnyIdentifiers.instance().transform(val.from.name.getName());
        name = DafnyIdentifiers.instance().transform(val.name);
        renamed = val.renamed != null;
        if (renamed) {
            rename = DafnyIdentifiers.instance().transform(val.renamed.getName());
            DafnyIdentifiers.instance().addTransformation(val.name, val.renamed.getName());
        }
        else {
            rename = "";
        }
    }
    
    private void set(TCImportedType type) {
        from = DafnyIdentifiers.instance().transform(type.from.name.getName());
        name = DafnyIdentifiers.instance().transform(type.name.getName());
        renamed = type.renamed != null;
        if (renamed) {
            rename = DafnyIdentifiers.instance().transform(type.renamed.getName());
            DafnyIdentifiers.instance().addTransformation(type.name, type.renamed.getName());
        }
        else {
            rename = "";
        }
    }

    @Override
    public String translate() {
        return DafnyTemplates.IMPORT.render("imp", Pair.of("imp", this));
    }

    public TCImport getVDM() {
        return imp;
    }

    public String getName() {
        return name;
    }

    public String getModule() {
        return from;
    }

    public String getRename() {
        return rename;
    }

    public boolean isAll() {
        return isAll;
    }
}
