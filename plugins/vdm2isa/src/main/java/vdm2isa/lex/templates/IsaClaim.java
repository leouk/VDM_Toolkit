package vdm2isa.lex.templates;

import java.util.List;

public class IsaClaim extends IsaNamedTemplate {
    
    public static enum ClaimKind { theorem, lemma, corolarry, proposition }

    public final ClaimKind kind;
    public final List<IsaAttribute> attr;
    public final String expr; 

    public IsaClaim(ClaimKind kind, IsaIdentifier name, String expr, IsaAttribute... attr)
    {
        super(name);
        this.kind = kind;
        this.attr = IsaAbstractTemplate.createList(attr); 
        this.expr = expr; 
    }
}
