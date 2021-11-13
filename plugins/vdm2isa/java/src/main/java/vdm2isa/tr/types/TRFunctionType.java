/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

import com.fujitsu.vdmj.lex.LexLocation;

public class TRFunctionType extends TRType
{
	private static final long serialVersionUID = 1L;
	public final TRTypeList parameters;
	public final boolean partial;
	public final TRType result;
	
	public TRFunctionType(LexLocation location, TRDefinitionList definitions, TRTypeList parameters, boolean partial, TRType result)
	{
		//NB tried to get definitions through this one, and got NPEs all over during mappings conversion!
		super(location, definitions);
		this.parameters = parameters;
		// presume that all function types will be curried
		this.parameters.setCurried(true);
		this.partial = partial;
		this.result = result;
		setFormattingSeparator("\n\t");
	}

	@Override
	public String translate()
	{
		return parameters.translate() + " " + isaToken().toString() + " " + result.translate();
	}
	
	@Override
	public IsaToken isaToken() {
		return partial ? IsaToken.FUN : IsaToken.TFUN;
	}

	public String dummyVarNames(String varName)
	{
		assert varName != null;
		return IsaToken.parenthesise(varName + " " + IsaToken.dummyVarNames(parameters.size(), location));
	}

	@Override
	public String invTranslate(String varName) {
		// function type invariants are implicit? e.g. v = (lambda x: nat, y: nat & x + y)
		// we can't really check inv_VDMNat1 of x or y; that's the LambdaExpression's job
		// we must, however, check the type invariant of the result!
		// that also means, the declaring party must take that into account in the inv_XXX def!
		// e.g. inv_v x y == "inv_VDMNat (v x y)"
		String rVarName = varName != null ? dummyVarNames(varName) : varName;
		StringBuilder sb = new StringBuilder();
		sb.append(getFormattingSeparator());
		sb.append(IsaToken.comment("function type invariant depends on its lambda definition dummy names used being equal."));
		sb.append(getFormattingSeparator());
		sb.append(result.invTranslate(rVarName)); 
		return sb.toString();
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseFunctionType(this, arg);
	}

	public TRFunctionType getPreType()
	{
		//NB technically, this can be partial (i.e. run-time error failing pre)?
		return new TRFunctionType(location, definitions, parameters, false, TRBasicType.boolType(location));
	}

	public TRFunctionType getCurriedPreType(boolean isCurried)
	{
		if (isCurried && result instanceof TRFunctionType)
		{
			TRFunctionType ft = (TRFunctionType)result;
			return new TRFunctionType(location, definitions, parameters, false, ft.getCurriedPreType(isCurried));
		}
		else
		{
			return getPreType();
		}
	}

	public TRFunctionType getPostType()
	{
		TRTypeList inSig = parameters.copy();
		inSig.add(result);
		//NB following the choice from TCFunctionType, but perhaps this should be partial=true!
		return new TRFunctionType(location, definitions, inSig, false, TRBasicType.boolType(location));
	}

	public TRFunctionType getCurriedPostType(boolean isCurried)
	{
		if (isCurried && result instanceof TRFunctionType)
		{
			TRFunctionType ft = (TRFunctionType)result;
			return new TRFunctionType(location, definitions, parameters, false, ft.getCurriedPostType(isCurried));
		}
		else
		{
			return getPostType();
		}
	}

	public TRFunctionType getInvariantType() {
		return new TRFunctionType(location, definitions, parameters, partial, TRBasicType.boolType(location));
	}

    public TRFunctionType getComparisonType() {
		TRTypeList params = parameters.copy();
		params.addAll(parameters.copy());
        return new TRFunctionType(location, definitions, params, partial, TRBasicType.boolType(location));
    }

    public TRFunctionType getMeasureType() {
        return new TRFunctionType(location, definitions, parameters, partial, TRBasicType.natType(location));
    }

    public TRFunctionType getUnknownType() {
        return new TRFunctionType(location, definitions, parameters, partial, TRExpression.unknownType(location));
    }
}
