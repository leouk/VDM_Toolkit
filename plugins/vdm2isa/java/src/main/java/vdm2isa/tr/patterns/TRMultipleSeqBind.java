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
    public String compTranslate(boolean patternsOnly)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(plist.translate());
        if (!patternsOnly)
        {
            sb.append(" ");
            sb.append(IsaToken.SEQBIND.toString());
            sb.append(" ");
            sb.append(seq.translate());
        } 
        return sb.toString();
    }
    
    @Override
    public String translate() {
        return plist.translate() + " " + isaToken().toString() + " " + 
            IsaToken.parenthesise(IsaToken.ELEMS.toString() + " " + seq.translate());
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
