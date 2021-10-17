/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRTypeList extends TRMappedList<TCType, TRType>
{
	private static final long serialVersionUID = 1L;
	
	private boolean curried;
	private String separator;

	public TRTypeList(TCTypeList list) throws Exception
	{
		super(list);
		setCurried(true);
		assert separator != null;
	}

	public boolean getCurried() 
	{
		return curried;
	}

	public void setCurried(boolean b) 
	{
		curried = b;
		setSeparator(curried ? IsaToken.FUN.toString() : IsaToken.CROSSPROD.toString());
	}

	protected void setSeparator(String s) 
	{
		assert s != null;
		separator = s;
	}

	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		int l = size();
		//@todo have a look at https://reversecoding.net/java-8-convert-list-string-comma/
		//java.util.List<TRType> list = this;
		//list.stream().map().collect(Collectors.joining(separator));
 		for(TRType type : this)
		{
			l = l - 1;
			sb.append(type.translate());
			if (l > 0) sb.append(separator);
		}
 		return sb.toString();
	}
}
