package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.types.TCField;
import com.fujitsu.vdmj.tc.types.TCRecordType;
import com.fujitsu.vdmj.tc.types.TCType;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;
public class DafnyRecord extends DafnyAbstractType {
    // private List<TRField> fields;
    private List<Pair<String, String>> fields;
    private DafnyDefinition inv; 
    private DafnyDefinition ord; 
    private DafnyDefinition eq;

    public static final DafnyRecord of(TCRecordType fields) {
        String name = DafnyIdentifiers.instance().transform(fields.name);
        DafnyDefinition inv = fields.invdef != null ? new DafnyInvariantDefinition(
            fields.invdef, 
            String.format("Impl%s'", DafnyIdentifiers.instance().transform(fields.name.getName())), 
            DafnyEnvironment.instance().globalEnv()) 
            :   null;    
        DafnyDefinition ord = DafnyDefinition.of(fields.orddef != null ? fields.orddef : null, DafnyEnvironment.instance().globalEnv());    
        DafnyDefinition eq = DafnyDefinition.of(fields.eqdef != null ? fields.eqdef : null, DafnyEnvironment.instance().globalEnv());    
        
        // Check if any fields have equality abstraction
        if (fields.fields.stream().anyMatch(field -> field.equalityAbstraction)) {
            final TCField equalityAbstracted = fields.fields.stream().filter(field -> field.equalityAbstraction).findFirst().get();
            DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_EQUALITY_ABSTRACTION_2P, fields.location, fields.name.getName(), equalityAbstracted.tag);
        }

        List<Pair<String, String>> constructor = 
            // TODO change constructor stuffies.
            fields.fields.stream().map(field -> Pair.of(DafnyIdentifiers.instance().transform(field.tag), DafnyTypeNames.instance().getTypeName(field.type))).collect(Collectors.toList());
        return new DafnyRecord(fields, name, inv, ord, eq, constructor);
    
    }

    public DafnyRecord(TCRecordType vdm, String name, DafnyDefinition inv, DafnyDefinition ord, DafnyDefinition eq, List<Pair<String, String>> fields) {
        super(vdm, name, inv, ord, eq);
        this.fields     = fields;
        this.inv = inv;
        this.ord = ord;
        this.eq = eq;
        findPossibleProblems();
    }
    public String getConsName() {
        return "Cons";
    }

    public List<Pair<String, String>> getCons() {
        return fields;
    }

    @Override
    public String translate() {
        return DafnyTemplates.TYPES.render("record", Pair.of("type", this));
    }

    public static final String unionReturn(TCType type) {
        return DafnyTypeNames.instance().getTypeName(type);
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
