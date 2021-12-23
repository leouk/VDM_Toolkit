package vdm2isa.tr.types.visitors;

import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeSet;

public class TRParametricTypeFinder extends TRLeafTypeVisitor<TRType, TRTypeSet, Object> 
{

    @Override
    protected TRTypeSet newCollection() {
        return new TRTypeSet();
    }

    @Override
    public TRTypeSet caseType(TRType node, Object arg) {
        return newCollection();
    }

    
}
