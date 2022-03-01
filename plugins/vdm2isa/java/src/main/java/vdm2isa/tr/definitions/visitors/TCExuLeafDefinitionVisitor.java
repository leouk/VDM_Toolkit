package vdm2isa.tr.definitions.visitors;

import java.util.Collection;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.visitors.TCLeafDefinitionVisitor;

public class TCExuLeafDefinitionVisitor<E, C extends Collection<E>, S> extends TCLeafDefinitionVisitor<E, C, S> {

    @Override
    protected C newCollection() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public C caseDefinition(TCDefinition node, S arg) {
        // TODO Auto-generated method stub
        return null;
    }
    
}
