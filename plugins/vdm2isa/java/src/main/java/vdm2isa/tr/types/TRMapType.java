package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRMapType extends TRType
{
    private static final long serialVersionUID = 1L;
	private final TRType from;
	private final TRType to;

	public TRMapType(LexLocation location, TRType from, TRType to)
	{
		super(location);
		this.from = from;
		this.to = to;
	}

    @Override
    public String translate() {
        return from.translate() + " " + isaToken() + " " + to.translate();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.MAP;
    }    
}
