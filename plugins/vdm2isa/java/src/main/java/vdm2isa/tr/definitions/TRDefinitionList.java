/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.TRMappedList;

public class TRDefinitionList extends TRMappedList<TCDefinition, TRDefinition>
{
	private static final long serialVersionUID = 1L;

	public String separator;
	
	public TRDefinitionList(TCDefinitionList list) throws Exception
	{
		super(list);
		separator = "\n";
	}

	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).toString());
			for (int i = 1; i < size(); i++)
			{
				sb.append("\n" + get(i).toString());
			}
		}
		return sb.toString();
	}

	public void setLocal(boolean local)
	{
		for (TRDefinition def : this)
		{
			def.local = local;
		}
	}

	public String translate()
	{
		return IsaTemplates.listToString(this, separator);
	}

	public String invTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).invTranslate());
			for (int i = 1; i < size(); i++)
			{
				sb.append(separator);
				sb.append(get(i).invTranslate());
			}
		}
		return sb.toString();
	}
}
