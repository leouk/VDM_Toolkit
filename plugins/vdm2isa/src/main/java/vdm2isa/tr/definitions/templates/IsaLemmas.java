package vdm2isa.tr.definitions.templates;

import java.util.List;

import vdm2isa.tr.templates.IsaAbstractTemplate;
import vdm2isa.tr.templates.IsaIdentifier;
import vdm2isa.tr.templates.IsaNamedTemplate;

/**
 * Represents an Isabelle lemmas. This is used mostly for collecting all VDM names within a definition (e.g. pre_f_def inv_VDMNat_def etc.).
 */
public class IsaLemmas extends IsaNamedTemplate {

    public final List<String> lemma; 

    public IsaLemmas(IsaIdentifier name, String... lemma)
    {
        this(null, name, lemma);
    }

    public IsaLemmas(String comment, IsaIdentifier name, String... lemma)
    {
        super(comment, name); 
        this.lemma = IsaAbstractTemplate.createList(lemma);
    }

}
