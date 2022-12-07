package vdm2isa.tr.templates;

import java.util.Arrays;

/**
 * Represents a VDM export declaration for Isabelle as a hiding constant/type.
 */
public class IsaVDMTheoryExport extends IsaNamedTemplate {

    public enum ExportKind { hide_type, hide_const }

    public final ExportKind kind; 
    
    // leading VDM export might have a comment? To avoid multiple comments
    public IsaVDMTheoryExport(String comment, ExportKind kind, IsaIdentifier name)
    {
        super(comment, Arrays.asList(name));
        this.kind = kind; 
    }
}
