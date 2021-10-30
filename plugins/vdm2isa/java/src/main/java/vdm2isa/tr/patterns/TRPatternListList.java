/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.patterns;

import java.util.Collections;
import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.tc.patterns.TCPatternList;
import com.fujitsu.vdmj.tc.patterns.TCPatternListList;

import vdm2isa.tr.TRMappedList;

/**
 * Pattern lists lists are mostly singleton (e.g. f(x,y) = TRPatternListList[TRPatternList[x,y]]),
 * yet it can have multiple list entries for curried calls (e.g., f(x,y)(z) = TRPatternListList[TRPatternList[x,y],TRPatternList[z]]).
 * Isabelle is mostly always curried, hence flattening of such lists is the norm, yet when needed might keep the structure.  
 */
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

	/**
	 * Pattern list lists can be flatenned to single list result given Isabelle mostly always prefers curried calls
	 * Situations (yet to be observed) might occur which requires knowledge about the VDM currying structure, in which
	 * case this method ought to return List<List<String>>. For now, will flatten it out. See also TRPatternList.varNameTranslate.  
	 */
	public List<String> varNameTranslate()
	{
		List<String> result;
		int concSize = 0;
		if (!isEmpty())
		{
			result = new Vector<String>();
			for (TRPatternList plist : this)
			{
				result.addAll(plist.varNameTranslate());
				concSize += plist.size();
			}
		}
		else
			result = Collections.emptyList();
		assert result.size() == concSize;	
		return result; 
	}
}
