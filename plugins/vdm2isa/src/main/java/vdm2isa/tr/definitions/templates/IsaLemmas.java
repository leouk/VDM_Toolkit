package vdm2isa.tr.definitions.templates;

import java.util.List;

import vdm2isa.tr.templates.IsaAbstractTemplate;
import vdm2isa.tr.templates.IsaIdentifier;
import vdm2isa.tr.templates.IsaNamedTemplate;

public class IsaLemmas extends IsaNamedTemplate {

    public final List<String> lemma; 

    public IsaLemmas(IsaIdentifier name, String... lemma)
    {
        super(name); 
        this.lemma = IsaAbstractTemplate.createList(lemma);
    }
}
