package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.HashSet;
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

import plugins.GeneralisaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
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
    private TRBasicPattern(TCPattern p, IsaToken token, String pattern)
    {
        super(p, p != null ? p.location : LexLocation.ANY);
        this.token = token;
        this.pattern = pattern;
    }
    
    public TRBasicPattern(TCIdentifierPattern owner)
    {
        this(owner, IsaToken.IDENTIFIER, String.valueOf(owner));
    }

    public TRBasicPattern(TCBooleanPattern owner)
    {
        this(owner, IsaToken.BOOL, String.valueOf(owner));
    }

    public TRBasicPattern(TCCharacterPattern owner)
    {
        this(owner, IsaToken.CHAR, 
            IsaToken.ISACHAR + " " + 
                IsaToken.bracketit(IsaToken.ISASTR, 
                    owner != null ? owner.value != null ?
                        Character.isISOControl(owner.value.unicode) ?
                            Integer.toString(owner.value.unicode) : 
                            Character.toString(owner.value.unicode)
                        : "null" : "null",
                    IsaToken.ISASTR
                )
            );
    }

    public TRBasicPattern(TCIntegerPattern owner)
    {
        this(owner, owner != null ? owner.value != null ? 
            (owner.value.value >= 0 ? (owner.value.value > 0 ? IsaToken.NAT1 : IsaToken.NAT) : IsaToken.INT) : IsaToken.INT : IsaToken.INT, String.valueOf(owner));
    }

    public TRBasicPattern(TCRealPattern owner)
    {
        this(owner, owner != null ? owner.value != null ? Token.RAT.equals(owner.value.type) ? IsaToken.RAT : IsaToken.REAL : IsaToken.REAL : IsaToken.REAL, String.valueOf(owner));
    }

    public TRBasicPattern(TCStringPattern owner)
    {
        // you don't want the "X" just the X 
        this(owner, IsaToken.STRING, 
            IsaToken.bracketit(IsaToken.ISASTR, owner != null ? owner.value != null ? owner.value.value : "null" : "null",
               IsaToken.ISASTR)
            );
    }   

    public TRBasicPattern(TCQuotePattern owner)
    {
        // you don't want the <X> just the X 
        this(owner, IsaToken.VDMQUOTE, owner != null ? owner.value != null ? owner.value.value : "null" : "null");
    }

    public TRBasicPattern(TCNilPattern owner)
    {
        this(owner, IsaToken.NIL, IsaToken.NIL.toString());
    }

    public TRBasicPattern(TCIgnorePattern owner)
    {
        this(owner, IsaToken.PLACEHOLDER, IsaToken.dummyVarNames(1, false, owner.location) + "_ignore");//IsaToken.PLACEHOLDER.toString());
    }

    @Override
    public void setup()
    {
        super.setup();
        if (!VALID_TOKENS.contains(this.token))
            report(IsaErrorMessage.ISA_TOKEN_ERROR_1P, token.toString());
        checkValidIsaIdentifier();
    }

    @Override
    public String patternTranslate()
    {
        return String.valueOf(pattern);
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

    public static final TRPattern identifier(LexLocation location, String name) {
        if (!IsaToken.validIsaIdentifier(name))
            GeneralisaPlugin.report(IsaErrorMessage.ISA_INVALID_IDENTIFIER_1P, location, name);
        TRBasicPattern result = new TRBasicPattern(new TCIdentifierPattern(IsaToken.newNameToken(location, location.module, name)));
        TRNode.setup(result);
        return result;
    }

    public static final TRPattern ignore(LexLocation location) {
        TRBasicPattern result = new TRBasicPattern(new TCIgnorePattern(location));
        TRNode.setup(result);
        return result;
    }

    public static final TRPattern dummyPattern(LexLocation location, boolean requiresFreshness) {
        return TRBasicPattern.identifier(location, IsaToken.dummyVarNames(1, requiresFreshness, location));
    }

    public static final TRPattern underscore(LexLocation location) {
        return TRBasicPattern.identifier(location, IsaToken.UNDERSCORE.toString());
    }
}
