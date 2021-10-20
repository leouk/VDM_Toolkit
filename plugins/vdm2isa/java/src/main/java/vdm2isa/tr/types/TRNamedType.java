package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;

public class TRNamedType extends TRInvariantType
{
	private static final long serialVersionUID = 1L;
    private final TCNameToken typename;
    private final TRType type;
    
    public TRNamedType(TCNameToken typename, TRType type)
    {
        super(typename.getLocation());
        this.typename = typename;
        this.type = type;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String translate() {
        return typename.toString() + " = " + type.translate();
    }

    @Override
	public String invTranslate(String varName) {
		return IsaToken.LPAREN.toString() +
            IsaToken.INV.toString() + typename +
            (varName != null ? " " + varName : "") + 
            IsaToken.RPAREN.toString();
	}
}
