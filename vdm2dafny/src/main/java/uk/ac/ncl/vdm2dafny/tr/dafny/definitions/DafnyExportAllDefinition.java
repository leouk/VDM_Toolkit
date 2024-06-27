package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.List;

import com.fujitsu.vdmj.tc.modules.TCExportAll;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyExportAllDefinition extends DafnyExportDefinition {
    private List<DafnyExportDefinition> exports;

    public DafnyExportAllDefinition(TCExportAll export, List<DafnyExportDefinition> exports) {
        super(export);
        this.exports = exports;
    }

    @Override
    public String translate() {
        return DafnyTemplates.IMPORT.render("exportAll", Pair.of("export", this));
    }

    public List<DafnyExportDefinition> getExports() {
        return exports;
    }
}
