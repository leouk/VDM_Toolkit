/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

import com.fujitsu.vdmj.tc.types.TCBooleanType;
import com.fujitsu.vdmj.tc.types.TCFunctionType;

public class TRFunctionType extends TRAbstractInnerTypedType
{
	private static final long serialVersionUID = 1L;
	public final TRTypeList parameters;
	public final boolean partial;
	/**
	 * This field is never used, but is necessary for the ClassMapper to work 
	 * (i.e. ClassMapper requires the same field name, even though we percolate it through the AbstractInnerType hierarchy)
	 */
	private final TRType result;
	
	public TRFunctionType(TCFunctionType vdmType, TRDefinitionList definitions, TRTypeList parameters, boolean partial, TRType result)
	{
		// definitions are nonempty when the type defines an explicit function definition! 
		super(vdmType, definitions, result);
		this.parameters = parameters;
		this.result = result;// never used! Needs to be here because of class mapping naming conventions!
		this.result.definitions = definitions; 
		this.partial = partial;
	}

	@Override
	public void setup()
	{
		super.setup();
		setFormattingSeparator("\n\t");
		this.getInnerType().definitions = definitions;
		// presume that all function types will be curried
		TRNode.setup(parameters, result); 
		parameters.setCurried(true);
		//System.out.println(toString());
	}

	@Override 
	public String toString()
	{
		return "TRFunctionType " + 
			"\n\t\t params = " + String.valueOf(parameters) +
			"\n\t\t result = " + String.valueOf(getResultType()) +
			"\n\t\t defs   = " + String.valueOf(definitions.size()) +// loops?
			"\n\t\t loc    = " + String.valueOf(getLocation());
	}

    @Override
    public void setAtTopLevelDefinition(boolean b)
    {
        super.setAtTopLevelDefinition(b);
		//this.parameters.setAtTopLevelDefinition(b);
    }	

