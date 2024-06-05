package vdm2isa.tr.types.visitors;

import vdm2isa.tr.types.TRParameterType;
import vdm2isa.tr.types.TRParameterTypeSet;
import vdm2isa.tr.types.TRType;

public class TRParametricTypeFinder extends TRLeafTypeVisitor<TRType, TRParameterTypeSet, Object> 
{

    @Override
    protected TRParameterTypeSet newCollection() {
        return new TRParameterTypeSet();
    }

    @Override
    public TRParameterTypeSet caseType(TRType node, Object arg) {
        return newCollection();
    }

	@Override
	public TRParameterTypeSet caseParameterType(TRParameterType node, Object arg)
	{
		TRParameterTypeSet all = newCollection();
		all.add(node);
		return all;
	}    
}
