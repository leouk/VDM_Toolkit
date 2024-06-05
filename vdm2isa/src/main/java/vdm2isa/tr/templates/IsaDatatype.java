package vdm2isa.tr.templates;

import java.util.Arrays;
import java.util.List;

/**
 * Represents an Isabelle type declaration for type syonyms and datatypes. This is used for VDM top-level type definitions (e.g. named types, quote types, etc.).
 */
public class IsaDatatype extends IsaNamedTemplate {
    
    public final List<String> expr; 

    /**
     * VDM does not have polymorphic type declarations; so no multiple identifiers here, but possibly multiple strings!
     * @param comment
     * @param kind
     * @param name
     * @param expr
     */
    protected IsaDatatype(List<String> comment, IsaVDMSource source, IsaIdentifier name, List<String> expr)
    {
        super(comment, source, Arrays.asList(name));
        this.expr = IsaAbstractTemplate.createList(expr);
    }
}