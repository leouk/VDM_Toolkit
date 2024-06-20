package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.types.TCRecordType;
import com.fujitsu.vdmj.tc.types.TCType;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;

public class DafnyUnionDefinition extends AbstractDafnyNode {
    private TCType vdm;
    private final String translation;
    private boolean warningFlag;

    public DafnyUnionDefinition(TCType type) {
        this.vdm = type;
        if (type instanceof TCRecordType) {
            warningFlag = false;
            TCRecordType recType = ((TCRecordType)type);
            List<Pair<String, String>> fields = recType.fields.stream().map(field -> Pair.of(field.tag, field.type.toString())).collect(Collectors.toList());
            translation = "mk_" + DafnyIdentifiers.instance().transform(recType.name) + "(" + fields.stream().map(pair -> pair.getKey() + ": " + pair.getValue()).collect(Collectors.joining(", ")) + ")";
        }
        else {
            translation = "";
        }
    }

    public String getWarning() {
        if (warningFlag)
            return DafnyTemplates.MESSAGES.render("error", Pair.of("type", "error"), Pair.of("message", String.format("Unsupported type %s", vdm.getClass().getSimpleName())));
        return "";
    }

    @Override
    public String translate() {
        return translation;
    }
    
}
