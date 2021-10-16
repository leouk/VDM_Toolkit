/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCIntegerType;
import com.fujitsu.vdmj.tc.types.TCNaturalOneType;
import com.fujitsu.vdmj.tc.types.TCNaturalType;
import com.fujitsu.vdmj.tc.types.TCRationalType;
import com.fujitsu.vdmj.tc.types.TCRealType;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.lex.IsaToken;

public class TRNumericType extends TRType
{
	private static final long serialVersionUID = 1L;
	private final TCType type;

	public TRNumericType(TCNaturalType type)
	{
		this.type = type;
	}

	public TRNumericType(TCNaturalOneType type)
	{
		this.type = type;
	}

	public TRNumericType(TCIntegerType type)
	{
		this.type = type;
	}

	public TRNumericType(TCRationalType type)
	{
		this.type = type;
	}

	public TRNumericType(TCRealType type)
	{
		this.type = type;
	}
	
	@Override
	public String translate()
	{
		switch (type.toString())
		{
			case "nat" : return IsaToken.NAT.toString(); 
			case "nat1": return IsaToken.NAT1.toString();
			case "int" : return IsaToken.INT.toString();
			case "rat" : return IsaToken.RAT.toString();
			case "real": return IsaToken.REAL.toString();
			default:
				throw new RuntimeException("Untranslatable type " + type);
		}
	}
}
