package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.patterns.TCRecordPattern;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;
import vdm2isa.tr.types.TRType;

public class TRRecordPattern extends TRPattern {
    
    private final TCNameToken typename;
    private final TRPatternList plist;
    private final TRType type;
    
    public TRRecordPattern(LexLocation location, TCNameToken typename, TRPatternList plist, TRType type)
    {
        super(location);
        this.typename = typename;
        this.plist = plist;
        this.type = type;
        if (this.plist.size() == 0)
            report(IsaErrorMessage.ISA_VDM_EMPTYRECORD_PATTERN_1P, typename.toString());
        //System.out.println(toString());
    }

    @Override 
    protected void setup()
    {
        super.setup();
        setSemanticSeparator(IsaToken.SEMICOLON.toString() + " ");
    }

    @Override 
    public String getPattern()
    {
        return typeAware(IsaToken.bracketit(IsaToken.LRECORD, String.valueOf(plist), IsaToken.RRECORD));
    }

    @Override
    public String toString()
    {
        return super.toString() + 
            "\n\t tname = " + String.valueOf(typename) + 
            "\n\t plist = " + String.valueOf(plist) + //.translate() + 
            "\n\t type  = " + String.valueOf(type); //type.translate();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.RECORD;
    }

    /**
     * Record patterns translate taking a let into context to allow for user names to be available
     * That means, we are effectively exchanging the pattern for a let, given you can't have record
     * patterns in Isabelle.
     */
    // @Override
    // public String translate() {
    //     return getPatternList().recordPatternTranslate();
    // }
     /**
      * Record patterns translate taking a let into context to allow for user names to be available
      * That means, we are effectively exchanging the pattern for a let, given you can't have record
      * patterns in Isabelle.
     */
     @Override
    public String translate() {
         return IsaToken.dummyVarNames(1, location);
    }
 
    protected String fieldNameTranslate(int index, String dummyName)
    {
        assert index >= 0 && index < plist.size();
        StringBuilder sb = new StringBuilder();
        // only leaf patterns have invTranslate, so this is "safe".
        String fieldName = plist.get(index).invTranslate();
    
        sb.append(fieldName);
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.EQUALS.toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.parenthesise(IsaTemplates.isabelleRecordFieldName(typename.toString(), fieldName) + " " + dummyName));
        return sb.toString();
    }

    @Override 
    public boolean hasRecordPatterns()
    {
        return true;
    }

    /**
     * On the actual record pattern, invTranslate its TRPatternList with SEMICOLONS. This sets up the 
     * local declaration context to unpick projected fields. The TRPatternList.recordPatternTranslate()
     * call will handle let-in and parenthesis.   
     * @return
     */
    @Override
    public String recordPatternTranslate()
    {
        StringBuilder sb = new StringBuilder();
        String dummyName = translate();
		if (!plist.isEmpty())
		{
            sb.append(fieldNameTranslate(0, dummyName));
            for (int i=1; i < plist.size(); i++)
			{
                sb.append(getSemanticSeparator());
                sb.append(fieldNameTranslate(i, dummyName));
			}
		}
		return sb.toString();
    }

    @Override
    public <R, S> R apply(TRPatternVisitor<R, S> visitor, S arg) {
        return visitor.caseRecordPattern(this, arg);
    }
}
