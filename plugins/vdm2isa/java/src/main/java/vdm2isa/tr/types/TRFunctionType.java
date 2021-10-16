/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;

public class TRFunctionType extends TRType
{
	private static final long serialVersionUID = 1L;
	private final TRTypeList parameters;
	private final TRType result;
	
	public TRFunctionType(TRTypeList parameters, TRType result)
	{
		this.parameters = parameters;
		this.result = result;
	}

	@Override
	public String translate()
	{
		return getParameters().translate() + " " + IsaToken.FUN.toString() + " " + result.translate();
	}
	
	public TRTypeList getParameters()
	{
		return parameters;
	}
	
	public TRType getResult()
	{
		return result;
	}
}
