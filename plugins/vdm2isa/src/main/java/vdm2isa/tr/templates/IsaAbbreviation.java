package vdm2isa.tr.templates;

/**
 * Represents an Isabelle abbreviation. This is used mostly for VDM values.
 */
public class IsaAbbreviation extends IsaDefinition {
    
    protected IsaAbbreviation(IsaIdentifier name, String type, String expr)
    {
        super(name, type, expr, false);
    }

    protected IsaAbbreviation(String comment, IsaIdentifier name, String type, String expr)
    {
        super(comment, name, type, expr, false);
    }
}
