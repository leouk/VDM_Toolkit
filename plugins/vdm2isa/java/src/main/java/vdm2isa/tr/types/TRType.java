/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import java.util.Set;
import java.util.TreeSet;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCBooleanType;
import com.fujitsu.vdmj.tc.types.TCTokenType;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

abstract public class TRType extends TRNode implements Comparable<TRType>
{
	private static final long serialVersionUID = 1L;

	private final TCType vdmType;
	protected TRDefinitionList definitions; 

	private TCNameToken inferredNameForType;

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
		super(vdmType != null ? vdmType.location : LexLocation.ANY);
		this.vdmType = vdmType;
		this.definitions = definitions == null ? new TRDefinitionList() : definitions;
		this.atTLD = false; //setAtTopLevelDefinition(false);
		this.inferredNameForType = null;
	}

	@Override
	public void setup()
	{
		super.setup();
		setSemanticSeparator(IsaToken.SPACE.toString());
		setFormattingSeparator(IsaToken.SPACE.toString());
		// setuping these calculated fields, will entail duplicated setup (i.e. many of the type-level duplications are also in the module list)
		// that's okay, given we need to use the definitions sometimes, hence the double calculation 
		TRNode.setup(definitions);
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

	protected void setInferredNamedForType(TCNameToken tn)
	{
		inferredNameForType = tn;
	}

	protected String getInferredNamedForType()
	{
		return inferredNameForType != null ? inferredNameForType.toString() : null;
	}

	public boolean setAtTopLevelDefinition(boolean b, boolean deep)
    {
		boolean result = atTLD;
        atTLD = b;
		return result;
    }

	public boolean setAtTopLevelDefinition(boolean b)
    {
		return setAtTopLevelDefinition(b, true);
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
		String result = inferredNameForType == null ? "" : inferredNameForType.toString();
		if (result.isEmpty())
		{
			report(IsaErrorMessage.ISA_TYPE_HAS_NO_NAME_1P, isaToken().toString());
		}
		return result;
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
	public /*final*/ String invTranslate()
	{
		return invTranslate(null);
	}

	@Override
	public abstract String translate();

	protected abstract String getInvTypeString();

	/**
	 * Every type definition will have invariant checks. We declare a "lemmas" statement collecting the set of all
	 * defining invariants involved in a type, so that they can all be expanded at once, or individually. 
	 * For example, "T = nat inv t == t > 10" will define an "inv_T" which depends on "inv_VDMNat"; so this will return
	 * "inv_T_def, inv_VDMNat_def", which can then become the set in a "lemmas inv_T_defs" statement translated 
	 * by TRTypeDefinition. 
	 * @return
	 */
	public Set<String> getDefLemmas()
	{
		TreeSet<String> result = new TreeSet<String>();
		//TODO use this as a mechanism to "fixing" the messy parenthesise calls (i.e. too many around)
		// String invStr = invTranslate();	
		// invStr.replace("(", "");
		// invStr.replace(")", "");
		// // no repeated invs within
		// assert invStr.indexOf(IsaToken.INV.toString()) == invStr.lastIndexOf(IsaToken.INV.toString());
		// result.add(invStr.trim());
		result.add(getInvTypeString());
		return result;
	}

	public String translateDefLemmas()
	{
		StringBuilder sb = new StringBuilder();
		for(String s : getDefLemmas())
		{
			sb.append(s);
			// add "_def" to all strings without it. 
			if (!s.endsWith(IsaToken.ISAR_DEF.toString()) && 
				!s.endsWith(IsaToken.ISAR_LEMMAS_DEFS.toString()))
			{
				sb.append(IsaToken.ISAR_DEF.toString());
			}
			sb.append(IsaToken.SPACE.toString());
		}
		return sb.toString();
	}

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

	// Force the check on TRBasicType as well (i.e. not "||" but "&&"), given we don't allow REAL/RAT!
	public boolean isPossibleSetRange()
	{
		TRType utype = ultimateType();
		return utype.getVDMType().isNumeric(location) &&
				(utype instanceof TRBasicType) &&
 				 utype.isPossibleSetRange();
 	}

	public boolean isUnion()
	{
		return getVDMType().isUnion(location);
	}

	public boolean isDataType()
	{
		return isUnion() ||
			   //false //ultimateType().isDataType()
			   ultimateType() instanceof TRDataType
			   ;
	}

	public boolean isBooleanType()
	{
		TRType utype = ultimateType();
		return getVDMType() instanceof TCBooleanType ||
				((utype instanceof TRBasicType) &&
				 utype.isBooleanType()); 
	}

	public boolean isVDMToken()
	{
		TRType utype = ultimateType();
		return getVDMType() instanceof TCTokenType ||
				((utype instanceof TRBasicType) &&
				 utype.isVDMToken());
	}

	public boolean isProductType()
	{
		TRType utype = ultimateType();
		return getVDMType().isProduct(location) || ((utype instanceof TRProductType) && utype.isProductType());
	}

	public TRProductType getProduct()
	{
		TRProductType result = null;
		if (isProductType())
		{
			TRType utype = ultimateType();
			if (utype instanceof TRProductType)
			{
				result = (TRProductType)utype;
			}
		}	
		assert result != null;
		return result;
	}

	public TRType ultimateType()
	{
		return this;
	}

	public boolean hasSpecification()
	{
		return false;
	}

	public boolean hasOrderingSpecification()
	{
		return false;
	}

	public TRInvariantType ultimateInvariantType()
	{
		TRInvariantType result = null;
		if (this instanceof TRInvariantType)
		{
			TRInvariantType itype = (TRInvariantType)this;
			if (itype.hasSpecification())
			{
				result = itype;
			}
		}
		return result;
	}

	public abstract <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg);

    public boolean compatible(TRType type) {
        return TRTypeComparator.compatible(type, this);
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
