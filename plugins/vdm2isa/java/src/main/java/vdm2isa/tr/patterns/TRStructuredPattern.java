package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.lex.LexLocation;
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
    private final TRPatternList plist;

    protected TRStructuredPattern(LexLocation location, TRPatternList plist, IsaToken token, String pattern)
    {
        super(location);
        this.token = token;
        this.plist = plist;
        this.pattern = pattern;        
    }

    public TRStructuredPattern(TCSetPattern owner, TRPatternList set)
    {  
        this(owner.location, set, IsaToken.SET, IsaToken.bracketit(IsaToken.SET_OPEN, set.translate(), IsaToken.SET_CLOSE));
    }

    public TRStructuredPattern(TCSeqPattern  owner, TRPatternList seq)
    {
        this(owner.location, seq, IsaToken.SEQ, IsaToken.bracketit(IsaToken.SEQ_OPEN, seq.translate(), IsaToken.SEQ_CLOSE));
    }

    public TRStructuredPattern(TCTuplePattern owner, TRPatternList list)
    {
        this(owner.location, list, IsaToken.CROSSPROD, IsaToken.parenthesise(list.translate()));
    }

    public TRStructuredPattern(TCConcatenationPattern owner, TRPattern left, TRPattern right)
    {
        this(owner.location, 
            TRPatternList.newPatternList(left, right),
            IsaToken.CONCATENATE, 
            IsaToken.parenthesise(
                IsaToken.parenthesise(left.translate()) + 
                IsaToken.CONCATENATE.toString() + 
                IsaToken.parenthesise(right.translate())));
    }

    public TRStructuredPattern(TCMapletPattern owner, TRPattern from, TRPattern to)
    {
        this(owner.from.location,//owner is not TCPattern!!! Will be a problem?
            TRPatternList.newPatternList(from, to),
            IsaToken.MAPLET, 
            IsaToken.parenthesise( 
                from.translate() + " " + IsaToken.MAPLET.toString() + " " + to.translate()));
    }

    public TRStructuredPattern(TCUnionPattern owner, TRPattern left, TRPattern right)
    {
        this(owner.location, 
            TRPatternList.newPatternList(left, right),
            IsaToken.UNION, 
            IsaToken.parenthesise(left.translate() + " " + IsaToken.UNION.toString() + " " + right.translate()));
    }

    public TRStructuredPattern(TCMapUnionPattern owner, TRPattern left, TRPattern right)
    {
        this(owner.location, 
            TRPatternList.newPatternList(left, right),
            IsaToken.MUNION, 
            IsaToken.parenthesise(left.translate() + " " + IsaToken.MUNION.toString() + " " + right.translate()));
    }

    public TRStructuredPattern(TCMapPattern owner, TRPatternList maplets)
    {
        this(owner.location, maplets, IsaToken.MAP, IsaToken.bracketit(IsaToken.MAP_OPEN, maplets.translate(), IsaToken.MAP_CLOSE));
    }

    public TRStructuredPattern(TCExpressionPattern owner, TRExpression exp)
    {
        //TODO? percolate these through TRExpression? 
        this(owner.location, new TRPatternList()/*exp.getPatternListList().getFlatPatternList()*/, IsaToken.LPAREN, IsaToken.parenthesise(exp.translate()));
    }

    public TRPatternList getPatternList()
    {
        return plist;
    }

    @Override
    public String getPattern()
    {
        return String.valueOf(pattern);
    }

    //TODO 
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
