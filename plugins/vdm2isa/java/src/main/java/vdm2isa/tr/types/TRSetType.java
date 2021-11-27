package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCSetType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCSet1Type;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRSetType extends TRAbstractInnerTypedType
{
	private static final long serialVersionUID = 1L;
    public final boolean set1;

    /**
     * Constructor needed for TRUnionType
     * @param location
     * @param seqof
     * @param seq1
     */
    public TRSetType(TCType vdmType, TRDefinitionList definitions, TRType setof, boolean set1)
    {
        super(vdmType, definitions, setof);
        this.set1 = set1;
    }

    public TRSetType(TCSetType owner, TRDefinitionList definitions, TRType setof)    
    {
       this(owner, definitions, setof, false);
    }

    public TRSetType(TCSet1Type owner, TRDefinitionList definitions, TRType setof)    
    {
        this(owner, definitions, setof, true);
    }

    @Override
    public TRType copy(boolean atTLD)
    {
        TRType result = this;
        if (getInnerType() == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "set type", "null type?");
        }
        else
        {
            result = new TRSetType(getVDMType(), definitions, getInnerType().copy(true), set1);
            result.setup();
            result.setAtTopLevelDefinition(atTLD);
        }
        return result;
    }

    @Override
    public IsaToken isaToken() {
        return set1 ? IsaToken.SET1 : IsaToken.SET;
    }

    @Override
    public String translate() {
        return getInnerType().translate() + " " + isaToken().toString();
    }

    //lemma "inv_VDMSeq' (inv_VDMSeq' inv_VDMNat1) [[1,2],[1,2]]"
    @Override
    public String invTranslate(String varName) {
        return IsaToken.parenthesise( 
            IsaToken.INV.toString() + isaToken().toString() + IsaToken.DASH.toString() + IsaToken.SPACE.toString() + 
            getInnerType().invTranslate(null) + (varName != null ? IsaToken.SPACE.toString() + varName : ""));
    }

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSetType(this, arg);
	}
}
