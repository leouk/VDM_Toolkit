package vdm2isa.messages;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.VDMMessage;

public class VDM2IsaMessage extends VDMMessage {

    private static final int ISABELLE_ERROR_BASE   = 10000;
    
    public VDM2IsaMessage(int number, String message, LexLocation location) 
    {
        super(number, message, location);
        assert number >= ISABELLE_ERROR_BASE;
    }

    @Override
	public String toString()
	{
		return String.format("%05d: %s %s", number, message, location);
	}
}
