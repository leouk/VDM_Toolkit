package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import java.util.Set;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.lex.Token;
import com.fujitsu.vdmj.tc.patterns.TCBooleanPattern;
import com.fujitsu.vdmj.tc.patterns.TCCharacterPattern;
import com.fujitsu.vdmj.tc.patterns.TCConcatenationPattern;
import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;
import com.fujitsu.vdmj.tc.patterns.TCIgnorePattern;
import com.fujitsu.vdmj.tc.patterns.TCIntegerPattern;
import com.fujitsu.vdmj.tc.patterns.TCNilPattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCQuotePattern;
import com.fujitsu.vdmj.tc.patterns.TCRealPattern;
import com.fujitsu.vdmj.tc.patterns.TCRecordPattern;
import com.fujitsu.vdmj.tc.patterns.TCStringPattern;

import uk.ac.ncl.vdm2dafny.lex.DafnyToken;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;

public class DafnyLiteralPattern implements DafnyPattern {
    public TCPattern pattern;
    public DafnyToken tok;
    public String translation;

    private static Set<Class<? extends TCPattern>> PATTERNS = Set.of(
        // TCRecordPattern.class, 
        TCIdentifierPattern.class, 
        TCBooleanPattern.class, 
        TCCharacterPattern.class, 
        TCIntegerPattern.class, 
        TCRealPattern.class, 
        TCStringPattern.class, 
        TCQuotePattern.class, 
        TCIgnorePattern.class, 
        TCNilPattern.class
    );

    public static boolean is(TCPattern pattern) {
        return PATTERNS.stream().anyMatch(patternClass -> patternClass.isInstance(pattern));
    }

    public static DafnyLiteralPattern of(TCPattern pattern) {
        assert is(pattern);
        return 
            pattern instanceof TCRecordPattern      ? new DafnyLiteralPattern((TCRecordPattern)pattern)
        :   pattern instanceof TCIdentifierPattern  ? new DafnyLiteralPattern((TCIdentifierPattern)pattern)
        :   pattern instanceof TCBooleanPattern     ? new DafnyLiteralPattern((TCBooleanPattern)pattern)
        :   pattern instanceof TCCharacterPattern   ? new DafnyLiteralPattern((TCCharacterPattern)pattern)
        :   pattern instanceof TCIntegerPattern     ? new DafnyLiteralPattern((TCIntegerPattern)pattern)
        :   pattern instanceof TCIgnorePattern      ? new DafnyLiteralPattern((TCIgnorePattern)pattern)
        :   pattern instanceof TCRealPattern        ? new DafnyLiteralPattern((TCRealPattern)pattern)
        :   pattern instanceof TCStringPattern      ? new DafnyLiteralPattern((TCStringPattern)pattern)
        :   pattern instanceof TCQuotePattern       ? new DafnyLiteralPattern((TCQuotePattern)pattern)
        :   pattern instanceof TCNilPattern         ? new DafnyLiteralPattern((TCNilPattern)pattern)
        :   new DafnyLiteralPattern((TCIgnorePattern)pattern);
    }

    private DafnyLiteralPattern(TCPattern pattern, DafnyToken tok) {
        assert is(pattern);
        this.pattern = pattern;
        this.tok = tok;
    }

    public DafnyLiteralPattern(TCRecordPattern pattern) {
        this(pattern, DafnyToken.RECORD);
        // Translation strategy?
    }

    public DafnyLiteralPattern(TCConcatenationPattern pattern) {
        this(pattern, DafnyToken.RECORD);
        // Translation strategy?
    }
    
    public DafnyLiteralPattern(TCIdentifierPattern owner)
    {
        this(owner, DafnyToken.IDENTIFIER);
        this.translation = tok.render(DafnyIdentifiers.instance().transform(owner.name));
    }

    public DafnyLiteralPattern(TCBooleanPattern owner)
    {
        this(owner, DafnyToken.BOOL);
        this.translation = tok.render(owner.value.value ? "true": "false");
    }

    public DafnyLiteralPattern(TCCharacterPattern owner)
    {
        this(owner, DafnyToken.CHAR);
        this.translation = tok.render(String.valueOf(owner.value.unicode));
    }

    public DafnyLiteralPattern(TCIntegerPattern owner)
    {
        this(owner, owner != null ? owner.value != null ? 
            (owner.value.value >= 0 ? (owner.value.value > 0 ? DafnyToken.NAT1 : DafnyToken.NAT) : DafnyToken.INT) : DafnyToken.INT : DafnyToken.INT);
        this.translation = tok.render(String.valueOf(owner.value.value));
    }
        
    public DafnyLiteralPattern(TCRealPattern owner)
    {
        this(owner, owner != null ? owner.value != null ? Token.RAT.equals(owner.value.type) ? DafnyToken.RAT : DafnyToken.REAL : DafnyToken.REAL : DafnyToken.REAL);
        this.translation = tok.render(String.valueOf(owner.value.value));
    }

    public DafnyLiteralPattern(TCStringPattern owner)
    {
        // you don't want the "X" just the X 
        this(owner, DafnyToken.STRING);
        this.translation = tok.render(owner.value.value);
    }   

    public DafnyLiteralPattern(TCQuotePattern owner)
    {
        // you don't want the <X> just the X 
        this(owner, DafnyToken.VDMQUOTE);
        this.translation = tok.render(String.valueOf(owner.value.value));
    }

    public DafnyLiteralPattern(TCNilPattern owner)
    {
        this(owner, DafnyToken.NIL);
        this.translation = tok.render();
    }

    public DafnyLiteralPattern(TCIgnorePattern owner)
    {
        this(owner, DafnyToken.PLACEHOLDER);//DafnyToken.PLACEHOLDER.toString());
        this.translation = tok.render();
    }


    @Override
    public String translate() {
        return translation;
    }

    public TCPattern getVDM() {
        return pattern;
    }
    
    @Override
    public boolean invalidCase() {
        return false;
    }

    public String getVariables() {
        return pattern.getVariableNames().stream().map(v -> v.getName()).collect(Collectors.joining(", "));
    }

    @Override
    public boolean invalidAssignmentPattern() {
        return !tok.equals(DafnyToken.IDENTIFIER);
    }
}
 