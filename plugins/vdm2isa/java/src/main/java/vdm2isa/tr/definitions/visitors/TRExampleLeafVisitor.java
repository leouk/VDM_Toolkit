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

	public TRExampleLeafVisitor()
	{
		visitorSet = new VisitorSet(this);
	}

	@Override
	protected TCNameSet newCollection()
	{
		return new TCNameSet();
	}

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
