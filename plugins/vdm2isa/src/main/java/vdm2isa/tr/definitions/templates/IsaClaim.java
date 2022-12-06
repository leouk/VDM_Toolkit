package vdm2isa.tr.definitions.templates;

import java.util.List;

import vdm2isa.tr.templates.IsaAbstractTemplate;
import vdm2isa.tr.templates.IsaIdentifier;
import vdm2isa.tr.templates.IsaNamedTemplate;

public class IsaClaim extends IsaNamedTemplate {
    
    public static enum ClaimKind { theorem, lemma, corolarry, proposition }

    public final ClaimKind kind;
    public final List<IsaAttribute> attr;
    public final String expr; 

    public IsaClaim(ClaimKind kind, IsaIdentifier name, String expr, IsaAttribute... attr)
    {
        this(null, kind, name, expr, attr);
    }

    public IsaClaim(String comment, ClaimKind kind, IsaIdentifier name, String expr, IsaAttribute... attr)
    {
        super(comment, name);
        this.kind = kind;
        this.attr = IsaAbstractTemplate.createList(attr); 
        this.expr = expr; 
    }
}
