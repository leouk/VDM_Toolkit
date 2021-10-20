/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCMapletExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapletExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCRecordModifier;
import com.fujitsu.vdmj.tc.expressions.TCRecordModifierList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRRecordModifierList extends TRMappedList<TCRecordModifier, TRRecordModifier>
{
	private static final long serialVersionUID = 1L;
	
	protected final String separator; 

	public TRRecordModifierList()
	{
		super();
		separator = IsaToken.COMMA.toString();
	}

	public TRRecordModifierList(TCRecordModifierList list) throws Exception
	{
		super(list);
		separator = IsaToken.COMMA.toString();
	}

	public String translate()
	{
		assert separator != null;
		return IsaTemplates.listToString(this, separator);
	}
}
