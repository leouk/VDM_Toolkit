package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCQuotePattern;
import com.fujitsu.vdmj.tc.types.TCNamedType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCUnionType;

import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyPattern;

public class DafnyTypeObject extends AbstractDafnyNode {
    private TCType vdm;

    public DafnyTypeObject(TCType type) {
        vdm = type;
    }

    @Override
    public String translate() {
        return DafnyTypeNames.instance().getTypeName(vdm);
    }

    public boolean isUnion() {
        return vdm != null && vdm.isUnion(vdm.location);
    }

    public String getExpression(DafnyExpression args) {
        return "";
    }

    public String getPattern(DafnyPattern pattern) {
        String prefix = getPatternConstructor(pattern.getVDM());

        if (prefix != "") {
            return String.format("%1$s(%2$s)", prefix, pattern.translate());
        }
        return pattern.translate();
    }

    public String getPatternConstructor(TCPattern pattern) {
        if (!(isUnion() && pattern.matches(vdm))) 
            return "";

        if (pattern instanceof TCQuotePattern) {
            return "";
        }

        if (vdm instanceof TCNamedType) {
            TCNamedType namedType = (TCNamedType)vdm;
            namedType.toDetailedString();

            if (namedType.type instanceof TCUnionType) {
                TCUnionType unionType = (TCUnionType)namedType.type;
                for (TCType t: unionType.types) {
                    if (pattern.matches(t)) {
                        return DafnyTypeNames.instance().getTypeName(t);
                    }
                }
            }
        }

        return "";
    }
}
