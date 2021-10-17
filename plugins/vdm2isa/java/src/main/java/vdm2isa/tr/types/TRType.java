/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;

import com.fujitsu.vdmj.lex.LexLocation;

abstract public class TRType extends TRNode
{
	private static final long serialVersionUID = 1L;

	protected final LexLocation location;

	public TRType(LexLocation location)
	{
		this.location = location;
	}

	public abstract String translate();

	public abstract IsaToken isaToken();
}
