package vdm2isa.lex;

/**
 * Which kind of template item to use. Definition is for invariants etc. DFUNCTION is for non-recursive function definitions
 * RFUN is recursive function definition with Isabelle "fun (domintros)", RFUNCTION used "function (domintros)".
 */
public enum IsaItem {
    ABBREVIATION, INVARIANT, DEFINITION, TYPE_SYNONYM, THEOREM,  DFUNCTION, RFUN, RFUNCTION, OPERATION, DATATYPE, LEMMA;

    private IsaItem() {
    }
}
