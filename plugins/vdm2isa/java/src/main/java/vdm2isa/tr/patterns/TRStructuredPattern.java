package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.Set;
import java.util.TreeSet;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.patterns.TCConcatenationPattern;
import com.fujitsu.vdmj.tc.patterns.TCExpressionPattern;
import com.fujitsu.vdmj.tc.patterns.TCMapPattern;
import com.fujitsu.vdmj.tc.patterns.TCMapUnionPattern;
import com.fujitsu.vdmj.tc.patterns.TCMapletPattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCSeqPattern;
import com.fujitsu.vdmj.tc.patterns.TCSetPattern;
import com.fujitsu.vdmj.tc.patterns.TCTuplePattern;
import com.fujitsu.vdmj.tc.patterns.TCUnionPattern;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;
import vdm2isa.tr.types.TRProductType;

public class TRStructuredPattern extends TRAbstractContextualPattern {
    
    private static final long serialVersionUID = 1L;

    private final IsaToken token;
    private String pattern; 
    private TRExpression exp;

    public static final Set<IsaToken> VALID_STRUCTURED_PATTERNS = new TreeSet<IsaToken>(
        Arrays.asList(IsaToken.SET, IsaToken.SEQ, IsaToken.CROSSPROD, IsaToken.CONCATENATE, 
                      IsaToken.MAPLET, IsaToken.UNION, IsaToken.MUNION, IsaToken.MAP
                      //,IsaToken.LPAREN //@NB not this one?
                      )
    );

    private TRStructuredPattern(TCPattern p, TRPatternList plist, IsaToken token)
    {
        super(p, p != null ? p.location : LexLocation.ANY, plist);
        this.token = token;
        this.pattern = null;        
        this.exp = null;
    }

    public TRStructuredPattern(TCSetPattern owner, TRPatternList set)
    {  
        this(owner, set, IsaToken.SET);
    }

    public TRStructuredPattern(TCSeqPattern  owner, TRPatternList seq)
    {
        this(owner, seq, IsaToken.SEQ);
    }

    public TRStructuredPattern(TCTuplePattern owner, TRPatternList list)
    {
        this(owner, list, IsaToken.CROSSPROD);
    }

    public TRStructuredPattern(TCConcatenationPattern owner, TRPattern left, TRPattern right)
    {
        //@NB what if any of left/right is null? 
        this(owner, TRPatternList.newPatternList(left, right), IsaToken.CONCATENATE);
    }

    public TRStructuredPattern(TCMapletPattern owner, TRPattern from, TRPattern to)
    {
        this(owner.from,//owner is not TCPattern!!! Will be a problem?
            TRPatternList.newPatternList(from, to),
            IsaToken.MAPLET);
    }

    public TRStructuredPattern(TCUnionPattern owner, TRPattern left, TRPattern right)
    {
        this(owner, 
            TRPatternList.newPatternList(left, right),
            IsaToken.UNION);
    }

    public TRStructuredPattern(TCMapUnionPattern owner, TRPattern left, TRPattern right)
    {
        this(owner, 
            TRPatternList.newPatternList(left, right),
            IsaToken.MUNION);
    }

    public TRStructuredPattern(TCMapPattern owner, TRPatternList maplets)
    {
        this(owner, maplets, IsaToken.MAP);
    }

    public TRStructuredPattern(TCExpressionPattern owner, TRExpression exp)
    {
        //TODO? percolate these through TRExpression? 
        this(owner, new TRPatternList()/*exp.getPatternListList().getFlatPatternList()*/, IsaToken.LPAREN);
        this.exp = exp;
    }

    @Override 
    public void setup()
    {
        super.setup();
        String old = plist.getSemanticSeparator();
        plist.setSemanticSeparator(IsaToken.COMMA.toString() + IsaToken.SPACE.toString());
        switch (isaToken())
        {
            case SET:
                pattern = IsaToken.bracketit(IsaToken.SET_OPEN, plist.translate(), IsaToken.SET_CLOSE);
                break;
            case SEQ: 
                pattern = IsaToken.bracketit(IsaToken.SEQ_OPEN, plist.translate(), IsaToken.SEQ_CLOSE);
                break;
            case CROSSPROD: 
                pattern = IsaToken.parenthesise(plist.translate());
                break;
            case CONCATENATE: 
                assert plist.size() == 2; //left+right
                pattern = IsaToken.parenthesise(
                    IsaToken.parenthesise(plist.get(0).translate()) + 
                    IsaToken.CONCATENATE.toString() + 
                    IsaToken.parenthesise(plist.get(1).translate()));
                break;
            case MAPLET:
                assert plist.size() == 2; //from+to
                pattern = IsaToken.parenthesise(plist.get(0).translate() + 
                    IsaToken.SPACE.toString() + IsaToken.MAPLET.toString() +
                    IsaToken.SPACE.toString() + plist.get(1).translate()); 
                break;
            case UNION:
                assert plist.size() == 2; //left+right
                pattern = IsaToken.parenthesise(plist.get(0).translate() + 
                    IsaToken.SPACE.toString() + IsaToken.UNION.toString() + 
                    IsaToken.SPACE.toString() + plist.get(1).translate());
                break;
            case MUNION: 
                assert plist.size() == 2; //left+right
                pattern = IsaToken.parenthesise(plist.get(0).translate() + 
                    IsaToken.SPACE.toString() + IsaToken.MUNION.toString() + 
                    IsaToken.SPACE.toString() + plist.get(1).translate());
                break;
            case MAP:
                pattern = IsaToken.bracketit(IsaToken.MAP_OPEN, plist.translate(), IsaToken.MAP_CLOSE);
                break;
            case LPAREN: 
                assert exp != null;
                TRNode.setup(exp);
                pattern = IsaToken.parenthesise(exp.translate());
                break;
            default:
                pattern = "null";
                break;
        }
        plist.setSemanticSeparator(old);
        assert pattern != null;
    }

    @Override
    public String toString()
    {
        return super.toString() + " [" + String.valueOf(plist) + "]";
    }

    public TRPatternList getPatternList()
    {
        return plist;
    }

    @Override
    public String patternTranslate()
    {
        String result; 
        switch (isaToken())
        {
            case SET:
            case SEQ: 
            case CONCATENATE: 
            case MAPLET:
            case UNION:
            case MUNION: 
            case MAP:
                result = pattern;
                report(IsaErrorMessage.ISA_INVALID_PATTERN_TRANSLATE_4P, pattern, "structured", isaToken().toString(), getClass().getSimpleName());
                break;
            case LPAREN: 
                result = pattern;
                break;
            case CROSSPROD: 
                result = IsaToken.dummyVarNames(1, getDummyFreshness(), location);
                break;
            default:
                result = null;
        }
        return result;
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

    @Override 
    public boolean needsPatternContext()
    {
        return TRStructuredPattern.validStructuredContext(this);
    }

    public static final boolean validStructuredContext(TRPattern p) {
        return p instanceof TRStructuredPattern && Arrays.asList(IsaToken.CROSSPROD/*, IsaToken.CONCATENATE*/).contains(p.isaToken());
    }

    @Override
    protected String getInvalidPatternMessage() {
        return "VDM structured pattern for cross product size = " + plist.size();
    }

    @Override
    protected String indexedPatternExpression(int index, String dummyName) 
    {
        assert TRStructuredPattern.validStructuredContext(this) && index >= 0 && index < plist.size();
        return TRProductType.fieldProjection(index, getPatternList().size(), dummyName);
    }
}
