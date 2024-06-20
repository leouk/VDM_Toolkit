package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCRecordPattern;
import com.fujitsu.vdmj.tc.types.TCType;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeNames;

public class DafnyRecordPattern implements DafnyPattern {
    private TCRecordPattern pattern;
    private Optional<TCType> parentType;

    public DafnyRecordPattern(TCRecordPattern pattern) {
        this(pattern, Optional.of(pattern.type));
    }

    public DafnyRecordPattern(TCRecordPattern pattern, TCType type) {
        this(pattern, Optional.ofNullable(type));
    }
    
    public DafnyRecordPattern(TCRecordPattern pattern, Optional<TCType> type) {
        this.pattern = pattern;
        this.parentType = type;
    }

    @Override
    public TCPattern getVDM() {
        return pattern;
    }

    @Override
    public String translate() {
       return DafnyTemplates.PATTERNS.render("record", Pair.of("pattern", this));
    }

    public boolean hasParentType() {
        return parentType.isPresent();
    }

    public String getName() {
        return DafnyIdentifiers.instance().transform(pattern.typename);
    }

    public String getTypeName() {
        assert hasParentType();
        return DafnyTypeNames.instance().getTypeName(parentType.get());
    }
    
    public List<String> getInternalPatterns() {
        return DafnyPattern.from(pattern.plist).stream()
            .map(p -> p.translate())
            .collect(Collectors.toList());
    }

    public final static boolean is(TCPattern p) {
        return p instanceof TCRecordPattern;
    } 

    public final static DafnyPattern of(TCPattern p) {
        assert is(p);
        return new DafnyRecordPattern((TCRecordPattern)p);
    }

    public String getVariables() {
        // TODO want to get names and types in a: T, b: T here
        return pattern.getVariableNames().stream().map(v -> DafnyIdentifiers.instance().transform(v)).collect(Collectors.joining(", "));
    }

    @Override
    public boolean invalidAssignmentPattern() {
        return pattern.plist.stream().anyMatch(p -> DafnyPattern.of(p).invalidAssignmentPattern());
    }

    @Override
    public boolean invalidCase() {
        return pattern.plist.stream().anyMatch(p -> DafnyPattern.of(p).invalidCase());
    } 

}
