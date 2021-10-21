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
	
	private boolean curried;

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

	public boolean getCurried() 
	{
		return curried;
	}

	public void setCurried(boolean b) 
	{
		curried = b;
	}

	public String separator()
	{
		return curried ? IsaToken.FUN.toString() : IsaToken.CROSSPROD.toString();
	}

	public String translate()
	{
		return IsaTemplates.listToString(this, separator());
	}

	public static String translate(TRType... args)
	{
		TRTypeList list = new TRTypeList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
