package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCBracketType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRBracketType extends TRAbstractInnerTypedType {

    public TRBracketType(TCBracketType vdmType, TRDefinitionList definitions, TRType type) {
        super(vdmType, definitions, type);
    }    

    @Override
	public TRType copy(boolean atTLD)
	{
		TRType result = new TRBracketType((TCBracketType)getVDMType(), definitions, getInnerType().copy(true));
		result.setAtTopLevelDefinition(atTLD);
		return result;
	}


    @Override
    public String invTranslate(String varName) {
        return IsaToken.parenthesise(this.getInnerType().invTranslate(varName));
    }

    @Override
    public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg) {
        return visitor.caseBracketType(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.LPAREN;
    }

    @Override
    public String translate() {
        return IsaToken.parenthesise(this.getInnerType().translate());
    }

    @Override
	public TRType ultimateType()
	{
		return getInnerType();
	}

    @Override
    public String getName()
    {
        return getInnerType().getName();
    }
}
