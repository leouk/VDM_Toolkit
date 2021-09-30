/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.tr.TRNode;

public abstract class TRExpression extends TRNode
{
	private static final long serialVersionUID = 1L;
	
	abstract public String translate();
}
