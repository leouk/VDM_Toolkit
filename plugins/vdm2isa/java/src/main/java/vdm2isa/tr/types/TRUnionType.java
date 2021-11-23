package vdm2isa.tr.types;

import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.tc.types.TCUnionType;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRUnionType extends TRType implements TRDataType {
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
		this.types.setSemanticSeparator(getSemanticSeparator());
		this.types.setFormattingSeparator(getFormattingSeparator());
		this.types.setInvTranslateSeparator(getInvTranslateSeparator());
	}

	@Override 
	public String toString()
	{
		return "Union " + 
			"\n\t tset = " + String.valueOf(types) + 
			"\n\t loc  = " + String.valueOf(getLocation());
	}

	@Override
	protected void setup()
	{
		super.setup();
		setFormattingSeparator(" ");
		setSemanticSeparator(" " + isaToken() + " ");
		setInvTranslateSeparator(" " + IsaToken.AND.toString() + " ");
	}

	@Override
    public TRType copy(boolean atTLD)
    {
        TRType result = new TRUnionType((TCUnionType)getVDMType(), definitions, types.copy(true));
        result.setAtTopLevelDefinition(atTLD);
        return result;
    }

	public TRTypeSet getDataTypeConstructors()
	{
		return types;
	}

    // private void expand()
	// {
	// 	if (expanded) return;
	// 	TRTypeSet exptypes = new TRTypeSet();

	// 	for (TRType t: types)
	// 	{
    // 		if (t instanceof TRUnionType)
    // 		{
    // 			TRUnionType ut = (TRUnionType)t;
  	// 			ut.expand();
   	// 			exptypes.addAll(ut.types);
    // 		}
    // 		else
    // 		{
    // 			exptypes.add(t);
    // 		}
	// 	}

	// 	types = exptypes;
	// 	expanded = true;
	// 	definitions = new TRDefinitionList();

	// 	for (TRType t: types)
	// 	{
	// 		if (t.definitions != null)
	// 		{
	// 			definitions.addAll(t.definitions);
	// 		}
	// 	}
	// }

    @Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
		if (varName != null)
		{
			List<String> varNames = new Vector<String>(types.size());
			// for(int i = 0; i < types.size(); i ++)
			// {
			// 	varNames.add(varName + String.valueOf(i));
			// }
			//TODO not sure whether the above is needed; for quotes it isn't
			varNames.add(varName);
			sb.append(types.invTranslate(varNames));
		}
		else
			sb.append(types.invTranslate());
		return sb.toString();		
    }

	public boolean isDataType()
	{
		return true;
	}

    @Override
    public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg) {
        return visitor.caseUnionType(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.BAR; 
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
		sb.append(types.translate());
		return sb.toString();
    }

	@Override
	public void checkForUnionTypes() {
        report(IsaErrorMessage.ISA_INVALID_UNIONTYPE_1P, "union type", "size = " + types.size());   
	}
}
