/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCBooleanType;
import com.fujitsu.vdmj.tc.types.TCCharacterType;
import com.fujitsu.vdmj.tc.types.TCIntegerType;
import com.fujitsu.vdmj.tc.types.TCNaturalOneType;
import com.fujitsu.vdmj.tc.types.TCNaturalType;
import com.fujitsu.vdmj.tc.types.TCRationalType;
import com.fujitsu.vdmj.tc.types.TCRealType;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRBasicType extends TRType
{
	private static final long serialVersionUID = 1L;
	private final IsaToken token;

	public static final Set<IsaToken> VALID_TOKENS = new HashSet<IsaToken>(
		Arrays.asList(IsaToken.NAT, IsaToken.NAT1, IsaToken.INT, 
					  IsaToken.RAT, IsaToken.REAL, IsaToken.BOOL, 
					  IsaToken.CHAR, IsaToken.TOKEN_TYPE)); 

	public static final Set<IsaToken> ORDERED_TYPES = new HashSet<IsaToken>(
		Arrays.asList(IsaToken.NAT, IsaToken.NAT1, IsaToken.INT, 
						IsaToken.RAT, IsaToken.REAL, IsaToken.BOOL, 
						IsaToken.CHAR)); 

	public static final Set<IsaToken> NUMERIC_TYPES = new HashSet<IsaToken>(
		Arrays.asList(IsaToken.NAT, IsaToken.NAT1, IsaToken.INT, 
						IsaToken.RAT, IsaToken.REAL)); 

	//@NB oddly S: set of int = {-1.3,...,4.5} is allowed? I am removing real / rat from this
	public static final Set<IsaToken> SET_RANGE_TYPES = new HashSet<IsaToken>(
		Arrays.asList(IsaToken.NAT, IsaToken.NAT1, IsaToken.INT)); 
					
	/**
	 * Constructor useful for synthetically constructed types 
	 * @param location
	 * @param token
	 */
	protected TRBasicType(TCType vdmType, TRDefinitionList definitions, IsaToken token)
	{
		super(vdmType, definitions);
		this.token = token;
	}

	public TRBasicType(TCNaturalType type, TRDefinitionList definitions)
	{
		this(type, definitions, IsaToken.NAT);
	}

	public TRBasicType(TCNaturalOneType type, TRDefinitionList definitions)
	{
		this(type, definitions, IsaToken.NAT1);
	}

	public TRBasicType(TCIntegerType type, TRDefinitionList definitions)
	{
		this(type, definitions, IsaToken.INT);
	}

	public TRBasicType(TCRationalType type, TRDefinitionList definitions)
	{
		this(type, definitions, IsaToken.RAT);
	}

	public TRBasicType(TCRealType type, TRDefinitionList definitions)
	{
		this(type, definitions, IsaToken.REAL);
	}

	public TRBasicType(TCBooleanType type, TRDefinitionList definitions)
	{
		this(type, definitions, IsaToken.BOOL);
	}

	public TRBasicType(TCCharacterType type, TRDefinitionList definitions)
	{
		this(type, definitions, IsaToken.CHAR);
	}

	@Override
	public TRType copy(boolean atTLD)
	{
		TRType result = new TRBasicType(getVDMType(), definitions, token);
		TRNode.setup(result);
		result.setAtTopLevelDefinition(atTLD);
		return result;
	}

	@Override
	public void setup()
	{
		super.setup();
		if (!VALID_TOKENS.contains(this.token))
			report(IsaErrorMessage.ISA_TOKEN_ERROR_1P, token.toString());
		//System.out.println(toString());	
	}

	@Override
	public String getName()
	{
		return isaToken().toString();
	}

	@Override
	public void checkForUnionTypes()
	{
		// basic types are never unions; do nothing
	}

	@Override
	public String translate()
	{
		// \<bool> isn't allowed in some contexts as a name, so use bool instead. 
		return isaToken().equals(IsaToken.BOOL) ? IsaToken.BOOL.vdmToken().toString() : getName();
	}

	@Override
	protected String getInvTypeString()
	{
		// there is no "inv_bool" in the translation; add inv_bool for completeness. 
		String typeStr = isaToken().equals(IsaToken.BOOL) ? IsaToken.BOOL.vdmToken().toString() : translate();
		return IsaToken.INV.toString() + typeStr;
	}

	@Override
	public String invTranslate(String varName)
	{
		return IsaToken.parenthesise(
			getInvTypeString() + (varName == null ? "" : IsaToken.SPACE.toString() + varName));
	}

	@Override
	public IsaToken isaToken()
	{
		return token;
	}

	@Override 
	public boolean isOrdered()
	{
		return ORDERED_TYPES.contains(isaToken());
	}

	@Override
	public boolean isPossibleSetRange()
	{
		return SET_RANGE_TYPES.contains(isaToken());
	}

	/**
	 * Basic type can be a data type but callers have to "cast" back to (nat n),
	 * given VDMNat(1) is in fact int!!! 
	 */
	@Override
	public boolean isDataType()
	{
		return isaToken().equals(IsaToken.NAT) || isaToken().equals(IsaToken.NAT1);
	}

	@Override
	public boolean isUnion()
	{
		return false;
	}

	@Override
	public boolean isNumericType() {
        return NUMERIC_TYPES.contains(isaToken());
    }

	@Override
	public boolean isBooleanType()
	{
		return isaToken().equals(IsaToken.BOOL);
	}

	@Override 
	public boolean isVDMToken()
	{
		return isaToken().equals(IsaToken.TOKEN_TYPE);
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseBasicType(this, arg);
	}

	private static final TRType newBasicType(TCType vdmType, IsaToken token)  
	{
		assert !token.equals(IsaToken.TOKEN_TYPE);
		TRBasicType result = new TRBasicType(vdmType, new TRDefinitionList(), token);
		TRNode.setup(result);
		return result;
	}

	public static final TRType boolType(LexLocation location)  
	{
		return TRBasicType.newBasicType(new TCBooleanType(location), IsaToken.BOOL);
	}

	/**
	 * natType cannot be a datatype directly! Needs to (nat n)! 
	 * @param location
	 * @return
	 */
	public static final TRType natType(LexLocation location) {
		return TRBasicType.newBasicType(new TCNaturalType(location), IsaToken.NAT);
	}

	public static final TRType charType(LexLocation location) {
		return TRBasicType.newBasicType(new TCCharacterType(location), IsaToken.CHAR);
	}

	public static final TRType nat1Type(LexLocation location) {
		return TRBasicType.newBasicType(new TCNaturalOneType(location), IsaToken.NAT1);
	}
}
