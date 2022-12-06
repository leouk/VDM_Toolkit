package vdm2isa.tr.templates;

public abstract class IsaNamedTemplate extends IsaAbstractTemplate {

    public final IsaIdentifier name; 

    protected IsaNamedTemplate(String comment, IsaIdentifier name)
    {
        super(comment);
        this.name = name; 
    }

    protected IsaNamedTemplate(IsaIdentifier name)
    {
        super();
        this.name = name; 
    }
}
