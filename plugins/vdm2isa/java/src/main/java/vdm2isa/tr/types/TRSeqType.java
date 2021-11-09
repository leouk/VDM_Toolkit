package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCSeqType;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCSeq1Type;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRSeqType extends TRType
{
	private static final long serialVersionUID = 1L;
    protected final TRType seqof;
    protected final boolean seq1;

    /**
     * Constructor needed for TRUnionType
     * @param location
     * @param seqof
     * @param seq1
     */
    protected TRSeqType(LexLocation location, TRType seqof, boolean seq1)
    {
        super(location);
        this.seqof = seqof;
        this.seq1 = seq1;
    }

    public TRSeqType(TCSeqType owner, TRType seqof)    
    {
        this(owner.location, seqof, false);
    }

    public TRSeqType(TCSeq1Type owner, TRType seqof)    
    {
        this(owner.location, seqof, true);
    }

    @Override
    public IsaToken isaToken() {
        return seq1 ? IsaToken.SEQ1 : IsaToken.SEQ;
    }

    @Override
    public String translate() {
        return seqof.translate() + " " + isaToken().toString();
    }

    @Override
    public String invTranslate(String varName) {
        return IsaToken.parenthesise(IsaToken.INV.toString() + isaToken().toString() + 
            "' " + seqof.invTranslate(null) + (varName != null ? " " + varName : ""));
    }

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSeqType(this, arg);
	}
}
