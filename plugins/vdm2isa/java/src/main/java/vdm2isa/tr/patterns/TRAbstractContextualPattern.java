package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.patterns.TCPattern;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;

public abstract class TRAbstractContextualPattern extends TRPattern {
    private static final long serialVersionUID = 1L;

    protected final TRPatternList plist;

    protected TRAbstractContextualPattern(TCPattern p, LexLocation location, TRPatternList plist)
    {
        super(p, location);
        this.plist = plist;
    }

    protected abstract String getInvalidPatternMessage();

    @Override 
    public void setup()
    {
        super.setup();
        TRNode.setup(plist);
        if (plist == null || plist.size() == 0)
        {
            report(IsaErrorMessage.ISA_VDM_DISALLOWED_PATTERN_1P, String.valueOf(getInvalidPatternMessage()));
        }
        else
        {
            if (needsPatternContext() || hasStructuredPattern())
            {
                setSemanticSeparator(IsaToken.SEMICOLON.toString() + IsaToken.SPACE.toString());
            }
            if (plist.needsPatternContext() || plist.hasStructuredPattern())
            {
                plist.setSemanticSeparator(IsaToken.SEMICOLON.toString() + IsaToken.SPACE.toString());
            }
            // TRAbstractContextualPattern.setPatternSemanticSeparator(this);
            // for(TRPattern p : plist)
            // {
            //     TRAbstractContextualPattern.setPatternSemanticSeparator(p);
            // } 
        }
        //System.out.println(toString());
    }

    protected abstract String indexedPatternExpression(int index, String varName);

    /**
     * Given the pattern index and the (current) dummy name, project out the pattern for
     * the context (e.g. let-in environment). This must also take into account inner 
     * structured/record patterns. 
     * @param index
     * @param varName
     * @return
     */
    protected String indexedPatternTranslate(int index, String varName)
    {
        assert index >= 0 && index < plist.size();
        StringBuilder sb = new StringBuilder();

        TRPattern p = plist.get(index);
        String patternName;
        if (p instanceof TRBasicPattern)
        {
            // for basic pattern, use pattern = (field_RECORD dummyName)
            patternName = p.invTranslate();
        }
        // for record pattern within another, use inner dummies
        else if (p instanceof TRRecordPattern)
        {
            // for record pattern, use inner dummy name to project the other record parts in the field name
            patternName = varName + Integer.valueOf(index);
        }
        else if (TRStructuredPattern.validStructuredContext(p))
        {
            // for cross prod inner pattern project out the parts too
            patternName = varName + Integer.valueOf(index);
        }
        else //other structured pattern or + (p instanceof TRPatternBind)        = error
        {
            patternName = p.invTranslate();
        }
        sb.append(patternName);
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.EQUALS.toString());
        sb.append(IsaToken.SPACE.toString());

        // get the RHS of the pattern depending on the pattern kind 
        sb.append(indexedPatternExpression(index, varName));

        // if more patterns are needed (i.e. structured + record), then carry on within the inner patterns of the field
        if (p instanceof TRRecordPattern)
        {
            // for record pattern "recurse" on the outer patternName just created as the new dummy, taking into account semantic separator!
            TRRecordPattern rp = (TRRecordPattern)p;
            sb.append(rp.getSemanticSeparator());
            sb.append(rp.patternContextTranslate(patternName));
            //sb.append(rp.indexedPatternTranslate(index, patternName));
        }
        else if (TRStructuredPattern.validStructuredContext(p))
        {
            TRStructuredPattern sp = (TRStructuredPattern)p;
            if (sp.hasStructuredPattern())
            {
                sb.append(sp.getSemanticSeparator());
                sb.append(sp.structuredPatternTranslate(patternName));
            }
        } 
        return sb.toString();
    }
}
