package uk.ac.ncl.vdm2dafny.messages;

import com.fujitsu.vdmj.lex.LexLocation;

public class VDM2DafnyError extends VDM2DafnyMessage {

    public VDM2DafnyError(int number, String message, LexLocation location)
	{
		super(number, message, location);
	}

    @Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		sb.append("Error   ");
		sb.append(super.toString());

		for (String d: details)
		{
			sb.append("\n");
			sb.append(d);
		}

		return sb.toString();
	}
}
