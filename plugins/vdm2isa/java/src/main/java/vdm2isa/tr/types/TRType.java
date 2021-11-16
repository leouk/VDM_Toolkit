/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.typechecker.TypeComparator;

import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

abstract public class TRType extends TRNode
{
	private static final long serialVersionUID = 1L;

	private final TCType vdmType;
	protected TRDefinitionList definitions; 

	protected TRType(TCType vdmType)
	{
	 	this(vdmType, new TRDefinitionList());
	}

	public TRType(TCType vdmType, TRDefinitionList definitions)
	{
		super(vdmType.location);
		this.vdmType = vdmType;
		this.definitions = definitions == null ? new TRDefinitionList() : definitions;
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

	public TRDefinitionList getDefinitions()
	{
		return definitions;
	}

	@Override
	public String toString()
	{
		return super.toString() + " defs = " + (definitions != null ? definitions.size() : "0"); 
		//TODO this loops given the outer definition list is contained here. Still to figure out how definitions will be useful 
		//String.valueOf(definitions);//(definitions != null ? definitions.toString() : "null");
	}

	public String getName()
	{
		report(IsaErrorMessage.ISA_TYPE_HAS_NO_NAME_1P, isaToken().toString());
		return "";
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

	public boolean isOrdered()
	{
		return false;
	}

	public TRType ultimateType()
	{
		return this;
	}

	public abstract <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg);

    public boolean compatible(TRType type) {
        return TypeComparator.compatible(type.getVDMType(), getVDMType());

    }

	public TCType getVDMType() {
		return vdmType;
	}

	public boolean isNumericType() {
        return false;
    }
}
