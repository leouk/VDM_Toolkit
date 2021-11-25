package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.patterns.TCIgnorePattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;

/**
 * All patterns are record-context aware, but only TRRecordPattern properly implements it of course. 
 */
public abstract class TRPattern extends TRNode implements TRRecordContext, TRUnionContext {
    
    private static final long serialVersionUID = 1L;

    private final TCPattern vdmPattern;

    protected TRPattern(TCPattern p, LexLocation location)
    {
        super(location);
        this.vdmPattern = p == null ? new TCIgnorePattern(location) : p; 
    }

    public TRPatternList getPatternList()
    {
        TRPatternList list = new TRPatternList();
        list.add(this);
        return list; 
    }

    public TCPattern getVDMPattern()
    {
        return vdmPattern;
    }

    @Override
    public String toString()
    {
        return super.toString() + " = " + getPattern(); // + translate();
    }

    /**
     * Transforms the translated pattern to become type aware, depending on the pattern owner type? 
     * @param pattern
     */
    protected String typeAware(String pattern)
    {
        StringBuilder sb = new StringBuilder();
        if (pattern != null)
        {
            //TODO this won't work because getPossibleType() is returning TUnknownType! :-(
            //if (owner != null && owner.getPossibleType() instanceof TCOptionalType)
            //{
            //    sb.append(IsaToken.parenthesise(IsaToken.OPTIONAL_THE.toString() + IsaToken.parenthesise(pattern)));
            //}
            //else
            {
                //TODO: if owner is null raise a warning? 
                sb.append(pattern);
            }
        }
        return sb.toString();
    }

    /**
     * Some VDM identifiers will cause trouble in Isabelle, like "o" (composition), "MAX" etc. Check them all here.
     */
    protected void checkValidIsaIdentifier()
    {
        if (isaToken().equals(IsaToken.IDENTIFIER) && !IsaToken.validIsaIdentifier(getPattern()))
            report(IsaErrorMessage.ISA_INVALID_IDENTIFIER_1P, getPattern());   
    }

    public abstract String getPattern();

	public abstract <R, S> R apply(TRPatternVisitor<R, S> visitor, S arg);

    @Override
    public String translate()
    {
        return typeAware(getPattern());
    }

    @Override
    public boolean hasRecordPatterns()
    {
        return false;
    }

    @Override 
    public String recordPatternTranslate()
    {
        return translate();
    }

    @Override
    public boolean hasUnionTypes() {
        throw new UnsupportedOperationException("//TODO");
    }

    @Override
    public String unionTypesTranslate(TRExpression body) {
        throw new UnsupportedOperationException("//TODO");
    }
}