	@Override
	public TRType copy(boolean atTLD)
	{
		TRType result = this;
        if (getInnerType() == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "function type", "null result type?");
        }
		else if (parameters == null)
		{
			// this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "function type", "null parameter types?");
		}
		else
        {
			//TODO should the call be parameters.copy(true)?
			result = new TRFunctionType(getVDMFunctionType(), definitions, parameters.copy(atTLD), partial, getInnerType().copy(true));
			TRNode.setup(result);
			result.setAtTopLevelDefinition(atTLD);
		}
		return result;
	}

	public TCFunctionType getVDMFunctionType()
	{
		return (TCFunctionType)getVDMType();
	}

	@Override
	public String translate()
	{
		return parameters.translate() + " " + isaToken().toString() + " " + getResultType().translate();
	}
	
	@Override
	public IsaToken isaToken() {
		return partial ? IsaToken.FUN : IsaToken.TFUN;
	}

	public TRType getInnerType()
	{
		return result;
	}

	public TRType getResultType()
	{
		return result;//getInnerType();//result;//getInnerType();
	}

	public String dummyVarNames(String varName)
	{
		assert varName != null;
		return IsaToken.parenthesise(varName + " " + IsaToken.dummyVarNames(parameters.size(), location));
	}

	protected String paramInvTranslate(int index)
	{
		assert index >= 0 && index < parameters.size();
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.INV.toString());
        // transform "lambda" => "Lambda" for inv_Lambda call
        int i = sb.length();
        sb.append(IsaToken.LAMBDA.vdmToken().toString());
        sb.setCharAt(i, Character.toUpperCase(sb.charAt(i)));
        sb.append(IsaToken.SPACE.toString());
		sb.append(parameters.get(index).invTranslate(null));
		return sb.toString();
	}

	@Override
	public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
		sb.append(paramInvTranslate(0));
		for(int i = 1; i < parameters.size(); i++)
		{
			sb.append(IsaToken.SPACE.toString());
			sb.append(IsaToken.LPAREN.toString());
			sb.append(paramInvTranslate(i));
		}
		sb.append(IsaToken.SPACE.toString());
		sb.append(getResultType().invTranslate(null));
		if (parameters.size() > 1)
		{
			sb.append(IsaTemplates.replicate(IsaToken.RPAREN.toString(), parameters.size()-1));
		}
		sb.append(varName != null ? varName : "");
		return IsaToken.parenthesise(sb.toString());
		// // function type invariants are implicit? e.g. v = (lambda x: nat, y: nat & x + y)
		// // we can't really check inv_VDMNat1 of x or y; that's the LambdaExpression's job
		// // we must, however, check the type invariant of the result!
		// // that also means, the declaring party must take that into account in the inv_XXX def!
		// // e.g. inv_v x y == "inv_VDMNat (v x y)"
		// String rVarName = varName != null ? dummyVarNames(varName) : varName;
		// StringBuilder sb = new StringBuilder();
		// sb.append(getFormattingSeparator());

		// //sb.append(IsaToken.comment(IsaInfoMessage.VDM_LAMBDA_INVARIANT.toString()));		
		// sb.append(getFormattingSeparator());
		// sb.append(IsaToken.parenthesise(
		// 	IsaToken.INV.toString() + IsaToken.LAMBDA.toString() + IsaToken.SPACE.toString() +
		// 	getInnerType().invTranslate(null) + IsaToken.SPACE.toString() + getResultType().invTranslate(null) +
		// 	(rVarName == null ? "" : IsaToken.SPACE.toString() + rVarName))
		// );
		// return sb.toString();
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseFunctionType(this, arg);
	}

	@Override
	public void checkForUnionTypes() {
		parameters.checkForUnionTypes();//"function parameters");
		super.checkForUnionTypes();
		//result.checkForUnionTypes(); // equivalent to super.checkUnionTypes(); 
	}

	public TRFunctionType getPreType()
	{
		//NB technically, this can be partial (i.e. run-time error failing pre)?
		return TRFunctionType.newFunctionType(getVDMFunctionType(), definitions, parameters, partial, getInnerType());
	}

	public TRFunctionType getCurriedPreType(boolean isCurried)
	{
		if (isCurried && getResultType() instanceof TRFunctionType)
		{
			TRFunctionType ft = (TRFunctionType)getResultType();
			return TRFunctionType.newFunctionType(getVDMFunctionType(), definitions, parameters, false, ft.getCurriedPreType(isCurried));
		}
		else
		{
			return getPreType();
		}
	}

	public TRFunctionType getPostType()
	{
		TRTypeList inSig = parameters.copy(atTopLevelDefinition());
		inSig.add(getResultType());
		return TRFunctionType.newFunctionType(getVDMFunctionType(), definitions, inSig, false, TRBasicType.boolType(location));
	}

	public TRFunctionType getCurriedPostType(boolean isCurried)
	{
		if (isCurried && getResultType() instanceof TRFunctionType)
		{
			TRFunctionType ft = (TRFunctionType)getResultType();
			return TRFunctionType.newFunctionType(getVDMFunctionType(), definitions, parameters, false, ft.getCurriedPostType(isCurried));
		}
		else
		{
			return getPostType();
		}
	}

	public TRFunctionType getInvariantType() {
		return TRFunctionType.newFunctionType(getVDMFunctionType(), definitions, parameters, partial, TRBasicType.boolType(location));
	}

    public TRFunctionType getComparisonType() {
		TRTypeList params = parameters.copy(atTopLevelDefinition());
		params.addAll(parameters.copy(atTopLevelDefinition()));
		return TRFunctionType.newFunctionType(getVDMFunctionType(), definitions, params, partial, TRBasicType.boolType(location));
    }

    public TRFunctionType getMeasureType() {
		return TRFunctionType.newFunctionType(getVDMFunctionType(), definitions, parameters, partial, TRBasicType.natType(location));
    }

    public TRFunctionType getUnknownType() {
		return TRFunctionType.newFunctionType(getVDMFunctionType(), definitions, parameters, partial, TRExpression.unknownType(location));
    }

	public static final TRFunctionType getInvariantType(TRType paramType)
	{
		return TRFunctionType.newFunctionType(TRBasicType.boolType(paramType.getLocation()), TRTypeList.newTypeList(paramType), false);
	}

	/**
	 * Given a TRMapType (e.g. map X to Y = X \<righrupharpoon> Y), get an Isabelle optional typed function result (e.g. X => Y option) 
	 * @param mapType
	 * @return
	 */
	public static final TRFunctionType getIsabelleMapType(TRMapType mapType)
	{
		return TRFunctionType.newFunctionType(TROptionalType.newOptionalType(mapType.getToType()), mapType.getFromType());
	}

	public static final TRFunctionType newConstantFunctionType(TRType result) {
        return TRFunctionType.newFunctionType(result, new TRTypeList(), true); 
    }

    public static final TRFunctionType newFunctionType(TRType result, TRType... params) {
        return TRFunctionType.newFunctionType(result, TRTypeList.newTypeList(params), true); 
    }

    public static final TRFunctionType newFunctionType(TRType fcnResultType, TRTypeList params, boolean partial) {
		return TRFunctionType.newFunctionType(new TCFunctionType(fcnResultType.getLocation(), params.getVDMTypeList(), partial, fcnResultType.getVDMType()), 
			new TRDefinitionList(), params, partial, fcnResultType);
    }

	public static  final TRFunctionType newFunctionType(TCFunctionType vdmType, TRDefinitionList definitions, TRTypeList parameters, boolean partial, TRType fcnResultType)
	{
		TRFunctionType result = new TRFunctionType(vdmType, definitions, parameters, partial, fcnResultType);
		TRNode.setup(result);
		return result;
	}
}
