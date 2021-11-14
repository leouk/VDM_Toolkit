/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.expressions.TCRecordModifier;
import com.fujitsu.vdmj.tc.expressions.TCRecordModifierList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

public class TRRecordModifierList extends TRMappedList<TCRecordModifier, TRRecordModifier>
{
	private static final long serialVersionUID = 1L;
	
	protected TRRecordModifierList()
	{
		super();
	}

	public TRRecordModifierList(TRRecordModifierList from)
	{
		this();
		addAll(from);
	}

	public TRRecordModifierList(TCRecordModifierList list) throws Exception
	{
		super(list);
	}

	@Override
	protected void setup()
	{
		super.setup();
		setSemanticSeparator(IsaToken.COMMA.toString() + " ");
	}

	public void setRecordType(TRRecordType recordType)
	{
		for (TRRecordModifier rm : this)
		{
			rm.recordType = recordType;
		}
	}

    /**
	 * Choose the first element type (could have been any); this is to attempt to solve the "(the (pattern))" problem
	 */
	public TRType getType()
	{
		return isEmpty() ? TRExpression.unknownType(getLocation()) : get(0).getType();
	}
}
