/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.patterns;

import java.util.Vector;

import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;
import com.fujitsu.vdmj.tc.patterns.TCPatternListList;

import vdm2isa.tr.TRMappedList;

public class TRPatternListList extends TRMappedList<TCPatternList, TRPatternList>
{
	private static final long serialVersionUID = 1L;

	public TRPatternListList()
	{
		super();
	}

	public TRPatternListList(TCPatternListList from) throws Exception
	{
		super(from);
		//NB why this here? Think because of simpler stuff for v2c? 
		//for (TCPattern p: list.get(0))	// Only the first - no curried sets!
		//{
		//	add(p.toString());
		//}
	}

	public String setSeparator(String sep)
	{
		String result = separator;
		separator = sep;
		for (TRPatternList p : this)
		{
			p.separator = sep;
		}
		return result;
	}
}
