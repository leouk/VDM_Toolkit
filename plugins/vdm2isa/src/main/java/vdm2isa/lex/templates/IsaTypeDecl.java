package vdm2isa.lex.templates;

import java.util.List;

public class IsaTypeDecl extends IsaAbstractTemplate {
    public static enum TypeDeclKind { type_synonym, datatype }
    
    public final TypeDeclKind kind;
    public final String name;
    public final List<String> expr; 

    public IsaTypeDecl(TypeDeclKind kind, String name, String... expr)
    {
        this.kind = kind; 
        this.name = name; 
        this.expr = IsaAbstractTemplate.createList(expr);
        if (this.kind == TypeDeclKind.type_synonym && this.expr.size() > 1)
            throw new IsaTemplateException("Type synonym cannot have multiple expressions " + this.expr.toString());
    }
}
