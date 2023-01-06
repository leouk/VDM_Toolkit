package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.definitions.TCStateDefinition;
import com.fujitsu.vdmj.tc.types.TCFunctionType;
import com.fujitsu.vdmj.tc.types.TCOperationType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCUnresolvedType;

import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRStateDefinition;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TROperationType extends TRFunctionType {

    private static final long serialVersionUID = 1L;
	// public TRTypeList parameters;
	public final boolean pure;

	public TROperationType(TCOperationType vdmType, TRDefinitionList definitions, TRTypeList parameters, TRType result, boolean pure)
	{
		super(vdmType, definitions, parameters, false, result, false);
		// this.parameters = parameters;
		this.pure = pure;
	}

	private void StateAddedParameters()
	{
		TRType paramType = TRStateDefinition.state.recordType.copy(atTopLevelDefinition());
		parameters.add(paramType);
	}

    @Override
	public void setup()
	{
		StateAddedParameters();
		if(getInnerType() instanceof TRVoidType)
		{
			TRType paramType = TRStateDefinition.state.recordType.copy(false);
			setResult(paramType);
		} 
		super.setup();
		setFormattingSeparator("\n\t");
		parameters.setCurried(true);
	}

    @Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseOperationType(this, arg);
	}

	@Override
	public TRType getResultType()
	{
		return getInnerType();//result;//getInnerType();
	}

	public TCOperationType getVDMOperationType()
	{
		return (TCOperationType)getVDMType();
	}

	@Override
	public TCFunctionType getVDMFunctionPreType()
	{
		TCFunctionType pre = getVDMOperationType().getPreType((TCStateDefinition)TRStateDefinition.state.getVDMDefinition(), null, false);

		pre.parameters.add(new TCUnresolvedType(TRStateDefinition.state.name));
		return pre;
	}

	@Override
	public TCFunctionType getVDMFunctionPostType()
	{
		TCFunctionType post = getVDMOperationType().getPostType((TCStateDefinition)TRStateDefinition.state.getVDMDefinition(), null, false);

		// replace void type with state

		//post.parameters.add(new TCUnresolvedType(TRStateDefinition.state.getName()));
		return post;
	}

	@Override
	public TCFunctionType getVDMFunctionCurriedPreType(boolean isCurried)
	{
		return getVDMFunctionPreType();
	}

	@Override
	public TCFunctionType getVDMFunctionCurriedPostType(boolean isCurried)
	{
		return getVDMFunctionPostType();
	}

    @Override
	public TCFunctionType getVDMFunctionMeasureType(boolean isCurried, TCType actual)
	{
		return null;
	}

}
