package vdm2isa.tr.patterns;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRType;

public class TRMultipleSeqBind extends TRMultipleBind 
{
    private static final long serialVersionUID = 1L;

    private TRExpression seq;

    public TRMultipleSeqBind(TRPattern pattern, TRExpression seq)
    {
        this(pattern != null ? pattern.getPatternList() : new TRPatternList(), seq);
    }

    public TRMultipleSeqBind(TRPatternList plist, TRExpression seq)
    {
        super(plist);
        this.seq = seq;
    }

    @Override
    public void setup()
    {
        super.setup();
        if (this.seq == null || !(this.seq.getType() instanceof TRSeqType))
            report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, 
                "seq bind",
                (this.seq == null ? "null" : this.seq.getType().getClass().getSimpleName()),
                "1", "expected seq type");
        TRNode.setup(seq);
    }

    @Override
    public String toString()
    {
        return super.toString() + " " + String.valueOf(plist) + " in seq " + String.valueOf(seq); 
    }
    
    @Override
    public IsaToken isaToken() {
        return IsaToken.INSET;
    }

    @Override
    public String compTranslate(boolean vdmPatternsOnly)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(plist.translate());
        if (!vdmPatternsOnly)
        {
            // translate the bind within comprehension
            sb.append(getFormattingSeparator());
            sb.append(IsaToken.SEQBIND.toString());
            sb.append(getFormattingSeparator());
            sb.append(seq.translate());
        } 
        return sb.toString();
    }
    
    @Override
    public String boundExpressionTranslate(int index, boolean invTr) {
        String rhsStr = IsaToken.parenthesise(IsaToken.ELEMS.toString() + getFormattingSeparator() + getRHS().translate()); 
        return invTr ? 
                IsaToken.parenthesise(plist.get(index).translate() + getFormattingSeparator() + isaToken().toString() + rhsStr)//if invTr issues a inv_SeqElems ?
                : rhsStr;
    }

    @Override
    public TRNode getRHS() {
        return seq;
    }

    /**
     * Returns the set expression inner values type, e.g. x in seq S, 
     * where S = seq of T, leads to x : T.
     */
    @Override 
    public TRType getRHSType()
    {
        return ((TRSeqType)seq.getType()).getInnerType();
    }

	@Override
	public <R, S> R apply(TRMultipleBindVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMultipleSeqBind(this, arg);
	}
}
