package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.tc.patterns.TCMultipleSeqBind;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;
import com.fujitsu.vdmj.tc.patterns.TCSeqBind;

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

    public TRExpression seq;

    private static TCMultipleSeqBind figureOutMultipleBind(TCSeqBind tc)
    {
        TCMultipleSeqBind result = null;
        if (tc != null)
        {
            TCPatternList plist = new TCPatternList();
            plist.add(tc.pattern);
            result = new TCMultipleSeqBind(plist, tc.sequence);
        }
        return result;
    }

    public TRMultipleSeqBind(TCSeqBind tc, TRPattern pattern, TRExpression seq)
    {
        this(figureOutMultipleBind(tc),
            pattern != null ? pattern.getPatternList() : new TRPatternList(), 
            seq);
    }

    public TRMultipleSeqBind(TCMultipleSeqBind tc, TRPatternList plist, TRExpression seq)
    {
        super(tc, plist);
        this.seq = seq;
    }

    @Override
    public void setup()
    {
        super.setup();
        // don't chase the ultimate type (blame commit 0e153e14fe3e2ed0991af1b6e8444cafc6e8d691!)
        if (this.seq == null || !(this.seq.getType().ultimateType() instanceof TRSeqType))
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
    public TRMultipleBindKind getMultipleBindKind()
    {
        return TRMultipleBindKind.SEQ;
    }

	@Override
	public <R, S> R apply(TRMultipleBindVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMultipleSeqBind(this, arg);
	}
}
