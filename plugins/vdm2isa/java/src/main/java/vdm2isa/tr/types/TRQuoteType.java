package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCQuoteType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRQuoteType extends TRType
{
	private static final long serialVersionUID = 1L;
    private final String value;

    public TRQuoteType(TCQuoteType vdmType, TRDefinitionList definitions, String value) {
        super(vdmType, definitions);
        this.value = value;
    }

    @Override
    public String translate() {
        return value;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.VDMQUOTE;
    }
    
    @Override
	public String invTranslate(String varName) {
		// there is no "inv_True" in the translation for completeness. 
		String typeStr = IsaToken.INV.toString() + IsaToken.UNDERSCORE.toString() + IsaToken.TRUE.toString();
        return IsaToken.parenthesise(typeStr + (varName == null ? "" : " " + varName));
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseQuoteType(this, arg);
	}
}
