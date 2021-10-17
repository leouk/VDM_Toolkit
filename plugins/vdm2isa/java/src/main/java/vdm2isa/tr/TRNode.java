/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr;

import com.fujitsu.vdmj.mapper.MappedObject;

abstract public class TRNode extends MappedObject
{
	private static final long serialVersionUID = 1L;
	public final static String MAPPINGS = "tc-tr.mappings";

	protected TRNode()
	{
		super();
	}
}
