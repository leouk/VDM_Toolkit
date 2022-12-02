package vdm2isa.lex.templates;

import java.util.List;

public class IsaClaim extends IsaAbstractTemplate {
    
    public static enum ClaimKind { theorem, lemma, corolarry, proposition }

    public final ClaimKind kind;
    public final IsaIdentifier name;
    public final List<IsaAttribute> attr;
    public final String expr; 

    public IsaClaim(ClaimKind kind, IsaIdentifier name, String expr, IsaAttribute... attr)
    {
        this.kind = kind;
        this.name = name; 
        this.attr = IsaAbstractTemplate.createList(attr); 
        this.expr = expr; 
    }
}
