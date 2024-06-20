package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.types.TCNamedType;
import com.fujitsu.vdmj.tc.types.TCQuoteType;
import com.fujitsu.vdmj.tc.types.TCRecordType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCUnionType;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;

public class DafnyUnion extends DafnyAbstractType {
    private class UnionType {
        private final String name;
        private final boolean quote;
        
        public UnionType(String name, boolean quote) {
            this.name = name;
            this.quote = quote;
        }

        public boolean isQuote() {
            return quote;
        }

        public String getName() {
            return name;
        }
    }

    private TCNamedType ntype;
    private TCUnionType utype;
    private List<TCType> unions;

    private DafnyDefinition inv;
    private DafnyDefinition ord;
    private DafnyDefinition eq;

    public static final DafnyUnion of(TCNamedType union) {
        assert union.type instanceof TCUnionType;
        final TCUnionType utype = (TCUnionType)union.type;

        DafnyDefinition inv = union.invdef != null ? new DafnyInvariantDefinition(
            union.invdef, 
            String.format("Impl%s'", DafnyIdentifiers.instance().transform(union.typename)), 
            DafnyEnvironment.instance().globalEnv()) 
            :   null;    
        DafnyDefinition ord = DafnyDefinition.of(union.orddef != null ? union.orddef : null, DafnyEnvironment.instance().globalEnv());    
        DafnyDefinition eq = DafnyDefinition.of(union.eqdef != null ? union.eqdef : null, DafnyEnvironment.instance().globalEnv());    
        List<TCType> types = new ArrayList<>(utype.types);
            // TODO change constructor stuffies.
        return new DafnyUnion(union, inv, ord, eq, types);
    
    }

    public DafnyUnion(TCNamedType type, DafnyDefinition inv, DafnyDefinition ord, DafnyDefinition eq, List<TCType> unionTypes) {
        super(type, DafnyTypeNames.instance().getTypeName(type), inv, ord, eq);
        assert type.type instanceof TCUnionType;
        this.ntype = type;
        this.utype = type.type.getUnion();
        this.unions = unionTypes;

        this.inv = inv;
        this.ord = ord;
        this.eq = eq;
        findPossibleProblems();
    }


    public List<UnionType> getUnionTypes() {
        return unions.stream()
            .map(t -> new UnionType(DafnyTypeNames.instance().getTypeName(t), t instanceof TCQuoteType))
            .collect(Collectors.toList());
    }

    @Override
    protected void findPossibleProblems() {
        super.findPossibleProblems();
        if (unions.stream().anyMatch(u -> u instanceof TCRecordType)) {
            DafnyTranslateCommand.report(DafnyErrorMessage.PLUGIN_NYI_2P, ntype.location, "field access expressions", "union types of records");
        }
        if (unions.stream().anyMatch(u -> DafnyTypeDefinition.isLiteral(u))) {
            DafnyTranslateCommand.report(DafnyErrorMessage.PLUGIN_NYI_2P, ntype.location, "literal unions", "union types");
        }
        if (unions.stream().anyMatch(u -> DafnyTypeDefinition.isCollection(u))) {
            DafnyTranslateCommand.report(DafnyErrorMessage.PLUGIN_NYI_2P, ntype.location, "collection unions", "union types");
        }
    }

    @Override
    public String translate() {
        return DafnyTemplates.TYPES.render("union", Pair.of("type", this));
    }
    
    @Override
    public DafnyDefinition getInv() {
        return inv;
    }

    @Override
    public DafnyDefinition getOrd() {
        return ord;
    }

    @Override
    public DafnyDefinition getEq() {
        return eq;
    }
}
