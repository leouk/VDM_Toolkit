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
            if (needsPatternContext())
            {
                setSemanticSeparator(IsaToken.SEMICOLON.toString() + IsaToken.SPACE.toString());
            }
            if (plist.needsPatternContext())
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
        // record patternss have them; structured patterns might. Pass the adequate (new) context pattern name, not given one!  
        if (p.needsPatternContext())
        {
            sb.append(p.getSemanticSeparator());
            sb.append(p.patternContextTranslate(patternName));
            //sb.append(p.indexedPatternTranslate(index, patternName));
        }
        return sb.toString();
    }

    /**
     * On the actual record pattern, invTranslate its TRPatternList with SEMICOLONS. This sets up the 
     * local declaration context to unpick projected fields. The TRPatternList.patternContextTranslate(null)
     * call will handle let-in and parenthesis.   
     * @return
     */
    @Override
    public String patternContextTranslate(String varName)
    {
        StringBuilder sb = new StringBuilder();
        String dummyName = varName == null ? translate() : varName;
		if (!plist.isEmpty())
		{
            sb.append(indexedPatternTranslate(0, dummyName));
            for (int i=1; i < plist.size(); i++)
			{
                sb.append(getSemanticSeparator());
                sb.append(indexedPatternTranslate(i, dummyName));
			}
		}
		return sb.toString();
    }
}
