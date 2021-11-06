package vdm2isa.messages;

/**
 * Plugin error messages by category. "_XP" on the name hints at the number of parameters expect
 */
public enum IsaErrorMessage {
     
    //PLUGIN_MESSAGES
              VDMSL_ONLY(VDM2IsaError.ISABELLE_ERROR_BASE + 0, 
                            "Only VDMSL supports Isabelle translation."),
    //POG_MESSAGES
    PO_PROCESSING_ERROR_4P(VDM2IsaError.ISABELLE_ERROR_BASE + 1, 
                            "VDM PO (%1$s) %2$s %3$s error \"%4$s\"; should never happen."),
    PO_INVALID_PO_MODULE_1P(VDM2IsaError.ISABELLE_ERROR_BASE + 2, 
                            "Invalid proof obligations module %1$s"),
    PO_INVALID_DEF_ERROR(VDM2IsaError.ISABELLE_ERROR_BASE + 3, 
                            "Invalid module PO list: only PO expressions or proofs scripts are allowed"),
    //ISA_MESSAGES
    ISA_DUPLICATE_DEF_3P(VDM2IsaError.ISABELLE_ERROR_BASE + 4,
                            "Invalid IsaItem %1$s: %2$s has already been defined in module %3$s"), 
           ISA_SEP_ERROR_2P(VDM2IsaError.ISABELLE_ERROR_BASE + 5,
                            "Invalid %1$s separator: only %2$s characters are allowed separator"),
         ISA_TOKEN_ERROR_1P(VDM2IsaError.ISABELLE_ERROR_BASE + 6,
                            "Invalid VDM SL token %1$s"),
     ISA_DUMMYNAME_ERROR_1P(VDM2IsaError.ISABELLE_ERROR_BASE + 7,
                            "Dummy var names call must be strictly positive; count = %1$s"),


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
