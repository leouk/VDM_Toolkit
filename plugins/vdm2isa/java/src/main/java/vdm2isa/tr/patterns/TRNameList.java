/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.patterns;

import java.util.Vector;

import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCPatternListList;

public class TRNameList extends Vector<String>
{
	private static final long serialVersionUID = 1L;

	public TRNameList(TCPatternListList list)
	{
		for (TCPattern p: list.get(0))	// Only the first - no curried sets!
		{
			add(p.toString());
		}
	}
}
