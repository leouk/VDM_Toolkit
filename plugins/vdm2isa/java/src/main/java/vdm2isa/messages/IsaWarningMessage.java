package vdm2isa.messages;

/*
 * Plugin warning messages by category. "_XP" on the name hints at the number of parameters expect.
 * Do not add \"v\" within messages, but `v` instead; this is in case message is also issued as an Isabelle comment. 
 */
public enum IsaWarningMessage {

    //Plugin messages relate to incomplete or incompatible issues
    PLUGIN_NYI_2P(VDM2IsaWarning.ISABELLE_W_PLUGIN_BASE + 0, 
        "Not yet implemented %1$s for %2$s"),
    
    VDMSL_VDM10_ONLY(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 0, 
    "Isabelle translation is optimal for VDM_10. You might encounter problems with CLASSIC release."),
    VDMSL_MISSING_RESULT_IN_POST_1P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 1, 
    "Could not find `%1$s` variable in implicit post condition specification definition."),

    ISA_UNKNOWN_VDM_TYPE(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 0, 
    "Unknown VDM types will generate Isabelle additional type variable `a warning."),
    ISA_OPTIONALTYPE_VARIABLE_3P(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 1, 
    "Optional type variable `%1$s` might not need extra @{term the} operator!"),
    ISA_TYPDEF_MINMAX_ORD_1P(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 2, 
    "%1$s type definition min/max specification requires Isabelle type to instantiate `ord` class!"),
    
                      SETCOMP_TYPEBOUND(VDM2IsaWarning.ISABELLE_WARNING_BASE + 1, 
                      "Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!"),

    TEST(21111, " ");

    public final int number;
    public final String message; 

    private IsaWarningMessage(int number, String message)
    {
        assert number >= VDM2IsaError.ISABELLE_WARNING_BASE;
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
