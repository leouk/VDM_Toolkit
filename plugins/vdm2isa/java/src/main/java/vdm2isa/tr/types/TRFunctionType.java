/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import vdm2isa.lex.IsaToken;

import com.fujitsu.vdmj.lex.LexLocation;

public class TRFunctionType extends TRType
{
	private static final long serialVersionUID = 1L;
	private final TRTypeList parameters;
	private final boolean partial;
	private final TRType result;
	
	public TRFunctionType(LexLocation location, TRTypeList parameters, boolean partial, TRType result)
	{
		super(location);
		this.parameters = parameters;
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

	@Override
	public String invTranslate(String varName) {
		return ("Not yet");
	}
}
