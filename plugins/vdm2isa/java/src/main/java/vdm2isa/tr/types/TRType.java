/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

abstract public class TRType extends TRNode
{
	private static final long serialVersionUID = 1L;

	public TRDefinitionList definitions; 

	public TRType(LexLocation location)
	{
		super(location);
		definitions = null;
	}

	@Override
	protected void setup()
	{
		super.setup();
		setSemanticSeparator(" ");
		setFormattingSeparator(" ");
	}

	/**
	 * Reinventing this here from TCType to cater for TRUnionType needs. All derived classes must reimplement this
	 * to take into account how their compose types work 
	 * @return
	 */
	//TODO all type extend on this! 
	public TRTypeList getComposeTypes()
	{
		return new TRTypeList();
	}


	@Override
	public String toString()
	{
		return super.toString() + " defs = " + String.valueOf(definitions);//(definitions != null ? definitions.toString() : "null");
	}

	/**
	 * Invariant check string for given type. Different types have different invariant checking considerations
	 * @param varName if non-null, the user-defined variable name to check invariant against (e.g. T = nat1 inv t == exp; varName = t).
	 * 				  if null, it tells the delegated method that it's for a structured type (e.g. T = set of set of nat1; varName for inner set = null).
	 * @return the invariant check expression 
	 */
	public abstract String invTranslate(String varName);

	/**
	 * Types do not have context information about the invariant name, so implement as unknown/don't-care name
	 * for general TRNode invTranslate method
	 */
	@Override
	public String invTranslate()
	{
		return invTranslate(null);
	}

	public abstract <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg);
}
