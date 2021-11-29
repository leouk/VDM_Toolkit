/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions.visitors;

import java.util.Collection;

import vdm2isa.tr.TRVisitorSet;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRValueDefinition;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
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
import vdm2isa.tr.expressions.TRFunctionInstantiationExpression;
import vdm2isa.tr.expressions.TRIfExpression;
import vdm2isa.tr.expressions.TRIotaExpression;
import vdm2isa.tr.expressions.TRIsExpression;
import vdm2isa.tr.expressions.TRLambdaExpression;
import vdm2isa.tr.expressions.TRLetBeStExpression;
import vdm2isa.tr.expressions.TRLetDefExpression;
import vdm2isa.tr.expressions.TRMapCompExpression;
import vdm2isa.tr.expressions.TRMapEnumExpression;
import vdm2isa.tr.expressions.TRMapletExpression;
import vdm2isa.tr.expressions.TRMkTypeExpression;
import vdm2isa.tr.expressions.TRMuExpression;
import vdm2isa.tr.expressions.TRNarrowExpression;
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
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.patterns.TRMultipleSeqBind;
import vdm2isa.tr.patterns.TRMultipleSetBind;
import vdm2isa.tr.patterns.TRMultipleTypeBind;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.TRPatternList;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;


/**
 * This TRExpression visitor visits all of the leaves of an expression tree and calls
 * the basic processing methods for the simple expressions.
 */
abstract public class TRLeafExpressionVisitor<E, C extends Collection<E>, S> extends TRExpressionVisitor<C, S>
{
	protected TRVisitorSet<E, C, S> visitorSet;

	@Override
	public C caseCompExpression(TRAbstractCompExpression node, S arg)
	{
		C all = newCollection();
		all.addAll(node.first.apply(this, arg));
		
		all.addAll(caseMultupleBindList(node.bindings, arg));
		
		if (node.predicate != null)
		{
			all.addAll(node.predicate.apply(this, arg));
		}
		
		return all;
	}

 	@Override
	public C caseApplyExpression(TRApplyExpression node, S arg)
	{
		C all = newCollection();
		all.addAll(node.root.apply(this, arg));
		
		for (TRExpression a: node.args)
		{
			all.addAll(a.apply(this, arg));
		}
		
		return all;
	}
 	
 	@Override
	public C caseBinaryExpression(TRBinaryExpression node, S arg)
	{
		C all = newCollection();
		all.addAll(node.left.apply(this, arg));
		all.addAll(node.right.apply(this, arg));
		return all;
	}

	@Override
	public C caseBoundedExpression(TRBoundedExpression node, S arg)
	{
		C all = newCollection();
		
		all.addAll(caseMultupleBindList(node.bindList, arg));
		
		if (node.predicate != null)
		{
			all.addAll(node.predicate.apply(this, arg));
		}
		
		return all;
	}

 	@Override
	public C caseCasesExpression(TRCasesExpression node, S arg)
	{
 		TRPatternVisitor<C, S> patternVisitor = visitorSet.getPatternVisitor();
		C all = newCollection();
		all.addAll(node.exp.apply(this, arg));
		
		for (TRCaseAlternative a: node.cases)
		{
			if (patternVisitor != null)
			{
				all.addAll(a.pattern.apply(patternVisitor, arg));
			}
			
			all.addAll(a.result.apply(this, arg));
		}
		
		if (node.others != null)
		{
			all.addAll(node.others.apply(this, arg));
		}
		
		return all;
	}

 	@Override
	public C caseElseIfExpression(TRElseIfExpression node, S arg)
	{
		C all = newCollection();
		all.addAll(node.elseIfExp.apply(this, arg));
		all.addAll(node.thenExp.apply(this, arg));
		return all;
	}

	@Override
	public C caseEnumeratedExpression(TREnumeratedExpression node, S arg)
	{
		C all = newCollection();
		
		for (TRExpression m: node.members)
		{
			all.addAll(m.apply(this, arg));
		}
		
		return all;
	}

	@Override
	public C caseFieldExpression(TRFieldExpression node, S arg)
	{
		return node.object.apply(this, arg);
	}

 	@Override
	public C caseFieldNumberExpression(TRFieldNumberExpression node, S arg)
	{
 		return node.tuple.apply(this, arg);
	}

 	@Override
	public C caseFunctionInstantiationExpression(TRFunctionInstantiationExpression node, S arg)
	{
		return node.function.apply(this, arg);
	}

 	@Override
	public C caseIfExpression(TRIfExpression node, S arg)
	{
		C all = newCollection();
		all.addAll(node.ifExp.apply(this, arg));
		all.addAll(node.thenExp.apply(this, arg));
		
		for (TRElseIfExpression elseif: node.elseList)
		{
			all.addAll(elseif.apply(this, arg));
		}
		
		all.addAll(node.elseExp.apply(this, arg));
		return all;
	}

 	@Override
	public C caseIotaExpression(TRIotaExpression node, S arg)
	{
		C all = newCollection();
		all.addAll(caseMultipleBind(node.bind, arg));
		
		if (node.predicate != null)
		{
			all.addAll(node.predicate.apply(this, arg));
		}
		
		return all;
	}

