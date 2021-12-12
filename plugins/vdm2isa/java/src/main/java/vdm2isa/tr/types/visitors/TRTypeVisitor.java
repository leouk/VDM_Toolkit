/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types.visitors;

import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRBracketType;
import vdm2isa.tr.types.TRField;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRInvariantType;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRNamedType;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRProductType;
import vdm2isa.tr.types.TRQuoteType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRTokenType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRUnionType;
import vdm2isa.tr.types.TRUnknownType;

/**
 * The base type for all TRType visitors. All methods, by default, call
 * the abstract caseType method, via the various intermediate default
 * methods for their parent types.
 */
public abstract class TRTypeVisitor<R, S>
{
 	abstract public R caseType(TRType node, S arg);

 	public R caseBasicType(TRBasicType node, S arg)
	{
		return caseType(node, arg);
	}

 	public R caseFunctionType(TRFunctionType node, S arg)
	{
		return caseType(node, arg);
	}

 	public R caseInvariantType(TRInvariantType node, S arg)
	{
		return caseType(node, arg);
	}

 	public R caseMapType(TRMapType node, S arg)
	{
		return caseType(node, arg);
	}

 	public R caseNamedType(TRNamedType node, S arg)
	{
		return caseInvariantType(node, arg);
	}

 	public R caseOptionalType(TROptionalType node, S arg)
	{
		return caseType(node, arg);
	}

 	public R caseProductType(TRProductType node, S arg)
	{
		return caseType(node, arg);
	}

 	public R caseQuoteType(TRQuoteType node, S arg)
	{
		return caseType(node, arg);
	}

 	public R caseRecordType(TRRecordType node, S arg)
	{
		return caseInvariantType(node, arg);
	}

 	public R caseSeqType(TRSeqType node, S arg)
	{
		return caseType(node, arg);
	}

 	public R caseSetType(TRSetType node, S arg)
	{
		return caseType(node, arg);
	}

 	public R caseUnknownType(TRUnknownType node, S arg)
	{
		return caseType(node, arg);
	}

	public R caseField(TRField node, S arg)
	{
		return caseType(node, arg);
	}

    public R caseUnionType(TRUnionType node, S arg) {
        return caseType(node, arg);
    }

    public R caseBracketType(TRBracketType node, S arg) {
        return caseType(node, arg);
    }

    public R caseTokenType(TRTokenType node, S arg) {
        return caseBasicType(node, arg);
    }
}
