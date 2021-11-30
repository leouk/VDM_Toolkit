package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCQuoteType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
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
    public TRType copy(boolean atTLD)
    {
        TRType result = new TRQuoteType((TCQuoteType)getVDMType(), definitions, value);
        TRNode.setup(result);
        result.setAtTopLevelDefinition(atTLD);
        return result;
    }

    // Do not implement this: the type name *must* come from inference through declared quote literal as a named type! 
    // @Override 
    // public String getName()
    // {
    //     return value;
    // }
    
    @Override
    public String translate() 
    {
        return TRTypeSet.prefixTranslate(this, true, getName());
        //return value;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.VDMQUOTE;
    }
    
    @Override
	public String invTranslate(String varName) {
		// there is no "inv_True" in the translation for completeness. 
		String typeStr = IsaToken.INV.toString() + IsaToken.TRUE.toString();
        return IsaToken.parenthesise(typeStr + (varName == null ? "" : IsaToken.SPACE.toString() + varName));
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseQuoteType(this, arg);
	}

    /**
     *  Repeated quoted types across different types won't be allowed either (i.e. quote type must be part of)
     */
    @Override
    public void checkForUnionTypes() {
        report(IsaErrorMessage.ISA_INVALID_UNIONTYPE_1P, "quote type");   
    }
}
