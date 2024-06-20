package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import com.fujitsu.vdmj.tc.types.TCField;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;

public class DafnyField extends AbstractDafnyNode{
    private TCField field;

    public DafnyField(TCField field, FlatEnvironment env) {
        this.field = field;
    }

    @Override
    public String translate() {
        return DafnyIdentifiers.instance().transform(field.tagname) + ": " + DafnyTypeNames.instance().getTypeName(field.type);
    }
}
