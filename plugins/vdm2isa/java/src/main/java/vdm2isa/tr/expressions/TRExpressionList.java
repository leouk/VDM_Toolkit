/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.types.TRTypeList;

public class TRExpressionList extends TRMappedList<TCExpression, TRExpression>
{
	private static final long serialVersionUID = 1L;
	
	protected TRExpressionList() 
	{
		super();
	}  

	public TRExpressionList(TRExpressionList from)
	{
		this();
		addAll(from);
	}

	public TRExpressionList(TCExpressionList from) throws Exception
	{
		super(from);
	}

	/**
	 * Choose the first element type (could have been any); this is to attempt to solve the "(the (pattern))" problem
	 */
    public TRTypeList getTypeList() {
		return TRTypeList.newTypeList(this);
    }

	@Override 
	public void setup()
	{
		super.setup();
		//setSemanticSeparator(IsaToken.COMMA.toString());
		setFormattingSeparator(IsaToken.SPACE.toString());
	}

	public static String translate(TRExpression... args)
	{
		TRExpressionList result = new TRExpressionList();
		if (args != null)
			result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		return result.translate();	
	}

}
