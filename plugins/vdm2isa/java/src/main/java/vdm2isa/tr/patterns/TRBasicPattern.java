package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.List;

import com.fujitsu.vdmj.lex.LexLocation;
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

    private static final List<IsaToken> VALID_TOKENS = 
        Arrays.asList(IsaToken.IDENTIFIER, IsaToken.BOOL, IsaToken.CHAR,
                      IsaToken.NAT, IsaToken.NAT1, IsaToken.INT, 
                      IsaToken.REAL, IsaToken.STRING, IsaToken.QUOTE,
                      IsaToken.NIL, IsaToken.PLACEHOLDER);

    /**
     * Constructor useful for synthetically constructed types 
     * @param location
     * @param token
     */
    public TRBasicPattern(LexLocation location, IsaToken token, String pattern)
    {
        super(location);
        this.token = token;
        this.pattern = pattern;
        if (!VALID_TOKENS.contains(this.token))
            report(11111, "Invalid basic pattern token " + token.toString());
    }
    
    public TRBasicPattern(TCIdentifierPattern owner)
    {
        this(owner.location, IsaToken.IDENTIFIER, owner.toString());
    }

    public TRBasicPattern(TCBooleanPattern owner)
    {
        this(owner.location, IsaToken.BOOL, owner.toString());
    }

    public TRBasicPattern(TCCharacterPattern owner)
    {
        this(owner.location, IsaToken.CHAR, 
            IsaToken.ISACHAR + " " + 
                IsaToken.bracketit(IsaToken.ISASTR, 
                    Character.isISOControl(owner.value.unicode) ?
                    Integer.toString(owner.value.unicode) : 
                    Character.toString(owner.value.unicode),//owner.toString(),
                    IsaToken.ISASTR
                )
            );
    }

    public TRBasicPattern(TCIntegerPattern owner)
    {
        this(owner.location, (owner.value.value >= 0 ? (owner.value.value > 0 ? IsaToken.NAT1 : IsaToken.NAT) : IsaToken.INT), owner.toString());
    }

    public TRBasicPattern(TCRealPattern owner)
    {
        this(owner.location, IsaToken.REAL, owner.toString());
    }

    public TRBasicPattern(TCStringPattern owner)
    {
        // you don't want the "X" just the X 
        this(owner.location, IsaToken.STRING, 
            IsaToken.bracketit(IsaToken.ISASTR, owner.value.value,//owner.toString(),
               IsaToken.ISASTR)
            );
    }   

    public TRBasicPattern(TCQuotePattern owner)
    {
        // you don't want the <X> just the X 
        this(owner.location, IsaToken.QUOTE, owner.value.value);//owner.toString());
    }

    public TRBasicPattern(TCNilPattern owner)
    {
        this(owner.location, IsaToken.NIL, IsaToken.NIL.toString());
    }

    public TRBasicPattern(TCIgnorePattern owner)
    {
        this(owner.location, IsaToken.PLACEHOLDER, IsaToken.PLACEHOLDER.toString());
    }

    @Override
    public String translate() {
        return pattern;
    }

    @Override
    public String invTranslate() {
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
