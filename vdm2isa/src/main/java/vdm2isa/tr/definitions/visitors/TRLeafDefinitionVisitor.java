/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions.visitors;

import java.util.Collection;

import vdm2isa.tr.TRVisitorSet;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.definitions.TRLocalDefinition;
import vdm2isa.tr.definitions.TRTypeDefinition;
import vdm2isa.tr.definitions.TRValueDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.TRPatternList;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

/**
 * This TRDefinition visitor visits all of the leaves of a definition tree and calls
 * the basic processing methods for the simple statements and expressions.
 */
abstract public class TRLeafDefinitionVisitor<E, C extends Collection<E>, S> extends TRDefinitionVisitor<C, S>
{
	protected TRVisitorSet<E, C, S> visitorSet;
	
 	@Override
	public C caseExplicitFunctionDefinition(TRExplicitFunctionDefinition node, S arg)
	{
		TRExpressionVisitor<C, S> expVisitor = visitorSet.getExpressionVisitor();
		TRTypeVisitor<C, S> typeVisitor = visitorSet.getTypeVisitor();
		TRPatternVisitor<C, S> patternVisitor = visitorSet.getPatternVisitor();
		C all = newCollection();
		
		if (patternVisitor != null)
		{
			all.addAll(patternCheck(patternVisitor, node.getParameters(), arg));
		}
		
		if (typeVisitor != null)
		{
			all.addAll(node.getType().apply(typeVisitor, arg));
		}
		
		if (expVisitor != null)
		{
			all.addAll(node.getBody().apply(expVisitor, arg));
		}
		
		if (node.getPredef() != null)
		{
			all.addAll(node.getPredef().apply(this, arg));
		}
		
		if (node.getPostdef() != null)
		{
			all.addAll(node.getPostdef().apply(this, arg));
		}
		
		if (node.getMeasureDef() != null)
		{
			all.addAll(node.getMeasureDef().apply(this, arg));
		}
		
		return all;
	}

 	@Override
	public C caseLocalDefinition(TRLocalDefinition node, S arg)
	{
		TRTypeVisitor<C, S> typeVisitor = visitorSet.getTypeVisitor();
		C all = newCollection();
		
		if (typeVisitor != null)
		{
			all.addAll(node.getType().apply(typeVisitor, arg));
		}
		
		return all;
	}

 	@Override
	public C caseTypeDefinition(TRTypeDefinition node, S arg)
	{
		TRExpressionVisitor<C, S> expVisitor = visitorSet.getExpressionVisitor();
		TRTypeVisitor<C, S> typeVisitor = visitorSet.getTypeVisitor();
		C all = newCollection();
		
		if (typeVisitor != null)
		{
			all.addAll(node.getType().apply(typeVisitor, arg));
		}
		
		if (expVisitor != null)
		{
			if (node.getInvExpression() != null)
			{
				all.addAll(node.getInvExpression().apply(expVisitor, arg));
			}

			if (node.getEqExpression() != null)
			{
				all.addAll(node.getEqExpression().apply(expVisitor, arg));
			}

			if (node.getOrdExpression() != null)
			{
				all.addAll(node.getOrdExpression().apply(expVisitor, arg));
			}
		}
		
		return all;
	}

 	@Override
	public C caseValueDefinition(TRValueDefinition node, S arg)
	{
		TRExpressionVisitor<C, S> expVisitor = visitorSet.getExpressionVisitor();
		TRTypeVisitor<C, S> typeVisitor = visitorSet.getTypeVisitor();
		TRPatternVisitor<C, S> patternVisitor = visitorSet.getPatternVisitor();
		C all = newCollection();
		
		if (patternVisitor != null)
		{
			all.addAll(node.getPattern().apply(patternVisitor, arg));
		}
		
		if (typeVisitor != null)
		{
			all.addAll(node.getType().apply(typeVisitor, arg));
		}
		
		if (expVisitor != null)
		{
			all.addAll(node.getExp().apply(expVisitor, arg));
		}
		
		return all;
	}
	
	protected C patternCheck(TRPatternVisitor<C, S> patternVisitor, TRPatternListList paramPatternList, S arg)
	{
		C all = newCollection();

		for (TRPatternList list: paramPatternList)
		{
			all.addAll(patternCheck(patternVisitor, list, arg));
		}
		
		return all;
	}

	protected C patternCheck(TRPatternVisitor<C, S> patternVisitor, TRPatternList list, S arg)
	{
		C all = newCollection();

		for (TRPattern p: list)
		{
			all.addAll(p.apply(patternVisitor, arg));
		}
		
		return all;
	}
	
	abstract protected C newCollection();
}
