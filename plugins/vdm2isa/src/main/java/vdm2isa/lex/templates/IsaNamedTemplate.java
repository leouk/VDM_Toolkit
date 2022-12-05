package vdm2isa.lex.templates;

public abstract class IsaNamedTemplate extends IsaAbstractTemplate {

    public final IsaIdentifier name; 

    protected IsaNamedTemplate(IsaIdentifier name)
    {
        this.name = name; 
    }

}
