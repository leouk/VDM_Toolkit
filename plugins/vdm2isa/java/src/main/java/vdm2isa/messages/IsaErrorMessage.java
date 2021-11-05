package vdm2isa.messages;

public enum IsaErrorMessage {
     
              VDMSL_ONLY(VDM2IsaError.ISABELLE_ERROR_BASE + 0, 
                            "Only VDMSL supports Isabelle translation."),
     PO_PROCESSING_ERROR(VDM2IsaError.ISABELLE_ERROR_BASE + 1, 
                            "VDM PO (%1$s) %2$s %3$s error \"%4$s\"; should never happen."),
    PO_INVALID_PO_MODULE(VDM2IsaError.ISABELLE_ERROR_BASE + 2, 
                            "Invalid proof obligations module %1$s"),
       ISA_DUPLICATE_DEF(VDM2IsaError.ISABELLE_ERROR_BASE + 3,
                            "Invalid IsaItem %1$s: %2$s has already been defined in module %3$s"), 

    TEST(11111, " ");

    public final int number;
    public final String message; 

    private IsaErrorMessage(int number, String message)
    {
        assert number >= VDM2IsaError.ISABELLE_ERROR_BASE;
        this.number = number;
        this.message = message;
    } 

    public String format(Object... args)
    {
        if (args == null)
            return message;
        else
            return String.format(message, args);
    }
}
