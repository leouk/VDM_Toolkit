package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.tc.patterns.TCBooleanPattern;
import com.fujitsu.vdmj.tc.patterns.TCCharacterPattern;
import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;
import com.fujitsu.vdmj.tc.patterns.TCIgnorePattern;
import com.fujitsu.vdmj.tc.patterns.TCIntegerPattern;
import com.fujitsu.vdmj.tc.patterns.TCNilPattern;
import com.fujitsu.vdmj.tc.patterns.TCQuotePattern;
import com.fujitsu.vdmj.tc.patterns.TCRealPattern;
import com.fujitsu.vdmj.tc.patterns.TCStringPattern;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;

public class TRBasicPattern extends TRPattern {
    
    private static final long serialVersionUID = 1L;

    private final String pattern;
    private IsaToken token;

    public TRBasicPattern(TCIdentifierPattern owner)
    {
        super(owner);
        this.token = IsaToken.IDENTIFIER;
        this.pattern = owner.toString();
    }

    public TRBasicPattern(TCBooleanPattern owner)
    {
        super(owner);
        this.token = IsaToken.BOOL;
        this.pattern = owner.toString();
    }

    public TRBasicPattern(TCCharacterPattern owner)
    {
        super(owner);
        this.token = IsaToken.CHAR;
        this.pattern =  
            IsaToken.ISACHAR + " " + 
                IsaToken.bracketit(IsaToken.ISASTR, 
                    Character.isISOControl(owner.value.unicode) ?
                    Integer.toString(owner.value.unicode) : 
                    Character.toString(owner.value.unicode),//owner.toString(),
                    IsaToken.ISASTR
                );
    }

    public TRBasicPattern(TCIntegerPattern owner)
    {
        super(owner);
        this.token = (owner.value.value >= 0 ? (owner.value.value > 0 ? IsaToken.NAT1 : IsaToken.NAT) : IsaToken.INT);
        this.pattern = owner.toString();
    }

    public TRBasicPattern(TCRealPattern owner)
    {
        super(owner);
        this.token = IsaToken.REAL;
        this.pattern = owner.toString();
    }

    public TRBasicPattern(TCStringPattern owner)
    {
        super(owner);
        this.token = IsaToken.STRING;
        // remove the quotes "value"
        this.pattern = IsaToken.bracketit(IsaToken.ISASTR,
            owner.value.value,//owner.toString(),
            IsaToken.ISASTR);
    }   

    public TRBasicPattern(TCQuotePattern owner)
    {
        super(owner);
        this.token = IsaToken.QUOTE;
        this.pattern = owner.value.value;//owner.toString();
    }

    public TRBasicPattern(TCNilPattern owner)
    {
        super(owner);
        this.token = IsaToken.NIL;
        this.pattern = IsaToken.NIL.toString();
    }

    public TRBasicPattern(TCIgnorePattern owner)
    {
        super(owner);
        this.token = IsaToken.PLACEHOLDER;
        this.pattern = IsaToken.PLACEHOLDER.toString();
    }

    @Override
    public String translate() {
        return pattern;
    }

    @Override
    public IsaToken isaToken() {
        return token;
    }

	@Override
	public <R, S> R apply(TRPatternVisitor<R, S> visitor, S arg)
	{
		return visitor.caseBasicPattern(this, arg);
	}
}
