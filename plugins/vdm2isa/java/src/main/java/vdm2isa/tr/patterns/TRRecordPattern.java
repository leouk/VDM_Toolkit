package vdm2isa.tr.patterns;

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
    
    public TRRecordPattern(TCRecordPattern owner, TCNameToken typename, TRPatternList plist, TRType type)
    {
        super(owner.location);
        this.typename = typename;
        this.plist = plist;
        this.type = type;
        if (this.plist.size() == 0)
            report(IsaErrorMessage.ISA_VDM_EMPTYRECORD_PATTERN_1P, typename.toString());
        //System.out.println(toString());
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
            " tname " + String.valueOf(typename) + 
            " plist = " + String.valueOf(plist) + //.translate() + 
            " type = " + String.valueOf(type); //type.translate();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.RECORD;
    }

    /**
     * Record patterns translate to dummy name, and its invTranslate considers rest? 
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
        sb.append(" ");
        sb.append(IsaToken.EQUALS.toString());
        sb.append(" ");
        sb.append(IsaToken.parenthesise(IsaTemplates.isabelleRecordFieldName(typename.toString(), fieldName) + " " + dummyName));
        return sb.toString();
    }

    /**
     * On the actual record pattern, invTranslate its TRPatternList with SEMICOLONS. This sets up the 
     * local declaration context to unpick projected fields. The TRPatternList.recordPatternTranslate()
     * call will handle let-in and parenthesis.   
     * @return
     */
    public String recordPatternTranslate()
    {
        StringBuilder sb = new StringBuilder();
        String dummyName = translate();
		if (!plist.isEmpty())
		{
            sb.append(fieldNameTranslate(0, dummyName));
            for (int i=1; i < plist.size(); i++)
			{
                sb.append(IsaToken.SEMICOLON.toString() + " ");
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
