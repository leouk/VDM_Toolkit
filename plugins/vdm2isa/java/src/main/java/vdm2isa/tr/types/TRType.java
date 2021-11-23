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

abstract public class TRType extends TRNode implements Comparable<TRType>
{
	private static final long serialVersionUID = 1L;

	private final TCType vdmType;
	protected TRDefinitionList definitions; 

    /**
     * Named types are treated differently, depending on whether they are part of a top-level definition,
     * or part of a chain of renamings (i.e. the inv_T will be different depending on that). 
     */
    private boolean atTLD;

	protected TRType(TCType vdmType)
	{
	 	this(vdmType, new TRDefinitionList());
	}

	public TRType(TCType vdmType, TRDefinitionList definitions)
	{
		super(vdmType.location);
		this.vdmType = vdmType;
		this.definitions = definitions == null ? new TRDefinitionList() : definitions;
		setAtTopLevelDefinition(false);
	}

	@Override
	protected void setup()
	{
		super.setup();
		setSemanticSeparator(" ");
		setFormattingSeparator(" ");
	}

	/**
	 * Deep copy constructor for TRType tree. This is particularly important when considering renamed/structured types, 
	 * where one wants to get the right kind of invTranslate result, depending on whether it's for top-level definition
	 * or "local" (i.e. perhaps TLD is bad name). 
	 * 
	 * For example "T = RHS", "inv_T t == inv_RHS t"; namely the invariant definition for T calls the "inv_RHS t", but
	 * wherever else T appears (e.g. set of T, R = T, etc.), we don't want to have "R = set of T" as inv_R = inv_VDMSet' inv_RHS t,
	 * but inv_VDMSet' inv_T t). Thus, every type within teh inner/structured type tree is "top-level" by default (i.e. has already)
	 * got previously defined inv_T for it, whereas "local" defined types don't. 
	 * 
	 * The way the deep-copy goes, is that any inner TRType alaways call copy(true), whereas the top of the copy tree might get a
	 * TLD false/true, hene modulating whether the inner part is to what kind of target type. This is crucial for carrying over 
	 * the overall type structure when propagating invariants at TRTypeDefinition type, which is where this is mostly used.
	 * 
	 * The deep-copying also percolates through to type lists and sets, as well as leaf types, in which case on their atTLD flag
	 * is changed, given there is no "inner.copy(true)" to call. See the various "TestV2ITypes*.vdmsl" for various examples.      
	 * @param atTLD
	 * @return
	 */
	public abstract TRType copy(boolean atTLD);

	public void setAtTopLevelDefinition(boolean b)
    {
        atTLD = b;
    }

    public boolean atTopLevelDefinition()
    {
        return atTLD;
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

	@Override
	public abstract String translate();

	public boolean isNumericType() {
		TRType utype = ultimateType();
        return getVDMType().isNumeric(location)
			   || 
			   ((utype instanceof TRBasicType) &&
			   	utype.isNumericType()) ;
    }

	public boolean isOrdered()
	{
		TRType utype = ultimateType();
		return getVDMType().isOrdered(location) ||
				((utype instanceof TRBasicType) &&
				utype.isNumericType()) ;
}

	public boolean isDataType()
	{
		return getVDMType().isUnion(location) ||
			   //false //ultimateType().isDataType()
			   ultimateType() instanceof TRDataType
			   ;
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

	/**
	 * Checks whether this type contains any union type. This is important at TLDs given union
	 * types *must* be declared as a separate datatype (i.e. TLD union types must be a TRNamedType). 
	 * 
	 * Union types are, however, allowed at local-level definitions of course.     
	 */
	public abstract void checkForUnionTypes();

	/**
	 * Implement equality and comparison according to VDMJ's type rules. No faffing around. 
	 */
	@Override
	public final boolean equals(Object other)
	{
		boolean result = false;
		if (other instanceof TRType)
		{
			TRType o = ((TRType)other);
			result = this.getVDMType().equals(o.getVDMType());
		}
		return result;
	}

	@Override
	public final int compareTo(TRType o)
	{
		return this.getVDMType().compareTo(o.getVDMType());
	}

	@Override
	public final int hashCode()
	{
		return this.getVDMType().hashCode();
	}
}
