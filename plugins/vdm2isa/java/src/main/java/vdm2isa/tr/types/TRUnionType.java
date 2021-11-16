package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCUnionType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRUnionType extends TRType {
    private static final long serialVersionUID = 1L;
   
    private TRTypeSet types; 
    private boolean expanded = false;
    
    public TRUnionType(TCUnionType vdmType, TRDefinitionList definitions, TRTypeSet types)
	{
		super(vdmType, definitions);
		this.types = types;
        //TODO not sure whether this is needed, given the TRTypeSet passed will already have been 
        //      expanded within its TCUnionType owner? This also highlights that I will indeed need
        //      the TRDefinitionList wihtin all types, which caused trouble earlier!!!! 
		//expand();
	}

    private void expand()
	{
		if (expanded) return;
		TRTypeSet exptypes = new TRTypeSet();

		for (TRType t: types)
		{
    		if (t instanceof TRUnionType)
    		{
    			TRUnionType ut = (TRUnionType)t;
  				ut.expand();
   				exptypes.addAll(ut.types);
    		}
    		else
    		{
    			exptypes.add(t);
    		}
		}

		types = exptypes;
		expanded = true;
		definitions = new TRDefinitionList();

		for (TRType t: types)
		{
			if (t.definitions != null)
			{
				definitions.addAll(t.definitions);
			}
		}
	}

    @Override
    public String invTranslate(String varName) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg) {
        return visitor.caseUnionType(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String translate() {
        // TODO Auto-generated method stub
        return null;
    }
}
