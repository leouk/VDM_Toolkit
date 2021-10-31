/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCRecordModifier;
import com.fujitsu.vdmj.tc.expressions.TCRecordModifierList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRRecordModifierList extends TRMappedList<TCRecordModifier, TRRecordModifier>
{
	private static final long serialVersionUID = 1L;
	
	public TRRecordModifierList()
	{
		super();
		setSeparator(IsaToken.COMMA.toString() + " ");
	}

	public TRRecordModifierList(TCRecordModifierList list) throws Exception
	{
		super(list);
		setSeparator(IsaToken.COMMA.toString() + " ");
	}

	public void setRecordTypeName(String recordTypeName)
	{
		for (TRRecordModifier rm : this)
		{
			rm.recordTypeName = recordTypeName;
		}
	}
}
