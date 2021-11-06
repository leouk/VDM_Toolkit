package vdm2isa.messages;

/**
 * Plugin error messages by category. "_XP" on the name hints at the number of parameters expect
 */
public enum IsaErrorMessage {
     
    //PLUGIN_MESSAGES
    PLUGIN_NYI_2P(VDM2IsaError.ISABELLE_ERROR_BASE + 0, 
                            "Not yet implemented %1$s for %2$s"),
    PLUGIN_MISSING_MAPPING_ERROR_2P(VDM2IsaError.ISABELLE_ERROR_BASE + 0,
                            "Cannot yet convert %1$s = %2$s"),
    PLUGIN_UNEXPECTED_ERROR_2P(VDM2IsaError.ISABELLE_ERROR_BASE + 0,
                            "Unexpected exception when converting %1$s = %2$s"),

    //VDM_MESSAGES
         VDMSL_VDM10_ONLY(VDM2IsaError.ISABELLE_ERROR_BASE + 1, 
                            "Only VDMSL supports Isabelle translation."),
    VDMSL_INVALID_PATTERN(VDM2IsaError.ISABELLE_ERROR_BASE + 2, 
                            "Invalid empty bind pattern list."),
    VDMSL_INVALID_PATTERN_BIND(VDM2IsaError.ISABELLE_ERROR_BASE + 3, 
                            "Cannot have null pattern and bind in TRPatternBind"),
    VDMSL_FIELD_MISSING_RECORDTYPE_1P(VDM2IsaError.ISABELLE_ERROR_BASE + 4, 
                            "Field %1$s does not have its record type set."),
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
   ISA_VDM_EMPTYRECORD_PATTERN_1P(VDM2IsaError.ISABELLE_ERROR_BASE + 8,    
                            "Isabelle does not allow empty patterns for VDM record pattern for record type %1$s"),


    TEST(11111, " ");

    //private static final Set<Integer> numbers = new TreeSet<Integer>(); 

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
