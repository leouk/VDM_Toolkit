package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCAssignmentDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCEqualsDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCLocalDefinition;
import com.fujitsu.vdmj.tc.definitions.TCStateDefinition;
import com.fujitsu.vdmj.tc.definitions.TCValueDefinition;
import com.fujitsu.vdmj.tc.types.TCUnknownType;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;
import uk.ac.ncl.vdm2dafny.tr.dafny.DafnyVDMComment;
import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;

public abstract class DafnyDefinition extends AbstractDafnyNode {
    // Ignore annotations in this
    public abstract TCDefinition getVDM();
    public abstract boolean isLocal();

    
    public static boolean isSyntheticDefinition(TCDefinition d) {
        return d instanceof TCLocalDefinition && ((TCLocalDefinition)d).type instanceof TCUnknownType;
    }

    public static DafnyDefinition of(TCDefinition def, FlatEnvironment env) {
        if (def != null) DafnyEnvironment.instance().globalEnv().add(def);
        return 
                def instanceof TCExplicitFunctionDefinition ? new DafnyFunctionDefinition(def)
            :   def instanceof TCImplicitFunctionDefinition ? new DafnyFunctionDefinition(def)
            :   def instanceof TCLocalDefinition ? new DafnyLocalDefinition(def)
            :   def instanceof TCValueDefinition ? new DafnyValueDefinition((TCValueDefinition)def)
            :   def instanceof TCAssignmentDefinition ? new DafnyAssignmentDefinition((TCAssignmentDefinition)def, env)
            :   def instanceof TCEqualsDefinition ? new DafnyEqualsDefinition((TCEqualsDefinition)def, env)
            :   def instanceof TCStateDefinition ? new DafnyStateDefinition((TCStateDefinition)def)
            :   null;
    } 

    public static List<DafnyDefinition> from(TCDefinitionList list, FlatEnvironment env) {
        List<DafnyDefinition> result = new ArrayList<>();

        for (TCDefinition def: list) {
            result.add(of(def, env));
        }
        return result;
    }

    public List<DafnyVDMComment> getComments() {
        return getVDM().comments.stream().map(comment -> new DafnyVDMComment(comment)).collect(Collectors.toList());
    }

    public abstract String getName();
}