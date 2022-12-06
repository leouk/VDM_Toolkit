package vdm2isa.tr.templates;

import java.util.List;

public abstract class IsaNamedTemplate extends IsaAbstractTemplate {

    public final List<IsaIdentifier> name; 

    protected IsaNamedTemplate(String comment, List<IsaIdentifier> name)
    {
        super(comment);
        this.name = IsaAbstractTemplate.createList(name); 
    }
}
