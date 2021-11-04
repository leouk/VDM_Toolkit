package vdm2isa.tr.patterns;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;

public class TRMultipleSeqBind extends TRMultipleBind 
{
    private static final long serialVersionUID = 1L;

    private TRExpression seq;

    public TRMultipleSeqBind(TRPattern pattern, TRExpression seq)
    {
        this(pattern.getPatternList(), seq);
    }

    public TRMultipleSeqBind(TRPatternList plist, TRExpression seq)
    {
        super(plist);
        this.seq = seq;
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
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(plist.translate());
        sb.append(getFormattingSeparator());
        sb.append(isaToken().toString()); 
        sb.append(getFormattingSeparator());
        sb.append(IsaToken.parenthesise(IsaToken.ELEMS.toString() + getFormattingSeparator() + seq.translate()));
        return sb.toString();
    }

    /**
     * Allow invTranslate calls for MultipleSeq bind, given it only contains one pattern;
     * in the context where they are within a mixed type and set/seq binds! 
     */
    @Override
    public String invTranslate()
    {
        // super issues error
        return translate();//super.invTranslate();
    }

    @Override
    public TRNode getRHS() {
        return seq;
    }

	@Override
	public <R, S> R apply(TRMultipleBindVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMultipleSeqBind(this, arg);
	}
}
