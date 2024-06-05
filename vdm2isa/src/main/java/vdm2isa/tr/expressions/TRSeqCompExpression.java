package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCSeqCompExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindKind;

import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRType;

/**
 * Isabelle sequence compression is "[ expr(bind1, bind2) . bind1 <- gen1, bind2 <- gen2, filter ]".
 * VDM sequence compression is "[ expr(bind1) . bin1 in set(q) expr2 & filter ]". If the sequence 
 * comprehension generator is a set bind, it has to be transformed to a list using IsaToken.SETSEQBIND. 
 */
public class TRSeqCompExpression extends TRAbstractCompExpression {
    private static final long serialVersionUID = 1L;

    public TRSeqCompExpression(LexLocation location, 
        TCSeqCompExpression tc,
        TRExpression first, TRMultipleBind bind, 
        TRExpression predicate, TRDefinition def, TRType exptype)
    {
        super(location, tc, first, bind != null ? bind.getMultipleBindList() : null, predicate, def, exptype);
    }

    @Override
    public void setup()
    {
        super.setup();
        assert bindings != null;
        // Tell set bind it's for a sequence
        bindings.setSetSeqForMultiBindList();
        //System.out.println(toString());
    }

    @Override
    protected TRType getBestGuessType()
    {
        return TRSeqType.newSeqType(location, first.getType(), false);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.SEQ;
    }

    public boolean isSetSeqBind()
    {
        return /*this.bindings.foundBinds(TRMultipleBindKind.SET) && */ this.bindings.isSetSeqBind();
    }

    /**
     * Sequence comprehension in Isabelle 
     */
    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();

        sb.append(IsaToken.SEQ_OPEN.toString());
        sb.append(getFormattingSeparator());

        sb.append(first.patternContextTranslate(bindings));

        sb.append(getFormattingSeparator());
        sb.append(IsaToken.POINT.toString());
        sb.append(getFormattingSeparator());
        boolean seqTypeBound = bindings.areBindsUniform(TRMultipleBindKind.TYPE);
        if (seqTypeBound)
        {
            report(IsaErrorMessage.ISA_TYPEBOUND_SEQCOMP);
            sb.append(IsaToken.comment(IsaErrorMessage.ISA_TYPEBOUND_SEQCOMP.message, getFormattingSeparator()));
        }
        // vdmPatternsOnly=false because sequence comp expr are allowed within Isabelle [x+x | x in seq S ] 
        // type binds in sequence don't need compTranslate, given their invariants will be checked later in bindStr 
        String bindCompTranslate = seqTypeBound ? "" : bindings.compTranslate(false);
        sb.append(bindCompTranslate);        
        // include filtering predicates for type binds; include it if not empty
        String bindStr = bindings.invTranslate();
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

            sb.append(predicate.patternContextTranslate(bindings));            
        }
        sb.append(getFormattingSeparator());
        sb.append(IsaToken.SEQ_CLOSE.toString());
        if (isSetSeqBind() && !bindings.isSetSeqBindLinearOrdered())
        {
            assert !bindings.isEmpty();
            sb.append("\n\t");//getFormattingSeparator());
            sb.append(IsaToken.comment(IsaInfoMessage.VDM_SEQCOMP_BIND_PROBLEM_3P.format(
                IsaWarningMessage.ISA_SEQCOMP_LINEAR_TYPEBIND_1P.format(bindings.translate()),
                getFormattingSeparator(),
                IsaToken.antiquotation(IsaToken.ISAR_TERM, bindings.getRHS().translate())), getFormattingSeparator()));
            //warning(IsaWarningMessage.ISA_SEQCOMP_LINEAR_TYPEBIND_1P, bindStr);
        }
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSeqCompExpression(this, arg);
	}
}
