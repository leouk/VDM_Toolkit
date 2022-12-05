package vdm2isa.lex.templates;

import java.util.List;

public class IsaLemmas extends IsaNamedTemplate {

    public final List<String> lemma; 

    public IsaLemmas(IsaIdentifier name, String... lemma)
    {
        super(name); 
        this.lemma = IsaAbstractTemplate.createList(lemma);
    }
}
