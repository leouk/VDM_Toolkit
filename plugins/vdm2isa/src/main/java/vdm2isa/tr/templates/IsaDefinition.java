package vdm2isa.tr.templates;

import java.util.List;

/**
 * Represents an Isabelle definition. This is used mostly for VDM (inv/pre/post, etc.) specifications.
 */
public class IsaDefinition extends IsaNamedTemplate {
    
    public final String type;
    public final List<IsaAttribute> attr;
    public final String expr;
    public final Boolean eq; 
    
    public IsaDefinition(IsaIdentifier name, String type, String expr, IsaAttribute... attr)
    {
        this(null, name, type, expr, false, attr);
    }

    public IsaDefinition(IsaIdentifier name, String type, String expr, Boolean eq, IsaAttribute... attr)
    {
        this(null, name, type, expr, eq, attr);
    }

    public IsaDefinition(String comment, IsaIdentifier name, String type, String expr, Boolean eq, IsaAttribute... attr)
    {
        super(comment, name);
        this.type = type;
        this.expr = expr; 
        this.eq = eq; 
        this.attr = IsaAbstractTemplate.createList(attr);
    }
}
