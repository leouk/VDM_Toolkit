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

	/**
	 * Invariant check string for given type. Different types have different invariant checking considerations
	 * @param varName if non-null, the user-defined variable name to check invariant against (e.g. T = nat1 inv t == exp; varName = t).
	 * 				  if null, it tells the delegated method that it's for a structured type (e.g. T = set of set of nat1; varName for inner set = null).
	 * @return the invariant check expression 
	 */
	public abstract String invTranslate(String varName);
}
