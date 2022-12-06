package vdm2isa.tr.templates;

import java.util.List;

/**
 * Represents an Isabelle lemmas. This is used mostly for collecting all VDM names within a definition (e.g. pre_f_def inv_VDMNat_def etc.).
 */
public class IsaLemmas extends IsaNamedTemplate {

    public final List<String> lemma; 

    protected IsaLemmas(IsaIdentifier name, String... lemma)
    {
        this(null, name, lemma);
    }

    protected IsaLemmas(String comment, IsaIdentifier name, String... lemma)
    {
        super(comment, name); 
        this.lemma = IsaAbstractTemplate.createList(lemma);
    }

}