 	@Override
	public C caseLambdaExpression(TRLambdaExpression node, S arg)
	{
		C all = newCollection();
		
		for (TRMultipleTypeBind bind: node.bindList)
		{
			all.addAll(caseMultipleBind(bind, arg));
		}

		//@NB is this right? Is it needed? Same for param patterns
		TRDefinitionVisitor<C, S> defVisitor = visitorSet.getDefinitionVisitor();	
		if (defVisitor != null && node.paramDefinitions != null)
		{
			for(TRDefinition d : node.paramDefinitions)
			{
				all.addAll(d.apply(defVisitor, arg));
			}
			if (node.def != null)
			{
				all.addAll(node.def.apply(defVisitor, arg));
			}
		}

		TRPatternVisitor<C, S> patternVisitor = visitorSet.getPatternVisitor();
		if (patternVisitor != null && node.paramPatterns != null)
		{
			for(TRPattern p : node.paramPatterns)
			{
				all.addAll(p.apply(patternVisitor, arg));
			}
		}

		all.addAll(caseVDMLocalDefinitionListExpression(node, arg));
		return all;
	}

 	@Override
	public C caseLetBeStExpression(TRLetBeStExpression node, S arg)
	{
		C all = newCollection();
	
		all.addAll(caseMultipleBind(node.bind, arg));
		
		if (node.suchThat != null)
		{
			all.addAll(node.suchThat.apply(this, arg));
		}

		//@NB is this right? Is it needed? Same for param patterns
		TRDefinitionVisitor<C, S> defVisitor = visitorSet.getDefinitionVisitor();	
		if (defVisitor != null && node.def != null)
		{
			all.addAll(node.def.apply(defVisitor, arg));
		}
		
		all.addAll(caseVDMLocalDefinitionListExpression(node, arg));
		return all;
	}

 	@Override
	public C caseLetDefExpression(TRLetDefExpression node, S arg)
	{
		C all = newCollection();

		for (TRDefinition def: node.localDefs)
 		{
 			if (def instanceof TRValueDefinition)
 			{
 				TRValueDefinition vdef = (TRValueDefinition)def;
 				all.addAll(vdef.exp.apply(this, arg));
 			}
 		}
 		
		all.addAll(caseVDMLocalDefinitionListExpression(node, arg));
		return all;
	}

	//@NB all this is covered by caseCompExpression anyhow? The node.first will reach caseMapletExpression?
 	// @Override
	// public C caseMapCompExpression(TRMapCompExpression node, S arg)
	// {
	// 	C all = newCollection();
	// 	all.addAll(node.first.left.apply(this, arg));
	// 	all.addAll(node.first.right.apply(this, arg));
		
	// 	for (TRMultipleBind mbind: node.bindings)
	// 	{
	// 		all.addAll(caseMultipleBind(mbind, arg));
	// 	}
		
	// 	if (node.predicate != null)
	// 	{
	// 		all.addAll(node.predicate.apply(this, arg));
	// 	}
		
	// 	return all;
	// }

 	@Override
	public C caseMapEnumExpression(TRMapEnumExpression node, S arg)
	{
		C all = newCollection();
		
		for (TRMapletExpression maplet: node.members)
		{
			//@NB this is right, right?
			//all.addAll(maplet.left.apply(this, arg));
			//all.addAll(maplet.right.apply(this, arg));
			all.addAll(maplet.apply(this, arg));
		}
		
		return all;
	}

 	@Override
	public C caseMkTypeExpression(TRMkTypeExpression node, S arg)
	{
		C all = newCollection();
		
		for (TRExpression a: node.args)
		{
			all.addAll(a.apply(this, arg));
		}
		
		return all;
	}

 	@Override
	public C caseMuExpression(TRMuExpression node, S arg)
	{
		C all = newCollection();
		
		for (TRRecordModifier modifier: node.modifiers)
		{
			all.addAll(modifier.value.apply(this, arg));
		}
		
		all.addAll(node.record.apply(this, arg));
		return all;
	}

	//@NB this falls back to caseVDMTestExpression
 	// @Override
	// public C caseNarrowExpression(TRNarrowExpression node, S arg)
	// {
	// 	return node.test.apply(this, arg);
	// }

	//@NB this I don't need given I don't have "new" ?(VDMPP only)?
 	// @Override
	// public C caseNewExpression(TRNewExpression node, S arg)
	// {
	// 	C all = newCollection();
		
	// 	for (TRExpression a: node.args)
	// 	{
	// 		all.addAll(a.apply(this, arg));
	// 	}
		
	// 	return all;
	// }
 	
 	@Override
 	public C casePreExpression(TRPreExpression node, S arg)
 	{
		C all = newCollection();
		all.addAll(node.function.apply(this, arg));
		
		for (TRExpression exp: node.args)
		{
			all.addAll(exp.apply(this, arg));
		}
		
		return all;
 	}

