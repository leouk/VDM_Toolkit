package vdm2isa.tr.templates;

import java.util.List;

/**
 * Represents an Isabelle abbreviation. This is used mostly for VDM values.
 */
public class IsaAbbreviation extends IsaDefinition {
    
    protected IsaAbbreviation(List<String> comment, IsaVDMSource source, List<IsaIdentifier> name, List<String> type, String expr)
    {
        super(comment, source, name, type, null, false, expr);
    }
}
