/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

public class TRVariableExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TCNameToken name;
	
	public TRVariableExpression(TCNameToken name)
	{
		this.name = name;
	}

	@Override
	public String translate()
	{
		//name.getPreName(name.getLocation());
		//@todo name location info as well? 
		return name.getName().toString();
	}
}
