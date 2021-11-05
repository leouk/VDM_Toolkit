package vdm2isa.messages;

public enum IsaMessage {
    
    TEST(11111, " ");

    public final int number;
    public final String message; 

    private IsaMessage(int number, String message)
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
