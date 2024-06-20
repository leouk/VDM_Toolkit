package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import com.fujitsu.vdmj.tc.types.TCNamedType;
import com.fujitsu.vdmj.tc.types.TCRecordType;
import com.fujitsu.vdmj.tc.types.TCType;

public class DafnyComposition extends DafnyAbstractType {
    private DafnyTypeDefinition alias;
    private DafnyTypeDefinition compose;
    
    public DafnyComposition(TCType type, String name, DafnyTypeDefinition alias, DafnyTypeDefinition compose) {
        super(type, name, alias.getInv(), alias.getOrd(), alias.getEq());
        this.alias = alias;
        this.compose = compose;
        findPossibleProblems();
    }

    public static DafnyComposition of(TCNamedType compositeType) {
        assert  compositeType.type instanceof TCRecordType
            && ((TCRecordType)compositeType.type).composed;

        DafnyTypeDefinition alias = DafnyAlias.of(compositeType);
        DafnyTypeDefinition compose = DafnyRecord.of(((TCRecordType)compositeType.type));

        return new DafnyComposition(compositeType, alias.getName(), alias, compose);
    }
    
    
    @Override
    public String translate() {
        return alias.translate() + "\n\n" + compose.translate();
    }

    @Override
    public DafnyDefinition getInv() {
        return alias.getInv();
    }

    @Override
    public DafnyDefinition getOrd() {
        return alias.getOrd();
    }

    @Override
    public DafnyDefinition getEq() {
        return alias.getEq();
    }
}
