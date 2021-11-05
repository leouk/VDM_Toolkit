package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleSetBind;
import vdm2isa.tr.patterns.TRMultipleTypeBind;

/**
 * Isabelle sequence compression is "[ expr(bind1, bind2) . bind1 <- gen1, bind2 <- gen2, filter ]".
 * VDM sequence compression is "[ expr(bind1) . bin1 in set(q) expr2 & filter ]". If the sequence 
 * comprehension generator is a set bind, it has to be transformed to a list using IsaToken.SETSEQBIND. 
 */
public class TRSeqCompExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    private final TRExpression first;
    private final TRMultipleBind bind;
    private final TRExpression predicate;

    public TRSeqCompExpression(LexLocation location, TRExpression first, TRMultipleBind bind, TRExpression predicate)
    {
        super(location);
        this.first = first;
        this.bind = bind;
        this.predicate = predicate;
        // Tell set bind it's for a sequence
        if (this.bind instanceof TRMultipleSetBind)
            ((TRMultipleSetBind)this.bind).seqBind = true;
        //System.out.println(toString());
    }

    @Override 
    protected void setup()
    {
        super.setup();
        setFormattingSeparator(" ");
    }

    @Override
    public String toString()
    {
        return "SeqComp bind = " + bind.getClass().getName() + 
            " plist (" + bind.plist.size() + ")[" + bind.plist.get(0).isaToken().toString() + "] = " + 
            bind.plist.translate();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.SEQ;
    }

    public boolean isSetSeqBind()
    {
        return (this.bind instanceof TRMultipleSetBind) && ((TRMultipleSetBind)this.bind).seqBind;
    }

    /**
     * Sequence comprehension in Isabelle 
     */
    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.SEQ_OPEN.toString());
        sb.append(getFormattingSeparator());
        sb.append(first.translate());
        sb.append(getFormattingSeparator());
        sb.append(IsaToken.POINT.toString());
        sb.append(getFormattingSeparator());
        if (bind instanceof TRMultipleTypeBind)
        {
            String commentStr = "Type bound sequence compression is not supported in Isabelle."; 
            report(11111, commentStr);
            sb.append(IsaToken.comment(commentStr, getFormattingSeparator()));
        }
        // vdmPatternsOnly=false because sequence comp expr are allowed within Isabelle [x+x | x in seq S ] 
        // type binds in sequence don't need compTranslate, given their invariants will be checked later in bindStr 
        String bindCompTranslate = bind instanceof TRMultipleTypeBind ? "" : bind.compTranslate(false);
        sb.append(bindCompTranslate);        
        // include filtering predicates for type binds; include it if not empty
        String bindStr = bind.invTranslate();
        if (!bindStr.isEmpty()) 
        {
            // if there were other bind(s) add comma; or would this never happen because seq bind is singleton? Anyhow. 
            if (!bindCompTranslate.isEmpty())
            {
                sb.append(getFormattingSeparator());
                //TODO should this be AND? (i.e. better in proofs/user readability? semantically equal)
                sb.append(IsaToken.COMMA.toString());
            }
            sb.append(getFormattingSeparator());
            sb.append(bindStr);    
        }
        // include filtering predicate
        if (predicate != null)
        {
            sb.append(getFormattingSeparator());
            // predicate separator in Isabelle is "," not "|"
            sb.append(IsaToken.COMMA.toString());
            sb.append(getFormattingSeparator());
            sb.append(predicate.translate());
        }
        sb.append(getFormattingSeparator());
        sb.append(IsaToken.SEQ_CLOSE.toString());
        if (isSetSeqBind())
        {
            String setbindProblem = "Set bind " + 
                IsaToken.antiquotation(IsaToken.ISAR_TERM, bind.translate()) +
                " in sequence comprehension requires VDM set " + "\n\t" + "  " +
                " to be ordered (i.e. its Isabelle type instantiates type class linorder)." + "\n\t" + "  " + 
                " This can be a problem if the target type of " + 
                IsaToken.antiquotation(IsaToken.ISAR_TERM, bind.getRHS().translate()) + "\n\t" + "  " +
                "has a VDM ord_ predicate.";
            sb.append("\n\t" + IsaToken.comment(setbindProblem));
        }
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSeqCompExpression(this, arg);
	}
}
