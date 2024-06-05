/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr;

import java.util.Collection;

import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

/**
 * A collection of visitors to pass between types of Leaf visitor as they process a tree.
 * This abstract class is made concrete and defines visitors of the different types that
 * can be called by the Leaf visitors for this particular application. 
 *
 * @param <E> - an element of the collection result
 * @param <C> - the collection result
 * @param <S> - the argument type.
 */
abstract public class TRVisitorSet<E, C extends Collection<E>, S>
{
	protected TRDefinitionVisitor<C, S> definitionVisitor = null;
	protected TRExpressionVisitor<C, S> expressionVisitor = null;
	//protected TRStatementVisitor<C, S> statementVisitor = null;
	protected TRPatternVisitor<C, S> patternVisitor = null;
	protected TRTypeVisitor<C, S> typeVisitor = null;
	//protected TRBindVisitor<C, S> bindVisitor = null;
	protected TRMultipleBindVisitor<C, S> multiBindVisitor = null;
	
	protected TRVisitorSet()
	{
		setVisitors();	// Calls override version in Java :-)
	}
	
	/**
	 * This method is responsible for setting all of the visitors required in
	 * the set. It is typically called by the "lead" visitor (eg. the Definition
	 * visitor).
	 */
	abstract protected void setVisitors();
	
	/**
	 * This will usually just call Outer.this.newCollection(), assuming the VisitorSet
	 * is an inner class of the lead visitor. 
	 */
	abstract protected C newCollection();

	/**
	 * The remaining method allow visitors to be retrieved, or more often applied to
	 * members of their type, which checks for a "null" visitor first.
	 */
	
	public TRDefinitionVisitor<C, S> getDefinitionVisitor()
 	{
 		return definitionVisitor;
 	}
	
	public C applyDefinitionVisitor(TRDefinition def, S arg)
	{
 		if (definitionVisitor != null)
 		{
 			return def.apply(definitionVisitor, arg);
 		}
 		else
 		{
 			return newCollection();
 		}
	}
	
	public TRExpressionVisitor<C, S> getExpressionVisitor()
 	{
 		return expressionVisitor;
 	}
 	
	public C applyExpressionVisitor(TRExpression def, S arg)
	{
 		if (expressionVisitor != null)
 		{
 			return def.apply(expressionVisitor, arg);
 		}
 		else
 		{
 			return newCollection();
 		}
	}
	
	// public TRStatementVisitor<C, S> getStatementVisitor()
 	// {
 	// 	return statementVisitor;
 	// }

	// public C applyStatementVisitor(TRStatement def, S arg)
	// {
 	// 	if (statementVisitor != null)
 	// 	{
 	// 		return def.apply(statementVisitor, arg);
 	// 	}
 	// 	else
 	// 	{
 	// 		return newCollection();
 	// 	}
	// }
	
	public TRPatternVisitor<C, S> getPatternVisitor()
 	{
 		return patternVisitor;
 	}
 	
	public C applyPatternVisitor(TRPattern def, S arg)
	{
 		if (patternVisitor != null)
 		{
 			return def.apply(patternVisitor, arg);
 		}
 		else
 		{
 			return newCollection();
 		}
	}
	
	public TRTypeVisitor<C, S> getTypeVisitor()
 	{
 		return typeVisitor;
 	}

	public C applyTypeVisitor(TRType def, S arg)
	{
 		if (typeVisitor != null)
 		{
 			return def.apply(typeVisitor, arg);
 		}
 		else
 		{
 			return newCollection();
 		}
	}
	
	// public TRBindVisitor<C, S> getBindVisitor()
	// {
	// 	return bindVisitor;
	// }

	// public C applyBindVisitor(TRBind def, S arg)
	// {
 	// 	if (bindVisitor != null)
 	// 	{
 	// 		return def.apply(bindVisitor, arg);
 	// 	}
 	// 	else
 	// 	{
 	// 		return newCollection();
 	// 	}
	// }
	
	public TRMultipleBindVisitor<C, S> getMultiBindVisitor()
	{
		return multiBindVisitor;
	}
	
	public C applyMultiBindVisitor(TRMultipleBind def, S arg)
	{
 		if (multiBindVisitor != null)
 		{
 			return def.apply(multiBindVisitor, arg);
 		}
 		else
 		{
 			return newCollection();
 		}
	}
}
