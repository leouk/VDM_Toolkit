package vdm2isa.lex.templates;

import java.util.List;

public class IsaDefinition extends IsaNamedTemplate {
    
    public final String type;
    public final List<IsaAttribute> attr;
    public final String expr;
    public final Boolean eq; 
    
    public IsaDefinition(IsaIdentifier name, String type, String expr, IsaAttribute... attr)
    {
        this(name, type, expr, false, attr);
    }

    public IsaDefinition(IsaIdentifier name, String type, String expr, Boolean eq, IsaAttribute... attr)
    {
        super(name);
        this.type = type;
        this.expr = expr; 
        this.eq = eq; 
        this.attr = IsaAbstractTemplate.createList(attr);
    }
}
