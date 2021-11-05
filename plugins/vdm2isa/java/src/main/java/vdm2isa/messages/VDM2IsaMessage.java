package vdm2isa.messages;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.VDMMessage;

public class VDM2IsaMessage extends VDMMessage {

    public static final int ISABELLE_ERROR_BASE     = 10000;
    public static final int ISABELLE_WARNING_BASE   = 11000;
    
    public VDM2IsaMessage(int number, String message, LexLocation location) 
    {
        super(number, message, location);
        assert number >= ISABELLE_ERROR_BASE;
    }

    public VDM2IsaMessage(IsaErrorMessage message, LexLocation location)
    {
        this(message.number, message.message, location);
    }

    @Override
	public String toString()
	{
		return String.format("%05d: %s %s", number, message, location);
	}
}
