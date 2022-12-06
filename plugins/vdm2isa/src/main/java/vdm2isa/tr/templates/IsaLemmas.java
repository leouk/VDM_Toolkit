package vdm2isa.tr.templates;

import java.util.Arrays;
import java.util.List;

/**
 * Represents an Isabelle lemmas. This is used mostly for collecting all VDM names within a definition (e.g. pre_f_def inv_VDMNat_def etc.).
 */
public class IsaLemmas extends IsaNamedTemplate {

    public final List<IsaIdentifier> lemma; 

    protected IsaLemmas(String comment, IsaIdentifier name, List<IsaIdentifier> lemma)
    {
        super(comment, Arrays.asList(name)); 
        this.lemma = IsaAbstractTemplate.createList(lemma);
    }
}
