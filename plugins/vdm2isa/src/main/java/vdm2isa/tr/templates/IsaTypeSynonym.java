package vdm2isa.tr.templates;

import java.util.Arrays;

/**
 * Represents an Isabelle type declaration for type syonyms and datatypes. This is used for VDM top-level type definitions (e.g. named types, quote types, etc.).
 */
public class IsaTypeSynonym extends IsaNamedTemplate {
    
    public final String expr; 

    /**
     * VDM does not have polymorphic type declarations; so no multiple identifiers here, but possibly multiple strings!
     * @param comment
     * @param kind
     * @param name
     * @param expr
     */
    protected IsaTypeSynonym(String comment, IsaIdentifier name, String expr)
    {
        super(comment, Arrays.asList(name));
        this.expr = expr;
    }
}
