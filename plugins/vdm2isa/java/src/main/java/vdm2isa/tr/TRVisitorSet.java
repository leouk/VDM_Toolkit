/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr;

import java.util.Collection;

import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

/**
 * A collection of visitors to pass between types of Leaf visitor as they process a tree.
 * This abstract class is made concrete and defines visitors of the different types that
 * can be called by the Leaf visitors for this particular application. 
 *
 * @param <E>
 * @param <C>
 * @param <S>
 */
abstract public class TRVisitorSet<E, C extends Collection<E>, S>
{
	public TRDefinitionVisitor<C, S> getDefinitionVisitor()
 	{
 		return null;
 	}
	
	public TRExpressionVisitor<C, S> getExpressionVisitor()
 	{
 		return null;
 	}
 	
	public TRPatternVisitor<C, S> getPatternVisitor()
 	{
 		return null;
 	}
 	
	public TRTypeVisitor<C, S> getTypeVisitor()
 	{
 		return null;
 	}

	public TRMultipleBindVisitor<C, S> getMultiBindVisitor()
	{
		return null;
	}
}
