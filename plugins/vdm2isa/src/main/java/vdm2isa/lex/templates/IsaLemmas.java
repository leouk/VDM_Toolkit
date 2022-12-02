package vdm2isa.lex.templates;

import java.util.List;

public class IsaLemmas extends IsaAbstractTemplate {

    public final String name;
    public final List<String> lemma; 

    public IsaLemmas(String name, String... lemma)
    {
        this.name = name; 
        this.lemma = IsaAbstractTemplate.createList(lemma);
    }
}