	 //@NB all these I don't need because they will be caught by caseCompExpression and caseEnumeratedExpression?
 	// @Override
	// public C caseSeqCompExpression(TRSeqCompExpression node, S arg)
	// {
	// 	C all = newCollection();
	// 	all.addAll(node.first.apply(this, arg));
	// 	all.addAll(caseBind(node.bind, arg));
		
	// 	if (node.predicate != null)
	// 	{
	// 		all.addAll(node.predicate.apply(this, arg));
	// 	}
		
	// 	return all;
	// }

 	// @Override
	// public C caseSeqEnumExpression(TRSeqEnumExpression node, S arg)
	// {
	// 	C all = newCollection();
		
	// 	for (TRExpression m: node.members)
	// 	{
	// 		all.addAll(m.apply(this, arg));
	// 	}
		
	// 	return all;
	// }

 	// @Override
	// public C caseSetCompExpression(TRSetCompExpression node, S arg)
	// {
	// 	C all = newCollection();
	// 	all.addAll(node.first.apply(this, arg));
		
	// 	for (TRMultipleBind mbind: node.bindings)
	// 	{
	// 		all.addAll(caseMultipleBind(mbind, arg));
	// 	}
		
	// 	if (node.predicate != null)
	// 	{
	// 		all.addAll(node.predicate.apply(this, arg));
	// 	}
		
	// 	return all;
	// }

 	// @Override
	// public C caseSetEnumExpression(TRSetEnumExpression node, S arg)
	// {
	// 	C all = newCollection();
		
	// 	for (TRExpression m: node.members)
	// 	{
	// 		all.addAll(m.apply(this, arg));
	// 	}
		
	// 	return all;
	// }

 	@Override
	public C caseSetRangeExpression(TRSetRangeExpression node, S arg)
	{
		C all = newCollection();
		all.addAll(node.first.apply(this, arg));
		all.addAll(node.last.apply(this, arg));
		return all;
	}

 	@Override
	public C caseSubseqExpression(TRSubseqExpression node, S arg)
	{
		C all = newCollection();
		all.addAll(node.seq.apply(this, arg));
		all.addAll(node.from.apply(this, arg));
		all.addAll(node.to.apply(this, arg));

		//@NB is the above better? Or the same? 
		// C all = node.seq.apply(this, arg);
		// all.addAll(node.from.apply(this, arg));
		// all.addAll(node.to.apply(this, arg));
		return all;
	}

	//@NB caught by caseEnumeratedExpression
 	// @Override
	// public C caseTupleExpression(TRTupleExpression node, S arg)
	// {
	// 	C all = newCollection();
		
	// 	for (TRExpression m: node.args)
	// 	{
	// 		all.addAll(m.apply(this, arg));
	// 	}
		
	// 	return all;
	// }

	//@NB this catches a whole raft of them, like TRBinaryExpr
 	@Override
	public C caseUnaryExpression(TRUnaryExpression node, S arg)
	{
		C all = newCollection();
		all.addAll(node.exp.apply(this, arg));
		return all;
	}

	@Override
	public C caseVDMLocalDefinitionListExpression(TRVDMLocalDefinitionListExpression node, S arg)
	{
		return node.expression.apply(this, arg);
	}

	@Override
	public C caseVDMTestExpression(TRVDMTestExpression node, S arg)
	{
		TRDefinitionVisitor<C, S> defVisitor = visitorSet.getDefinitionVisitor();
		C all = newCollection();
		
		if (defVisitor != null && node.typedef != null)
		{
			all.addAll(node.typedef.apply(defVisitor, arg));
		}
		
	   all.addAll(node.test.apply(this, arg));
	   return all;
	}

 	/**
 	 * These bind and multiple bind cases cover the common expression visitor
 	 * cases, but they can be overridden, perhaps to use the (m)bind visitorSet
 	 * entry if required. 
 	 */
	protected C caseMultupleBindList(TRMultipleBindList bindList, S arg)
	{
		C all = newCollection();
		for(TRMultipleBind b : bindList)
		{
			all.addAll(caseMultipleBind(b, arg));
		}
		return all;		
	}

 	protected C caseMultipleBind(TRMultipleBind bind, S arg)
	{
		C all = newCollection();
		
		//@NB shouldn't we also look into the bind's patterns? 
		TRPatternVisitor<C, S> patternVisitor = visitorSet.getPatternVisitor();
		if (patternVisitor != null && bind.plist != null)
		{
			for(TRPattern p : bind.plist)
			{
				all.addAll(p.apply(patternVisitor, arg));
			}
		}

		if (bind instanceof TRMultipleSetBind)
		{
			TRMultipleSetBind sbind = (TRMultipleSetBind)bind;
			all.addAll(sbind.set.apply(this, arg));
		}
		else if (bind instanceof TRMultipleSeqBind)
		{
			TRMultipleSeqBind sbind = (TRMultipleSeqBind)bind;
			all.addAll(sbind.seq.apply(this, arg));
		}
		
		return all;
	}
	
	abstract protected C newCollection();
}
