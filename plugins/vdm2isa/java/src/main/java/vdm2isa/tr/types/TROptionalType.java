package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TROptionalType extends TRType {
    private static final long serialVersionUID = 1L;
    
    private final TRType type; 
    
    public TROptionalType(LexLocation location, TRType type)
    {
        super(location);
        this.type = type;
    }

    @Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.INV.toString());
        // transform "option" => "Option" for inv_Option call
        int i = sb.length();
        sb.append(isaToken().toString());
        sb.setCharAt(i, Character.toUpperCase(sb.charAt(i)));
        sb.append(" ");
        // make sure we get the inv check without var name (e.g. inv_VDMNat1 instea of inv_VDMNat1 x)
        sb.append(type.invTranslate(null));
        sb.append(" ");
        sb.append(varName);
        return IsaToken.parenthesise(sb.toString());
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.OPTIONAL;
    }

    @Override
    public String translate() {
        return type.translate() + " " + isaToken().toString();
    }

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseOptionalType(this, arg);
	}
}
