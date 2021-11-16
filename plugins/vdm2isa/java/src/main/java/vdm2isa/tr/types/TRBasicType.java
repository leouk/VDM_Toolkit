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
import com.fujitsu.vdmj.tc.types.TCTokenType;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRBasicType extends TRType
{
	private static final long serialVersionUID = 1L;
	private final IsaToken token;

	public static final Set<IsaToken> VALID_TOKENS = new HashSet<IsaToken>(
		Arrays.asList(IsaToken.NAT, IsaToken.NAT1, IsaToken.INT, 
					  IsaToken.RAT, IsaToken.REAL, IsaToken.BOOL, 
					  IsaToken.CHAR, IsaToken.TOKEN)); 

	public static final Set<IsaToken> ORDERED_TYPES = new HashSet<IsaToken>(
		Arrays.asList(IsaToken.NAT, IsaToken.NAT1, IsaToken.INT, 
						IsaToken.RAT, IsaToken.REAL, IsaToken.BOOL, 
						IsaToken.CHAR, IsaToken.TOKEN)); 

	public static final Set<IsaToken> NUMERIC_TYPES = new HashSet<IsaToken>(
		Arrays.asList(IsaToken.NAT, IsaToken.NAT1, IsaToken.INT, 
						IsaToken.RAT, IsaToken.REAL)); 

	/**
	 * Constructor useful for synthetically constructed types 
	 * @param location
	 * @param token
	 */
	public TRBasicType(TCType vdmType, TRDefinitionList definitions, IsaToken token)
	{
		super(vdmType, definitions);
		this.token = token;
		if (!VALID_TOKENS.contains(this.token))
			report(IsaErrorMessage.ISA_TOKEN_ERROR_1P, token.toString());
		//System.out.println(toString());	
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

	public TRBasicType(TCTokenType type, TRDefinitionList definitions)
	{
		this(type, definitions, IsaToken.TOKEN);
	}

	@Override 
	public boolean isOrdered()
	{
		return ORDERED_TYPES.contains(isaToken());
	}

	@Override
	public String getName()
	{
		return isaToken().toString();
	}

	@Override
	public String translate()
	{
		return getName();
	}

	@Override
	public String invTranslate(String varName)
	{
		// there is no "inv_bool" in the translation; add inv_bool for completeness. 
		String typeStr = isaToken().equals(IsaToken.BOOL) ? IsaToken.BOOL.vdmToken().toString() : translate();
		return IsaToken.parenthesise(
			IsaToken.INV.toString() + 
			typeStr + (varName == null ? "" : " " + varName));
	}

	@Override
	public IsaToken isaToken()
	{
		return token;
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseBasicType(this, arg);
	}

	public boolean isNumericType() {
        return NUMERIC_TYPES.contains(isaToken());
    }

	public static TRType newBasicType(TCType vdmType, IsaToken token)  
	{
		return new TRBasicType(vdmType, new TRDefinitionList(), token);
	}

	public static TRType boolType(LexLocation location)  
	{
		return newBasicType(new TCBooleanType(location), IsaToken.BOOL);
	}

	public static TRType natType(LexLocation location) {
		return newBasicType(new TCNaturalType(location), IsaToken.NAT);
	}

	public static TRType charType(LexLocation location) {
		return newBasicType(new TCCharacterType(location), IsaToken.CHAR);
	}

	public static TRType nat1Type(LexLocation location) {
		return newBasicType(new TCNaturalOneType(location), IsaToken.NAT1);
	}
}
