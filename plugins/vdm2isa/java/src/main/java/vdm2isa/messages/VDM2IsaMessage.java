package vdm2isa.messages;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.VDMMessage;

public class VDM2IsaMessage extends VDMMessage {

    public static final int ISABELLE_ERROR_BASE      = 10000;
    public static final int ISABELLE_E_PLUGIN_BASE     = VDM2IsaMessage.ISABELLE_ERROR_BASE + 0;
    public static final int ISABELLE_E_VDMSL_BASE      = VDM2IsaMessage.ISABELLE_ERROR_BASE + 100;
    public static final int ISABELLE_E_ISA_BASE        = VDM2IsaMessage.ISABELLE_ERROR_BASE + 200;
    public static final int ISABELLE_E_PO_BASE         = VDM2IsaMessage.ISABELLE_ERROR_BASE + 300;

    public static final int ISABELLE_WARNING_BASE    = 11000;
    public static final int ISABELLE_W_PLUGIN_BASE     = VDM2IsaMessage.ISABELLE_WARNING_BASE + 0;
    public static final int ISABELLE_W_VDMSL_BASE      = VDM2IsaMessage.ISABELLE_WARNING_BASE + 100;
    public static final int ISABELLE_W_ISA_BASE        = VDM2IsaMessage.ISABELLE_WARNING_BASE + 200;
    public static final int ISABELLE_W_PO_BASE         = VDM2IsaMessage.ISABELLE_WARNING_BASE + 300;

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
        if ((number >= VDM2IsaMessage.ISABELLE_E_PLUGIN_BASE && number < VDM2IsaMessage.ISABELLE_E_VDMSL_BASE) || //[10000..10100[
            (number >= VDM2IsaMessage.ISABELLE_W_PLUGIN_BASE && number < VDM2IsaMessage.ISABELLE_W_VDMSL_BASE)    //[11000..11100[
           )
            prefix = "PLUGIN";
         else if ((number >= VDM2IsaMessage.ISABELLE_E_VDMSL_BASE && number < VDM2IsaMessage.ISABELLE_E_ISA_BASE) || //[10100..10200[
                 (number >= VDM2IsaMessage.ISABELLE_W_VDMSL_BASE && number < VDM2IsaMessage.ISABELLE_W_ISA_BASE))    //[11100..11200[
            prefix = "VDMSL ";
         else if ((number >= VDM2IsaMessage.ISABELLE_E_ISA_BASE && number < VDM2IsaMessage.ISABELLE_E_PO_BASE) || //[10200..10300[
                  (number >= VDM2IsaMessage.ISABELLE_W_ISA_BASE && number < VDM2IsaMessage.ISABELLE_W_PO_BASE))   //[11200..11300[
            prefix = "ISA   ";
         else if ((number >= VDM2IsaMessage.ISABELLE_E_PO_BASE && number < VDM2IsaMessage.ISABELLE_WARNING_BASE) || //[10300..11000[
                  (number >= VDM2IsaMessage.ISABELLE_W_PO_BASE && number < VDM2IsaMessage.ISABELLE_WARNING_BASE+1000))//[11300..12000[
            prefix = "PO    "; 
        else
            prefix = "?     ";
        return String.format("[%s] %05d: %s %s", prefix, number, message, location);
	}
}
