/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import java.util.Arrays;
import java.util.List;

import com.fujitsu.vdmj.tc.expressions.TCMapletExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapletExpressionList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRType;

public class TRMapletExpressionList extends TRMappedList<TCMapletExpression, TRMapletExpression>
{
	private static final long serialVersionUID = 1L;
	
	protected TRMapletExpressionList()
	{
		super();
	}

	public TRMapletExpressionList(/*TRMapletExpressionList*/List<TRMapletExpression> from)
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
			TRMapType.newMapType(TRExpression.unknownType(getLocation()), TRExpression.unknownType(getLocation()), false)
			: 
			get(0).getType();
	}

	public final TCMapletExpressionList getVDMMapletExpressionList()
	{
		TCMapletExpressionList result = new TCMapletExpressionList();
		for(TRMapletExpression m : this)
		{
			result.add(m.maplet);
		}
		return result;
	}

	public static final TRMapletExpressionList newMapletExpressionList(TRMapletExpression... args)
	{
		TRMapletExpressionList result = new TRMapletExpressionList();
		if (args != null)
			result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		return result;
	}
}
