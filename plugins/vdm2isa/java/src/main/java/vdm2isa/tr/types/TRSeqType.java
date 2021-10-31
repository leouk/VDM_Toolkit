package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCSeqType;
import com.fujitsu.vdmj.tc.types.TCSeq1Type;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRSeqType extends TRType
{
	private static final long serialVersionUID = 1L;
    private final TRType seqof;
    private final boolean seq1;

    public TRSeqType(TCSeqType owner, TRType seqof)    
    {
        super(owner.location);
        this.seqof = seqof;
        this.seq1 = false;
    }

    public TRSeqType(TCSeq1Type owner, TRType seqof)    
    {
        super(owner.location);
        this.seqof = seqof;
        this.seq1 = true;
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
