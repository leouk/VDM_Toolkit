package vdm2isa.tr.templates;

import java.util.Arrays;
import java.util.List;

public class IsaClaim extends IsaNamedTemplate {
    
    public static enum ClaimKind { theorem, lemma, corolarry, proposition }

    public final ClaimKind kind;
    public final List<IsaAttribute> attr;
    public final String expr; 
    public final List<String> proof;

    protected IsaClaim(List<String> comment, IsaVDMSource source, ClaimKind kind, IsaIdentifier name, List<IsaAttribute> attr, String expr, List<String> proof)
    {
        super(comment, source, Arrays.asList(name));
        this.kind = kind;
        this.attr = IsaAbstractTemplate.createList(attr); 
        this.expr = expr; 
        this.proof = IsaAbstractTemplate.createList(proof);
    }
}
