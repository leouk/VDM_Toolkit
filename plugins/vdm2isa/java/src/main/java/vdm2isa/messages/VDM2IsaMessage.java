package vdm2isa.messages;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.VDMMessage;

public class VDM2IsaMessage extends VDMMessage {

    public static final int ISABELLE_ERROR_BASE      = 10000;
    public static final int ISABELLE_PLUGIN_BASE     = VDM2IsaMessage.ISABELLE_ERROR_BASE + 0;
    public static final int ISABELLE_VDMSL_BASE      = VDM2IsaMessage.ISABELLE_ERROR_BASE + 100;
    public static final int ISABELLE_ISA_BASE        = VDM2IsaMessage.ISABELLE_ERROR_BASE + 200;
    public static final int ISABELLE_PO_BASE         = VDM2IsaMessage.ISABELLE_ERROR_BASE + 300;

    public static final int ISABELLE_WARNING_BASE    = 11000;

    public VDM2IsaMessage(int number, String message, LexLocation location) 
    {
        super(number, message, location);
        assert number >= VDM2IsaMessage.ISABELLE_ERROR_BASE;
    }

    public VDM2IsaMessage(IsaErrorMessage message, LexLocation location)
    {
        this(message.number, message.message, location);
    }

    @Override
	public String toString()
	{
        String prefix;
        if (number >= VDM2IsaMessage.ISABELLE_PLUGIN_BASE && number < VDM2IsaMessage.ISABELLE_VDMSL_BASE)
            prefix = "PLUGIN";
         else if (number >= VDM2IsaMessage.ISABELLE_VDMSL_BASE && number < VDM2IsaMessage.ISABELLE_ISA_BASE)
            prefix = "VDMSL ";
         else if (number >= VDM2IsaMessage.ISABELLE_ISA_BASE && number < VDM2IsaMessage.ISABELLE_PO_BASE)
            prefix = "ISA";
         else if (number >= VDM2IsaMessage.ISABELLE_PO_BASE && number < VDM2IsaMessage.ISABELLE_WARNING_BASE)
            prefix = "PO"; 
        else
            prefix = "?";
        return String.format("[%s]%05d: %s %s", prefix, number, message, location);
	}
}
