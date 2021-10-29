/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions.visitors;

import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.tr.TRVisitorSet;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRExampleLeafVisitor extends TRLeafDefinitionVisitor<TCNameToken, TCNameSet, Object>
{
	/**
	 * A VisitorSet defines a group of visitors that are used to complete the task,
	 * with one visitor for each grammatical group that matters. The parent leaf visitor
	 * will apply the corresponding visitor to branches of the AST - eg. a function definition
	 * node might apply the pattern visitor to the arguments, the type visitor to the type
	 * and the expression visitor to the body and pre/posts.
	 * 
	 * Note that the "lead visitor" is passed to the constructor. This is usually the
	 * definition visitor, though it need not be. See the comment in the TRExampleLeafVisitor
	 * constructor below. 
	 */
	private static class VisitorSet extends TRVisitorSet<TCNameToken, TCNameSet, Object>
	{
		private final TRExampleLeafVisitor defVisitor;
		private final TRExpressionVisitor<TCNameSet, Object> expVisitor;
		private final TRTypeVisitor<TCNameSet, Object> typeVisitor;
		private final TRMultipleBindVisitor<TCNameSet, Object> mbindVisitor;

		public VisitorSet(TRExampleLeafVisitor parent)
		{
			defVisitor = parent;
			expVisitor = null;		// new ExampleExpVisitor(this);
			typeVisitor = null;		// new ExampleTypeVisitor(this);
			mbindVisitor = null;	// new ExampleMBindVisitor(this);
		}
		
		@Override
		public TRDefinitionVisitor<TCNameSet, Object> getDefinitionVisitor()
		{
			return defVisitor;
		}

		@Override
		public TRExpressionVisitor<TCNameSet, Object> getExpressionVisitor()
	 	{
	 		return expVisitor;
	 	}
	 	
		@Override
		public TRTypeVisitor<TCNameSet, Object> getTypeVisitor()
	 	{
	 		return typeVisitor;
	 	}
		
		@Override
		public TRMultipleBindVisitor<TCNameSet, Object> getMultiBindVisitor()
		{
			return mbindVisitor;
		}
	}

	/**
	 * The "leader" of the set of related visitors has a constructor with no parameters, and
	 * creates the VisitorSet (defined above). The other auxilliary visitors define a
	 * constructor that takes the VisitorSet argument - these are created in the VisitorSet
	 * constructor above. They obviously just assign visitorSet to the argument passed. That
	 * way, all members of the set share the same set of visitors and can jump around
	 * between them as required. The end user just creates the lead visitor to start the
	 * process.
	 */
	public TRExampleLeafVisitor()
	{
		visitorSet = new VisitorSet(this);
	}

	/**
	 * This has to be provided to return a new collection of the generic type passed to
	 * the leaf visitor in the "extends" clause.
	 */
	@Override
	protected TCNameSet newCollection()
	{
		return new TCNameSet();
	}
	
	/**
	 * Then the visitor just overrides the cases that it cares about. The search process
	 * is handled by the parent leaf visitor.
	 */

	@Override
	public TCNameSet caseDefinition(TRDefinition node, Object arg)
	{
		// ... default behaviour if not caught below
		return newCollection();
	}

	@Override
	public TCNameSet caseExplicitFunctionDefinition(TRExplicitFunctionDefinition node, Object arg)
	{
		// ... specific behaviour for explicit functions
		return newCollection();
	}
	
	// etc for the other special cases
}
