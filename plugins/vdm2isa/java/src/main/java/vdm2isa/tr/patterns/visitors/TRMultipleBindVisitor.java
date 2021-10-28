/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.patterns.visitors;

import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleSeqBind;
import vdm2isa.tr.patterns.TRMultipleSetBind;
import vdm2isa.tr.patterns.TRMultipleTypeBind;

/**
 * The base type for all TRMultipleBind visitors. All methods, by default, call
 * the abstract caseMultipleBind method, via the various intermediate default
 * methods for their parent types.
 */
public abstract class TRMultipleBindVisitor<R, S>
{
 	abstract public R caseMultipleBind(TRMultipleBind node, S arg);

 	public R caseMultipleSeqBind(TRMultipleSeqBind node, S arg)
	{
		return caseMultipleBind(node, arg);
	}

 	public R caseMultipleSetBind(TRMultipleSetBind node, S arg)
	{
		return caseMultipleBind(node, arg);
	}

 	public R caseMultipleTypeBind(TRMultipleTypeBind node, S arg)
	{
		return caseMultipleBind(node, arg);
	}
}
