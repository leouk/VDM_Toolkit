package vdm2isa.tr.templates;

import java.util.List;

/**
 * Represents an Isabelle definition. This is used mostly for VDM (inv/pre/post, etc.) specifications.
 */
public class IsaDefinition extends IsaNamedTemplate {
    
    public final List<String> type;
    public final List<IsaAttribute> attr;
    public final String expr;
    public final Boolean eq; 
    
    protected IsaDefinition(String comment, List<IsaIdentifier> name, List<String> type, List<IsaAttribute> attr, Boolean eq, String expr)
    {
        super(comment, name);
        this.type = IsaAbstractTemplate.createList(type);
        this.expr = expr; 
        this.eq = eq; 
        this.attr = IsaAbstractTemplate.createList(attr);
        if (this.type.size() != this.name.size())
            throw new IsaTemplateException("Invalid definition signature: names=" + name.toString() + "; types=" + type.toString());
    }
}
