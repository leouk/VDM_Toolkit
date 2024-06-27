package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;


import com.fujitsu.vdmj.tc.types.TCNamedType;
import com.fujitsu.vdmj.tc.types.TCType;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;

public class DafnyAlias extends DafnyAbstractType {
    private String alias;
    private DafnyInvariantDefinition dfyInv;
    private DafnyFunctionDefinition dfyOrd;
    private DafnyFunctionDefinition dfyEq;


    public static final DafnyAlias of(TCNamedType type) {
        // Incorrect assertion as aliasing a union type raises this....
        // assert !type.isUnion(type.location); 
        String name = DafnyIdentifiers.instance().transform(type.typename);
        DafnyInvariantDefinition inv = type.invdef != null ? new DafnyInvariantDefinition(
            type.invdef, 
            DafnyTypeNames.instance().getTypeName(type.type),
            DafnyEnvironment.instance().globalEnv()) 
                :   null;
        DafnyFunctionDefinition ord = type.orddef != null ? new DafnyFunctionDefinition(type.orddef) : null;
        DafnyFunctionDefinition eq  = type.eqdef != null  ? new DafnyFunctionDefinition(type.eqdef) : null;
        return new DafnyAlias(type, name, inv, ord, eq, type.type);
    }

    public DafnyAlias(TCNamedType vdm, String name, DafnyInvariantDefinition inv, DafnyFunctionDefinition ord, DafnyFunctionDefinition eq, TCType alias) {
        super(vdm, name, inv, ord, eq);
        this.dfyInv  = inv;
        this.dfyOrd  = ord;
        this.dfyEq   = eq;
        this.alias   = DafnyTypeNames.instance().getTypeName(alias);
        findPossibleProblems();
    }

    @Override
    public String translate() {
        return DafnyTemplates.TYPES.render("alias", Pair.of("type", this));
    }
    
    public String getAlias() {
        return alias;
    }

    @Override
    public String getImplName() {
        return getName();
    }

    @Override
    public DafnyDefinition getInv() {
        return dfyInv;
    }

    @Override
    public DafnyDefinition getOrd() {
        return dfyOrd;
    }

    @Override
    public DafnyDefinition getEq() {
        return dfyEq;
    }
}
