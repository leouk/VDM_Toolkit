package vdm2isa.tr.definitions;

/**
 * Determines what kind of implicit specification is associated with some top level definition, 
 * where multiple values may apply. See TCNameToken for corresponding/similar list of such 
 * implicit names. It is also possible to have no name. 
 */
public enum TRSpecificationKind {
    NONE, PRE, POST, INV, EQ, ORD, MAX, MIN, INIT, MEASURE 
}
