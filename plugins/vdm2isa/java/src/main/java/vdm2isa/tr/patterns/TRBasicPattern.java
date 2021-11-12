package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.lex.Token;
import com.fujitsu.vdmj.tc.patterns.TCBooleanPattern;
import com.fujitsu.vdmj.tc.patterns.TCCharacterPattern;
import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;
import com.fujitsu.vdmj.tc.patterns.TCIgnorePattern;
import com.fujitsu.vdmj.tc.patterns.TCIntegerPattern;
import com.fujitsu.vdmj.tc.patterns.TCNilPattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCQuotePattern;
import com.fujitsu.vdmj.tc.patterns.TCRealPattern;
import com.fujitsu.vdmj.tc.patterns.TCStringPattern;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;

public class TRBasicPattern extends TRPattern {
    
    private static final long serialVersionUID = 1L;

    private final String pattern;
    private IsaToken token;

    public static final Set<IsaToken> VALID_TOKENS = new HashSet<IsaToken>(
        Arrays.asList(IsaToken.IDENTIFIER, IsaToken.BOOL, IsaToken.CHAR,
                      IsaToken.NAT, IsaToken.NAT1, IsaToken.INT, IsaToken.RAT,
                      IsaToken.REAL, IsaToken.STRING, IsaToken.VDMQUOTE,
                      IsaToken.NIL, IsaToken.PLACEHOLDER));

    /**
     * Constructor useful for synthetically constructed types 
     * @param location
     * @param token
     */
    public TRBasicPattern(TCPattern owner, IsaToken token, String pattern)
    {
        super(owner);
        this.token = token;
        this.pattern = pattern;
        if (!VALID_TOKENS.contains(this.token))
            report(IsaErrorMessage.ISA_TOKEN_ERROR_1P, token.toString());
        checkValidIsaIdentifier();
    }
    
    public TRBasicPattern(TCIdentifierPattern owner)
    {
        this(owner, IsaToken.IDENTIFIER, owner.toString());
    }

    public TRBasicPattern(TCBooleanPattern owner)
    {
        this(owner, IsaToken.BOOL, owner.toString());
    }

    public TRBasicPattern(TCCharacterPattern owner)
    {
        this(owner, IsaToken.CHAR, 
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
        this(owner, (owner.value.value >= 0 ? (owner.value.value > 0 ? IsaToken.NAT1 : IsaToken.NAT) : IsaToken.INT), owner.toString());
    }

    public TRBasicPattern(TCRealPattern owner)
    {
        this(owner, owner.value.type.equals(Token.RAT) ? IsaToken.RAT : IsaToken.REAL, owner.toString());
    }

    public TRBasicPattern(TCStringPattern owner)
    {
        // you don't want the "X" just the X 
        this(owner, IsaToken.STRING, 
            IsaToken.bracketit(IsaToken.ISASTR, owner.value.value,//owner.toString(),
               IsaToken.ISASTR)
            );
    }   

    public TRBasicPattern(TCQuotePattern owner)
    {
        // you don't want the <X> just the X 
        this(owner, IsaToken.VDMQUOTE, owner.value.value);//owner.toString());
    }

    public TRBasicPattern(TCNilPattern owner)
    {
        this(owner, IsaToken.NIL, IsaToken.NIL.toString());
    }

    public TRBasicPattern(TCIgnorePattern owner)
    {
        this(owner, IsaToken.PLACEHOLDER, IsaToken.PLACEHOLDER.toString());
    }

    @Override
    public String getPattern()
    {
        return typeAware(String.valueOf(pattern));
    }

    @Override
    public String translate()
    {
        return getPattern();
    }

    @Override
    public String invTranslate() {
        return translate();
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
