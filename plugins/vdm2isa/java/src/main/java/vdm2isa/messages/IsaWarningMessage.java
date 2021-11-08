package vdm2isa.messages;

public enum IsaWarningMessage {
          VDMSL_VDM10(VDM2IsaWarning.ISABELLE_WARNING_BASE + 0, 
                      "Isabelle translation is optimal for VDM_10. You might encounter problems with CLASSIC release."),
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
