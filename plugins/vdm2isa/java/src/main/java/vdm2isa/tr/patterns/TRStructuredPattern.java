package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.tc.patterns.TCConcatenationPattern;
import com.fujitsu.vdmj.tc.patterns.TCExpressionPattern;
import com.fujitsu.vdmj.tc.patterns.TCMapPattern;
import com.fujitsu.vdmj.tc.patterns.TCMapUnionPattern;
import com.fujitsu.vdmj.tc.patterns.TCMapletPattern;
import com.fujitsu.vdmj.tc.patterns.TCSeqPattern;
import com.fujitsu.vdmj.tc.patterns.TCSetPattern;
import com.fujitsu.vdmj.tc.patterns.TCTuplePattern;
import com.fujitsu.vdmj.tc.patterns.TCUnionPattern;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;

public class TRStructuredPattern extends TRPattern {
    
    private static final long serialVersionUID = 1L;

    private final IsaToken token;
    private final String pattern; 

    public TRStructuredPattern(TCSetPattern owner, TRPatternList set)
    {  
        super(owner);
        this.token = IsaToken.SET;
        this.pattern = IsaToken.bracketit(IsaToken.SET_OPEN, set.translate(), IsaToken.SET_CLOSE);
    }

    public TRStructuredPattern(TCSeqPattern  owner, TRPatternList seq)
    {
        super(owner);
        this.token = IsaToken.SEQ;
        this.pattern = IsaToken.bracketit(IsaToken.SEQ_OPEN, seq.translate(), IsaToken.SEQ_CLOSE);
    }

    public TRStructuredPattern(TCTuplePattern owner, TRPatternList list)
    {
        super(owner);
        this.token = IsaToken.CROSSPROD;
        this.pattern = IsaToken.parenthesise(list.translate());
    }

    public TRStructuredPattern(TCConcatenationPattern owner, TRPattern left, TRPattern right)
    {
        super(owner);
        this.token = IsaToken.CONCATENATE;
        this.pattern = IsaToken.parenthesise(
                IsaToken.parenthesise(left.translate()) + 
                IsaToken.CONCATENATE.toString() + 
                IsaToken.parenthesise(right.translate()));
    }

    public TRStructuredPattern(TCMapletPattern owner, TRPattern from, TRPattern to)
    {
        super(from.location);//owner is not TCPattern!
        this.token = IsaToken.MAPLET;
        this.pattern = IsaToken.parenthesise( 
            from.translate() + " " + IsaToken.MAPLET.toString() + " " + to.translate());
    }

    public TRStructuredPattern(TCUnionPattern owner, TRPattern left, TRPattern right)
    {
        super(owner);
        this.token = IsaToken.UNION;
        this.pattern = IsaToken.parenthesise(
            left.translate() + " " + IsaToken.UNION.toString() + " " + right.translate());
    }

    public TRStructuredPattern(TCMapUnionPattern owner, TRPattern left, TRPattern right)
    {
        super(owner);
        this.token = IsaToken.MUNION;
        this.pattern = IsaToken.parenthesise(
            left.translate() + " " + IsaToken.MUNION.toString() + " " + right.translate());
    }

    public TRStructuredPattern(TCMapPattern owner, TRPatternList maplets)
    {
        super(owner);
        this.token = IsaToken.MAP;
        this.pattern = IsaToken.bracketit(IsaToken.MAP_OPEN, maplets.translate(), IsaToken.MAP_CLOSE);
    }

    public TRStructuredPattern(TCExpressionPattern owner, TRExpression exp)
    {
        super(owner);
        this.token = IsaToken.MAP;
        this.pattern = IsaToken.parenthesise(exp.translate());
    }

    @Override
    public String getPattern()
    {
        return String.valueOf(pattern);
    }

    @Override
    public String translate() {
        return getPattern();
    }

    // @Override
    // public String invTranslate() {
    //     return pattern;
    // }

    @Override
    public IsaToken isaToken() {
        return token;
    }

	@Override
	public <R, S> R apply(TRPatternVisitor<R, S> visitor, S arg)
	{
		return visitor.caseStructuredPattern(this, arg);
	}
}
