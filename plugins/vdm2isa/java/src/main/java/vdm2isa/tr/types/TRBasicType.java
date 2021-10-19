/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCCharacterType;
import com.fujitsu.vdmj.tc.types.TCIntegerType;
import com.fujitsu.vdmj.tc.types.TCNaturalOneType;
import com.fujitsu.vdmj.tc.types.TCNaturalType;
import com.fujitsu.vdmj.tc.types.TCRationalType;
import com.fujitsu.vdmj.tc.types.TCRealType;
import com.fujitsu.vdmj.tc.types.TCBooleanType;
import com.fujitsu.vdmj.tc.types.TCTokenType;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.lex.IsaToken;

public class TRBasicType extends TRType
{
	private static final long serialVersionUID = 1L;
	private final TCType type;

	public TRBasicType(TCNaturalType type)
	{
		super(type.location);
		this.type = type;
	}

	public TRBasicType(TCNaturalOneType type)
	{
		super(type.location);
		this.type = type;
	}

	public TRBasicType(TCIntegerType type)
	{
		super(type.location);
		this.type = type;
	}

	public TRBasicType(TCRationalType type)
	{
		super(type.location);
		this.type = type;
	}

	public TRBasicType(TCRealType type)
	{
		super(type.location);
		this.type = type;
	}

	public TRBasicType(TCBooleanType type)
	{
		super(type.location);
		this.type = type;
	}

	public TRBasicType(TCCharacterType type)
	{
		super(type.location);
		this.type = type;
	}

	public TRBasicType(TCTokenType type)
	{
		super(type.location);
		this.type = type;
	}

	@Override
	public String translate()
	{
		return isaToken().toString();
	}

	@Override
	public String invTranslate(String varName)
	{
		// there is no "inv_\<bool>" in the translation; add inv_bool for completeness. 
		String typeStr = isaToken() == IsaToken.BOOL ? "bool" : translate();
		return IsaToken.INV + typeStr + " " + varName;
	}

	@Override
	public IsaToken isaToken()
	{
		if (type instanceof TCNaturalType)
			return IsaToken.NAT; 
		else if (type instanceof TCNaturalOneType)
			return IsaToken.NAT1;
		else if (type instanceof TCIntegerType)
			return IsaToken.INT;
		else if (type instanceof TCRationalType)	
			return IsaToken.RAT;
		else if (type instanceof TCRealType)
			return IsaToken.REAL;
		else if (type instanceof TCBooleanType)
			return IsaToken.BOOL;
		else if (type instanceof TCCharacterType)
			return IsaToken.CHAR;
		else if (type instanceof TCTokenType)
			return IsaToken.TOKEN;
		else
			throw new RuntimeException("Untranslatable type " + type.toDetailedString());

	}
}
