/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions.visitors;

import vdm2isa.tr.expressions.TRAbstractCompExpression;
import vdm2isa.tr.expressions.TRApplyExpression;
import vdm2isa.tr.expressions.TRBinaryExpression;
import vdm2isa.tr.expressions.TRBoundedExpression;
import vdm2isa.tr.expressions.TRCaseAlternative;
import vdm2isa.tr.expressions.TRCasesExpression;
import vdm2isa.tr.expressions.TRElseIfExpression;
import vdm2isa.tr.expressions.TREnumeratedExpression;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRFieldExpression;
import vdm2isa.tr.expressions.TRFieldNumberExpression;
import vdm2isa.tr.expressions.TRIfExpression;
import vdm2isa.tr.expressions.TRIotaExpression;
import vdm2isa.tr.expressions.TRIsExpression;
import vdm2isa.tr.expressions.TRLambdaExpression;
import vdm2isa.tr.expressions.TRLetBeStExpression;
import vdm2isa.tr.expressions.TRLetDefExpression;
import vdm2isa.tr.expressions.TRLiteralExpression;
import vdm2isa.tr.expressions.TRMapCompExpression;
import vdm2isa.tr.expressions.TRMapEnumExpression;
import vdm2isa.tr.expressions.TRMapletExpression;
import vdm2isa.tr.expressions.TRMkTypeExpression;
import vdm2isa.tr.expressions.TRMuExpression;
import vdm2isa.tr.expressions.TRNarrowExpression;
import vdm2isa.tr.expressions.TRNilExpression;
import vdm2isa.tr.expressions.TRNotYetSpecifiedExpression;
import vdm2isa.tr.expressions.TRPreExpression;
import vdm2isa.tr.expressions.TRRecordModifier;
import vdm2isa.tr.expressions.TRSeqCompExpression;
import vdm2isa.tr.expressions.TRSeqEnumExpression;
import vdm2isa.tr.expressions.TRSetCompExpression;
import vdm2isa.tr.expressions.TRSetEnumExpression;
import vdm2isa.tr.expressions.TRSetRangeExpression;
import vdm2isa.tr.expressions.TRSubseqExpression;
import vdm2isa.tr.expressions.TRTupleExpression;
import vdm2isa.tr.expressions.TRUnaryExpression;
import vdm2isa.tr.expressions.TRVDMLocalDefinitionListExpression;
import vdm2isa.tr.expressions.TRVDMTestExpression;
import vdm2isa.tr.expressions.TRVariableExpression;

/**
 * The base type for all TRExpression visitors. All methods, by default, call
 * the abstract caseExpression method, via the various intermediate default
 * methods for their parent types.
 */
public abstract class TRExpressionVisitor<R, S>
{
 	abstract public R caseExpression(TRExpression node, S arg);

 	public R caseApplyExpression(TRApplyExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseBinaryExpression(TRBinaryExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseBoundedExpression(TRBoundedExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseEnumeratedExpression(TREnumeratedExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseFieldExpression(TRFieldExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseFieldNumberExpression(TRFieldNumberExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseIfExpression(TRIfExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

	public R caseElseIfExpression(TRElseIfExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseIotaExpression(TRIotaExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseIsExpression(TRIsExpression node, S arg)
	{
		return caseVDMTestExpression(node, arg);
	}

 	public R caseLambdaExpression(TRLambdaExpression node, S arg)
	{
		return caseVDMLocalDefinitionListExpression(node, arg);
	}

 	public R caseLetDefExpression(TRLetDefExpression node, S arg)
	{
		return caseVDMLocalDefinitionListExpression(node, arg);
	}

 	public R caseLiteralExpression(TRLiteralExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseMapEnumExpression(TRMapEnumExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseMapletExpression(TRMapletExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseMkTypeExpression(TRMkTypeExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseMuExpression(TRMuExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseNarrowExpression(TRNarrowExpression node, S arg)
	{
		return caseVDMTestExpression(node, arg);
	}

 	public R caseNilExpression(TRNilExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseNotYetSpecifiedExpression(TRNotYetSpecifiedExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseRecordModifier(TRRecordModifier node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseSeqCompExpression(TRSeqCompExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseSeqEnumExpression(TRSeqEnumExpression node, S arg)
	{
		return caseEnumeratedExpression(node, arg);
	}

 	public R caseSetCompExpression(TRSetCompExpression node, S arg)
	{
		return caseCompExpression(node, arg);
	}

 	public R caseSetEnumExpression(TRSetEnumExpression node, S arg)
	{
		return caseEnumeratedExpression(node, arg);
	}

 	public R caseSetRangeExpression(TRSetRangeExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseSubseqExpression(TRSubseqExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseTupleExpression(TRTupleExpression node, S arg)
	{
		return caseEnumeratedExpression(node, arg);
	}

 	public R caseUnaryExpression(TRUnaryExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseVariableExpression(TRVariableExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

	public R caseCompExpression(TRAbstractCompExpression node, S arg)
	{
		return caseExpression(node, arg);
	}


 	public R caseVDMLocalDefinitionListExpression(TRVDMLocalDefinitionListExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

 	public R caseVDMTestExpression(TRVDMTestExpression node, S arg)
	{
		return caseExpression(node, arg);
	}

    public R casePreExpression(TRPreExpression node, S args) {
        return caseExpression(node, args);
    }

    public R caseLetBeStExpression(TRLetBeStExpression node, S arg) {
        return caseVDMLocalDefinitionListExpression(node, arg);
    }

	public R caseCaseExpression(TRCasesExpression node, S arg) {
		return caseExpression(node, arg);
	}

    public R caseCaseAlternative(TRCaseAlternative node, S arg) {
        return caseExpression(node, arg);
    }

    public R caseMapCompExpression(TRMapCompExpression node, S arg) {
        return caseCompExpression(node, arg);
    }
}
