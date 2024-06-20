package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.patterns.TCMapPattern;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCSeqPattern;
import com.fujitsu.vdmj.tc.patterns.TCSetPattern;
import com.fujitsu.vdmj.tc.patterns.TCTuplePattern;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;

public class DafnyCollectionPattern implements DafnyPattern {
    private enum Type {
        MAP("[", "]"), 
        TUPLE("(", ")"), 
        SEQ("[", "]"),
        SET("{", "}");
        protected String left;
        protected String right;
        private Type(String left, String right) {
            this.left = left; this.right = right;
        }
    }

    private TCPattern pattern;
    private List<DafnyPattern> patternList;
    private Type type;

    public DafnyCollectionPattern(TCSetPattern pattern) {
        this.pattern = pattern;
        this.patternList = pattern.plist.stream().map(p -> DafnyPattern.of(p)).collect(Collectors.toList());
        this.type = Type.SET;
    }

    public DafnyCollectionPattern(TCSeqPattern pattern) {
        this.pattern = pattern;
        this.patternList = pattern.plist.stream().map(p -> DafnyPattern.of(p)).collect(Collectors.toList());
        this.type = Type.SEQ;
    }

    public DafnyCollectionPattern(TCMapPattern pattern) {
        this.pattern = pattern;
        this.patternList = pattern.maplets.stream().map(p -> DafnyPattern.of(p)).collect(Collectors.toList());
        this.type = Type.MAP;
    }
    
    public DafnyCollectionPattern(TCTuplePattern pattern) {
        this.pattern = pattern;
        this.patternList = pattern.plist.stream().map(p -> DafnyPattern.of(p)).collect(Collectors.toList());
        this.type = Type.TUPLE;
    }

    @Override
    public TCPattern getVDM() {
        return pattern;
    }


    @Override
    public String translate() {
       return DafnyTemplates.PATTERNS.render("collection", Pair.of("pattern", this));
    }
    
    public List<String> getInternalPatterns() {
        return patternList.stream().map(p -> p.translate()).collect(Collectors.toList());
    }

    public String getL() {
        return type.left;
    }
    
    public String getR() {
        return type.right;
    }

    public final static boolean is(TCPattern p) {
        return  p instanceof TCMapPattern
            ||  p instanceof TCSeqPattern
            ||  p instanceof TCSetPattern
            ||  p instanceof TCTuplePattern;
    } 

    public final static DafnyPattern of(TCPattern p) {
        assert is(p);
        return  p instanceof TCMapPattern ? new DafnyCollectionPattern((TCMapPattern)p)
            :   p instanceof TCSeqPattern ? new DafnyCollectionPattern((TCSeqPattern)p)
            :   p instanceof TCSetPattern ? new DafnyCollectionPattern((TCSetPattern)p)
            :   p instanceof TCTuplePattern ? new DafnyCollectionPattern((TCTuplePattern)p)
            :   null;
    }

    public String getVariables() {
        // TODO want to get names and types in a: T, b: T here
        return pattern.getVariableNames().stream().map(v -> DafnyIdentifiers.instance().transform(v)).collect(Collectors.joining(", "));
    }

    @Override
    public boolean invalidAssignmentPattern() {
        return patternList.stream().anyMatch(p -> p.invalidAssignmentPattern());
    }

    @Override
    public boolean invalidCase() {
        return true; // cannot have sequence enumerations as case in Dfy.
    } 

}
