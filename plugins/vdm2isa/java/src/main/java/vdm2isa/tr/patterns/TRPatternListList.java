/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.patterns;

import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.tc.patterns.TCPatternList;
import com.fujitsu.vdmj.tc.patterns.TCPatternListList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

/**
 * Pattern lists lists are mostly singleton (e.g. f(x,y) = TRPatternListList[TRPatternList[x,y]]),
 * yet it can have multiple list entries for curried calls (e.g., f(x,y)(z) = TRPatternListList[TRPatternList[x,y],TRPatternList[z]]).
 * Isabelle is mostly always curried, hence flattening of such lists is the norm, yet when needed might keep the structure.  
 */
public class TRPatternListList extends TRMappedList<TCPatternList, TRPatternList>
{
	private static final long serialVersionUID = 1L;

	protected TRPatternListList()
	{
		super();
		setPartOfListList(true);
	}

	public TRPatternListList(TRPatternListList from)
	{
		this();
		addAll(from);
	}

	public TRPatternListList(TCPatternListList from) throws Exception
	{
		super(from);
		setPartOfListList(true);
	}

	@Override
	public String toString()
	{
		return super.toString() + " [PLL=" + size() + "]";
	}

	private void setPartOfListList(boolean b)
	{
		for(TRPatternList p : this)
		{
			p.partOfListList = b;
		}
	}

	public boolean hasRecordPatternParameters()
	{
		boolean result = false;
		for(int i = 0; i < size() && !result; i++)
		{
			result = get(i).hasRecordPatternParameters();
		}
		return result;
	}

	/**
	 * Local context for record patterns is flattened out at list list if exists or added otherwise. 
	 * @return
	 */
	public String recordPatternOpenContext()
	{
		return IsaToken.LET.toString() + " ";
	}

	public String recordPatternCloseContext()
	{
		return " " + IsaToken.IN.toString() + " ";
	}

	public String recordPatternTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			// set the let separator
			String old = setSeparator(IsaToken.SEMICOLON.toString() + " ");
			sb.append(recordPatternOpenContext());
			sb.append(get(0).recordPatternTranslate());
			for (int i = 1; i < size(); i++)
			{
				sb.append(getSeparator());
				sb.append(getFormattingSeparator());
				sb.append(get(i).recordPatternTranslate());
			}
			setSeparator(old);
			sb.append(recordPatternCloseContext());
		}
		return sb.toString();
	}

	//TODO maybe make this a field called once given the structure never changes?
	public TRPatternList getFlatPatternList()
	{
		TRPatternList result = new TRPatternList();
		int concSize = 0;
		if (!isEmpty())
		{
			result.setSeparator(get(0).getSeparator());
			result.setFormattingSeparator(get(0).getFormattingSeparator());
			for (TRPatternList plist : this)
			{
				result.addAll(plist);
				concSize += plist.size();
			}
		}
		assert result.size() == concSize;	
		return result; 
	}

	/**
	 * Pattern list lists can be flatenned to single list result given Isabelle mostly always prefers curried calls
	 * Situations (yet to be observed) might occur which requires knowledge about the VDM currying structure, in which
	 * case this method ought to return List<List<String>>. For now, will flatten it out. See also TRPatternList.varNameTranslate.  
	 */
	public List<String> flatVarNameTranslate()
	{
		return getFlatPatternList().varNameTranslate();
	}

	public List<List<String>> varNameTranslate()
	{
		List<List<String>> result = new Vector<List<String>>(size());
		for(TRPatternList plist : this)
		{
			result.add(plist.varNameTranslate());
		}
		return result;
	}

	public TRPatternListList copy()
	{
		// this one don't create from this list as we want deep copy please
		TRPatternListList result = new TRPatternListList();
		for(TRPatternList p : this)
		{
			result.add(p.copy());
		}
		return result; 
	}

}
