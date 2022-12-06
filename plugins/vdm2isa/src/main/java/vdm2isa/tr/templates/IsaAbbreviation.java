package vdm2isa.tr.templates;

import java.util.List;

/**
 * Represents an Isabelle abbreviation. This is used mostly for VDM values.
 */
public class IsaAbbreviation extends IsaDefinition {
    
    protected IsaAbbreviation(String comment, List<IsaIdentifier> name, List<String> type, String expr)
    {
        super(comment, name, type, null, false, expr);
    }
}
