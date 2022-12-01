package vdm2isa.lex.templates;

public class IsaTypeDecl {
    public static enum TypeDeclKind { type_synonym, datatype }
    
    public final TypeDeclKind kind;
    public final String name;
    public final String expr; 

    public IsaTypeDecl(TypeDeclKind kind, String name, String expr)
    {
        this.kind = kind; 
        this.name = name; 
        this.expr = expr; 
    }
}
