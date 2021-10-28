/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

import com.fujitsu.vdmj.lex.LexLocation;

public class TRFunctionType extends TRType
{
	private static final long serialVersionUID = 1L;
	public final TRTypeList parameters;
	public final boolean partial;
	public final TRType result;
	
	public TRFunctionType(LexLocation location, TRTypeList parameters, boolean partial, TRType result)
	{
		super(location);
		this.parameters = parameters;
		// presume that all function types will be curried
		this.parameters.setCurried(true);
		this.partial = partial;
		this.result = result;
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
		return result.invTranslate(rVarName) +
			   IsaToken.comment("function type invariant depends on its lambda definition and same dummy names being used!");
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseFunctionType(this, arg);
	}
}
