/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRTypeList extends TRMappedList<TCType, TRType>
{
	private static final long serialVersionUID = 1L;
	
	protected TRTypeList()
	{
		super();
		setCurried(false);
	}

	public TRTypeList(TCTypeList list) throws Exception
	{
		super(list);
		setCurried(false);
	}

	public void setCurried(boolean curried) 
	{
		separator = curried ? IsaToken.FUN.toString() : IsaToken.CROSSPROD.toString();	
	}

	public String invTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append("(");

			sb.append(get(0).invTranslate(varName));

			for (int i=1; i<size(); i++)
			{
				sb.append(IsaToken.AND.toString());
				sb.append("\n\t\t");
				sb.append(get(i).invTranslate(varName));
			}
			sb.append(")");
		}
		return sb.toString();	
	}

	public static String translate(TRType... args)
	{
		TRTypeList list = new TRTypeList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}

	public static String invTranslate(String varName, TRType... args)
	{
		TRTypeList list = new TRTypeList();
		list.addAll(Arrays.asList(args));
		return list.invTranslate(varName);	
	}
}
