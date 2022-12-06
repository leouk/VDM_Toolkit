package vdm2isa.tr.templates;

import java.util.List;

/**
 * Represents an Isabelle type declaration for type syonyms and datatypes. This is used for VDM top-level type definitions (e.g. named types, quote types, etc.).
 */
public class IsaTypeDecl extends IsaNamedTemplate {
    public static enum TypeDeclKind { type_synonym, datatype }
    
    public final TypeDeclKind kind;
    public final List<String> expr; 

    protected IsaTypeDecl(TypeDeclKind kind, IsaIdentifier name, String... expr)
    {
        this(null, kind, name, expr);
    }

    protected IsaTypeDecl(String comment, TypeDeclKind kind, IsaIdentifier name, String... expr)
    {
        super(comment, name);
        this.kind = kind; 
        this.expr = IsaAbstractTemplate.createList(expr);
        if (this.kind == TypeDeclKind.type_synonym && this.expr.size() > 1)
            throw new IsaTemplateException("Type synonym cannot have multiple expressions " + this.expr.toString());
    }
}
