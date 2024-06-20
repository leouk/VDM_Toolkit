package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import java.util.ArrayList;
import java.util.List;

import com.fujitsu.vdmj.tc.patterns.TCConcatenationPattern;
import com.fujitsu.vdmj.tc.patterns.TCExpressionPattern;
import com.fujitsu.vdmj.tc.patterns.TCMapUnionPattern;
import com.fujitsu.vdmj.tc.patterns.TCMapletPattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;
import com.fujitsu.vdmj.tc.patterns.TCUnionPattern;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;

public interface DafnyPattern {
    public TCPattern getVDM();

    public String translate();

    public static DafnyPattern of(TCPattern p) {
        if (DafnyLiteralPattern.is(p)) {
            return DafnyLiteralPattern.of(p);
        }
        else if (DafnyRecordPattern.is(p)) {
            return DafnyRecordPattern.of(p);
        }
        else if (DafnyCollectionPattern.is(p)) {
            return DafnyCollectionPattern.of(p);
        }
        else if (p instanceof TCConcatenationPattern) {
            DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, p.location, "pattern", "Concatenation pattern");
            return new DafnyConcatenationPattern((TCConcatenationPattern)p);
        }
        else if (p instanceof TCMapUnionPattern) {
            DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, p.location, "pattern", "Map union pattern");
            return new DafnyMapUnionPattern((TCMapUnionPattern)p);
        }
        else if (p instanceof TCUnionPattern) {
            DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, p.location, "pattern", "Union pattern");
            return new DafnyUnionPattern((TCUnionPattern)p);
        }
        else if (p instanceof TCMapletPattern) {
            // DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, p.location, "pattern", "Union pattern");
            return new DafnyMapletPattern((TCMapletPattern)p);
        }
        else if (p instanceof TCExpressionPattern) {
            return new DafnyExpressionPattern((TCExpressionPattern)p);
        }
        else {
            DafnyTranslateCommand.report(DafnyErrorMessage.PLUGIN_NYI_2P, p.location, p.getClass().getSimpleName(), "patterns");
            return null;
        }
    }
    
    public static List<DafnyPattern> from(TCPatternList ps) {
        List<DafnyPattern> result = new ArrayList<>();
        for (TCPattern p: ps) {
            result.add(of(p));
        }
        return result;
    }

    /**
     * Check if the pattern is valid for cases.
     * @return
     */
    public abstract boolean invalidCase();

    public abstract boolean invalidAssignmentPattern();

    default boolean checkValidAssignment() {
        if (invalidAssignmentPattern()) {
            DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, getVDM().location, "pattern", getVDM().toString());
        }
        return invalidAssignmentPattern();

    }

    default String getVariables() {
        return "";
    }
}
