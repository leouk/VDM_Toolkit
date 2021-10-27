package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCInMapType;
import com.fujitsu.vdmj.tc.types.TCMapType;

import vdm2isa.lex.IsaToken;

public class TRMapType extends TRType
{
    private static final long serialVersionUID = 1L;
	private final TRType from;
	private final TRType to;
    private final boolean injective;

	public TRMapType(TCMapType owner, LexLocation location, TRType from, TRType to)
	{
		super(location);
		this.from = from;
		this.to = to;
        this.injective = false;
	}

	public TRMapType(TCInMapType owner, LexLocation location, TRType from, TRType to)
	{
		super(location);
		this.from = from;
		this.to = to;
        this.injective = true;
	}

    @Override
    public String translate() {
        return from.translate() + " " + isaToken() + " " + to.translate();
    }

    @Override
    public String invTranslate(String varName) 
    {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.INV.toString());
        // transform "map" => "Map" for inv_Map call
        //          "inmap"=> "Inmap" for inv_Inmap call
        int i = sb.length();
        sb.append(isaToken().vdmToken().toString());
        sb.setCharAt(i, Character.toUpperCase(sb.charAt(i)));
        sb.append(" ");
        // make sure we get the inv check without var name (e.g. inv_VDMNat1 instea of inv_VDMNat1 x)
        sb.append(from.invTranslate(null));
        sb.append(" ");
        sb.append(to.invTranslate(null));
        sb.append(" ");
        sb.append(varName);
        return IsaToken.parenthesise(sb.toString());
    }

    @Override
    public IsaToken isaToken() {
        return injective ? IsaToken.INMAP : IsaToken.MAP;
    }    


}
