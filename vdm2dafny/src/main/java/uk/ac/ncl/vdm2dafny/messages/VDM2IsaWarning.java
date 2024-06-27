package uk.ac.ncl.vdm2dafny.messages;

import com.fujitsu.vdmj.lex.LexLocation;

public class VDM2IsaWarning extends VDM2DafnyMessage {

    public VDM2IsaWarning(int number, String message, LexLocation location)
	{
		super(number, message, location);
	}

	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder();	
		sb.append("Warning ");
		sb.append(super.toString());

		for (String d: details)
		{
			sb.append("\n");
			sb.append(d);
		}

		return sb.toString();
	}
}
