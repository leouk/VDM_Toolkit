/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCBooleanType;
import com.fujitsu.vdmj.tc.types.TCCharacterType;
import com.fujitsu.vdmj.tc.types.TCIntegerType;
import com.fujitsu.vdmj.tc.types.TCNaturalOneType;
import com.fujitsu.vdmj.tc.types.TCNaturalType;
import com.fujitsu.vdmj.tc.types.TCRationalType;
import com.fujitsu.vdmj.tc.types.TCRealType;
import com.fujitsu.vdmj.tc.types.TCTokenType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRBasicType extends TRType
{
	private static final long serialVersionUID = 1L;
	private final IsaToken token;

	public TRBasicType(TCNaturalType type)
	{
		super(type.location);
		this.token = IsaToken.NAT;
	}

	public TRBasicType(TCNaturalOneType type)
	{
		super(type.location);
		this.token = IsaToken.NAT1;
	}

	public TRBasicType(TCIntegerType type)
	{
		super(type.location);
		this.token = IsaToken.INT;
	}

	public TRBasicType(TCRationalType type)
	{
		super(type.location);
		this.token = IsaToken.RAT;
	}

	public TRBasicType(TCRealType type)
	{
		super(type.location);
		this.token = IsaToken.REAL;
	}

	public TRBasicType(TCBooleanType type)
	{
		super(type.location);
		this.token = IsaToken.BOOL;
	}

	public TRBasicType(TCCharacterType type)
	{
		super(type.location);
		this.token = IsaToken.CHAR;
	}

	public TRBasicType(TCTokenType type)
	{
		super(type.location);
		this.token = IsaToken.TOKEN;
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
}
