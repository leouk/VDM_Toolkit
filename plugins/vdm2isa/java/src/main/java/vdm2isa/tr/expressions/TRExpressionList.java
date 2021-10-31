/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRExpressionList extends TRMappedList<TCExpression, TRExpression>
{
	private static final long serialVersionUID = 1L;
	
	protected TRExpressionList() 
	{
		super();
		setSeparator(IsaToken.COMMA.toString());
		setFormattingSeparator(" ");
	}  

	public TRExpressionList(TRExpressionList from)
	{
		this();
		addAll(from);
	}

	public TRExpressionList(TCExpressionList from) throws Exception
	{
		super(from);
		setSeparator(IsaToken.COMMA.toString());
		setFormattingSeparator(" ");
	}

	public static String translate(TRExpression... args)
	{
		TRExpressionList list = new TRExpressionList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
