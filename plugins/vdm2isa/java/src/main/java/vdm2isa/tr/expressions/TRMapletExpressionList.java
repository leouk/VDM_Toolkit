/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCMapletExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapletExpressionList;
import com.fujitsu.vdmj.tc.types.TCMapType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRType;

public class TRMapletExpressionList extends TRMappedList<TCMapletExpression, TRMapletExpression>
{
	private static final long serialVersionUID = 1L;
	
	protected TRMapletExpressionList()
	{
		super();
	}

	public TRMapletExpressionList(TRMapletExpressionList from)
	{
		this();
		addAll(from);
	}

	public TRMapletExpressionList(TCMapletExpressionList list) throws Exception
	{
		super(list);
	}

	@Override
	public void setup()
	{
		super.setup();
		setSemanticSeparator(IsaToken.COMMA.toString());
	}

	/**
	 * Choose the first element type (could have been any); this is to attempt to solve the "(the (pattern))" problem
	 */
	public TRType getType()
	{
		return isEmpty() ? 
			new TRMapType(new TCMapType(getLocation()), new TRDefinitionList(), 
				TRExpression.unknownType(getLocation()), 
				TRExpression.unknownType(getLocation()), false) 
			: 
			get(0).getType();
	}
}
