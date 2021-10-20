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
    public String invTranslate(String varName) 
    {
        StringBuilder sb = new StringBuilder();
        sb.append("(");
        sb.append(IsaToken.INV.toString());
        // transform "map" => "Map" for inv_Map call
        int i = sb.length();
        sb.append(isaToken().vdmToken().toString());
        sb.setCharAt(i, Character.toUpperCase(sb.charAt(i)));
        // make sure we get the inv check without var name (e.g. inv_VDMNat1 instea of inv_VDMNat1 x)
        sb.append(from.invTranslate(null));
        sb.append(" ");
        sb.append(to.invTranslate(null));
        sb.append(" ");
        sb.append(varName);
        sb.append(")");
        return sb.toString();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.MAP;
    }    


}
