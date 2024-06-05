package vdm2isa.tr.templates;

import java.util.List;

public abstract class IsaNamedTemplate extends IsaAbstractTemplate {

    public final IsaVDMSource source; 
    public final List<IsaIdentifier> name; 

    protected IsaNamedTemplate(List<String> comment, IsaVDMSource source, List<IsaIdentifier> name)
    {
        super(comment);
        this.source = source; 
        this.name = IsaAbstractTemplate.createList(name); 
    }
}
