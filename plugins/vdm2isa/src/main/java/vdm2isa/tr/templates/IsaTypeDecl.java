package vdm2isa.tr.templates;

import java.util.Arrays;
import java.util.List;

/**
 * Represents an Isabelle type declaration for type syonyms and datatypes. This is used for VDM top-level type definitions (e.g. named types, quote types, etc.).
 */
public class IsaTypeDecl extends IsaNamedTemplate {
    public static enum TypeDeclKind { type_synonym, datatype }
    
    public final TypeDeclKind kind;
    public final List<String> expr; 

    /**
     * VDM does not have polymorphic type declarations; so no multiple identifiers here, but possibly multiple strings!
     * @param comment
     * @param kind
     * @param name
     * @param expr
     */
    protected IsaTypeDecl(String comment, TypeDeclKind kind, IsaIdentifier name, List<String> expr)
    {
        super(comment, Arrays.asList(name));
        if (kind == TypeDeclKind.type_synonym && expr.size() > 1)
            throw new IsaTemplateException("Type synonym cannot have multiple expressions " + expr.toString());
        this.kind = kind; 
        this.expr = IsaAbstractTemplate.createList(expr);
    }
}
