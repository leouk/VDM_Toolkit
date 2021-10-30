/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.patterns.visitors;

import vdm2isa.tr.patterns.TRBasicPattern;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.TRRecordPattern;
import vdm2isa.tr.patterns.TRStructuredPattern;

/**
 * The base type for all TRPatternBind visitors. All methods, by default, call
 * the abstract casePattern method, via the various intermediate default
 * methods for their parent types.
 */
public abstract class TRPatternVisitor<R, S>
{
 	abstract public R casePattern(TRPattern node, S arg);

 	public R caseBasicPattern(TRBasicPattern node, S arg)
	{
		return casePattern(node, arg);
	}

  	public R caseStructuredPattern(TRStructuredPattern node, S arg)
	{
		return casePattern(node, arg);
	}

	public R caseRecordPattern(TRRecordPattern node, S arg)
	{
		return casePattern(node, arg);
	}

}
