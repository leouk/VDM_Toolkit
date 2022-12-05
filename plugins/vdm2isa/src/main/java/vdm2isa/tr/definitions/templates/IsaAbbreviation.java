package vdm2isa.tr.definitions.templates;

import vdm2isa.tr.templates.IsaIdentifier;

public class IsaAbbreviation extends IsaDefinition {
    
    public IsaAbbreviation(IsaIdentifier name, String type, String expr)
    {
        super(name, type, expr, false);
    }
}
