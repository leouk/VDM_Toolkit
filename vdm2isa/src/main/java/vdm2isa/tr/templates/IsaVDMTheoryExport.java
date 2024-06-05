package vdm2isa.tr.templates;

import java.util.Arrays;
import java.util.List;

/**
 * Represents a VDM export declaration for Isabelle as a hiding constant/type.
 */
public class IsaVDMTheoryExport extends IsaNamedTemplate {

    public enum ExportKind { hide_type, hide_const }

    public final ExportKind kind; 
    
    public IsaVDMTheoryExport(List<String> comment, IsaVDMSource source, ExportKind kind, IsaIdentifier name)
    {
        super(comment, source, Arrays.asList(name));
        this.kind = kind; 
    }
}
