/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import vdm2isa.tr.TRNode;

abstract public class TRType extends TRNode
{
	private static final long serialVersionUID = 1L;

	public abstract String translate();
}
