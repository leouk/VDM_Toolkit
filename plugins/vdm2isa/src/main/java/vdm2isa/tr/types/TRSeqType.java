package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCSeqType;
import com.fujitsu.vdmj.tc.types.TCType;

import java.util.Set;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCSeq1Type;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRSeqType extends TRAbstractInnerTypedType
{
	private static final long serialVersionUID = 1L;
    public final boolean seq1;
    @SuppressWarnings("unused")
    private final TRType seqof;

    /**
     * Constructor needed for TRUnionType
     * @param location
     * @param seqof
     * @param seq1
     */
    public TRSeqType(TCType vdmType, TRDefinitionList definitions, TRType seqof, boolean seq1)
    {
        super(vdmType, definitions, seqof);
        this.seq1 = seq1;
        this.seqof = seqof; // like TRFunctionType result, which needs the "dangling" field
    }

    public TRSeqType(TCSeqType owner, TRDefinitionList definitions, TRType seqof)    
    {
        this(owner, definitions, seqof, false);
    }

    public TRSeqType(TCSeq1Type owner, TRDefinitionList definitions, TRType seqof)    
    {
        this(owner, definitions, seqof, true);
    }

    @Override
    public TRType copy(boolean atTLD)
    {
        TRType result = this;
        if (getInnerType() == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "seq type", "null type?");
        }
        else
        {
            result = new TRSeqType(getVDMType(), definitions, getInnerType().copy(true), seq1);
            TRNode.setup(result);
            result.setAtTopLevelDefinition(atTLD);
        }
        return result;
    }

    @Override
    public IsaToken isaToken() {
        return seq1 ? IsaToken.SEQ1 : IsaToken.SEQ;
    }

    @Override
    public String translate() {
        return getInnerType().translate() + " " + isaToken().toString();
    }

    @Override
    protected String getInvTypeString()
    {
        return IsaToken.INV.toString() + isaToken().toString() + IsaToken.DASH.toString();
    }

    @Override
    public Set<String> getDefLemmas()
    {
        Set<String> result = super.getDefLemmas();
        result.add(getInvTypeString() + IsaToken.ISAR_LEMMAS_DEFS.toString());
        return result;
    }

    @Override
    public String invTranslate(String varName) {
        return IsaToken.parenthesise(getInvTypeString() + IsaToken.SPACE.toString() +
            getInnerType().invTranslate(null) + (varName != null ? IsaToken.SPACE.toString() + varName : ""));
    }

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSeqType(this, arg);
	}

    public static final TRSeqType newSeqType(LexLocation location, TRType seqof, boolean seq1)
    {  
        return TRSeqType.newSeqType(location, seqof.getDefinitions(), seqof, seq1);
    }

    public static final TRSeqType newSeqType(LexLocation location, TRDefinitionList definitions, TRType seqof, boolean seq1)
    {
        TCType vdmType = seq1 ? new TCSeq1Type(location, seqof.getVDMType()) : new TCSeqType(location, seqof.getVDMType());
        TRSeqType result = new TRSeqType(vdmType, definitions, seqof, seq1);
        TRNode.setup(result);
        return result;
    }
}
