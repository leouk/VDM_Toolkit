package vdm2isa.tr.patterns;


import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.patterns.TCIgnorePattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRDefinitionSet;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;
import vdm2isa.tr.types.TRType;

/**
 * All patterns are record-context aware, but only TRRecordPattern properly implements it of course. 
 */
public abstract class TRPattern extends TRNode implements TRRecordContext, TRStructuredContext {
    
    private static final long serialVersionUID = 1L;

    private final TCPattern vdmPattern;

    protected TRPattern(TCPattern p, LexLocation location)
    {
        super(location);
        this.vdmPattern = p == null ? new TCIgnorePattern(location) : p; 
    }

    public TRPatternList getPatternList()
    {
        TRPatternList result = new TRPatternList();
        result.add(this);
        TRNode.setup(result);
        return result; 
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

    protected String indexedPatternTranslate(int index, String dummyName)
    {
        report(IsaErrorMessage.ISA_INVALID_PATTERN_TRANSLATE_3P, getPattern(), index, getClass().getSimpleName());
        return "";
    }

    @Override
    public boolean hasRecordPattern()
    {
        return false;
    }

    @Override 
    public String recordPatternTranslate(String varName)
    {
        return translate();
    }

    @Override
    public boolean hasStructuredPattern()
    {
        return false;
    }

    @Override 
    public String structuredPatternTranslate(String varName)
    {
        return translate();
    }


    public TRDefinitionList getDefinitions(TRType type, NameScope scope) 
    {
        TRDefinitionSet result = new TRDefinitionSet();
        try
        {
            result.addAll(new TRDefinitionList(this.getVDMPattern().getDefinitions(type.getVDMType(), scope)));
        }
        catch (Exception e)
        {
            report(IsaErrorMessage.PLUGIN_UNEXPECTED_ERROR_2P, getVDMPattern().toString(), e.toString());
        }
        result.setup();
        return result.asList();
    }
}
