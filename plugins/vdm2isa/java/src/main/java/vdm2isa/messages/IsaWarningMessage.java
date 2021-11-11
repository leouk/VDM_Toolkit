package vdm2isa.messages;

public enum IsaWarningMessage {

    //Plugin messages relate to incomplete or incompatible issues
    PLUGIN_NYI_2P(VDM2IsaWarning.ISABELLE_W_PLUGIN_BASE + 0, 
        "Not yet implemented %1$s for %2$s"),
    
    VDMSL_VDM10_ONLY(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 0, 
    "Isabelle translation is optimal for VDM_10. You might encounter problems with CLASSIC release."),
    VDMSL_MISSING_RESULT_IN_POST_1P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 1, 
    "Could not find `%1$s` variable in implicit post condition specification definition."),

    ISA_OPTIONALTYPE_VARIABLE_3P(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 0, 
    "Optional type variable `%1$s` might not need extra @{term the} operator!"),
    
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
