package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCBracketType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRBracketType extends TRAbstractInnerTypedType {

    public TRBracketType(TCBracketType vdmType, TRDefinitionList definitions, TRType type) {
        super(vdmType, definitions, type);
    }    

    @Override
	protected TRType doCopy(boolean atTLD)
	{
        TRType result = this;
        if (getInnerType() == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "bracket type", "null type?");
        }
        else
        {
            result = new TRBracketType((TCBracketType)getVDMType(), definitions, getInnerType().copy(true));
            TRNode.setup(result);
            result.setAtTopLevelDefinition(atTLD);
        }
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
        TRType result = getInnerType();
        while (result instanceof TRBracketType)
        {
            result = ((TRBracketType)result).getInnerType();
        }
        // if (result instanceof TRBracketType)
        //     result = ((TRBracketType)result).ultimateType();
        return result;
	}

    @Override
	public TRInvariantType ultimateInvariantType()
	{
		return getInnerType().ultimateInvariantType();
	}

    @Override
    public String getName()
    {
        return getInnerType().getName();
    }
}
