/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.tc.patterns.TCPatternList;
import com.fujitsu.vdmj.tc.patterns.TCPatternListList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;

/**
 * Pattern lists lists are mostly singleton (e.g. f(x,y) = TRPatternListList[TRPatternList[x,y]]),
 * yet it can have multiple list entries for curried calls (e.g., f(x,y)(z) = TRPatternListList[TRPatternList[x,y],TRPatternList[z]]).
 * Isabelle is mostly always curried, hence flattening of such lists is the norm, yet when needed might keep the structure.  
 */
public class TRPatternListList extends TRMappedList<TCPatternList, TRPatternList> implements TRPatternContext/*, TRUnionContext*/
{
	private static final long serialVersionUID = 1L;

	protected TRPatternListList()
	{
		super();
	}

	public TRPatternListList(TRPatternListList from)
	{
		this();
		addAll(from);
	}

	public TRPatternListList(TCPatternListList from) throws Exception
	{
		super(from);
	}

	@Override
	public String toString()
	{
		return super.toString() + " [PLL=" + size() + "]";
	}

	@Override
	public boolean needsPatternContext()
	{
		boolean result = false;
		for(int i = 0; i < size() && !result; i++)
		{
			result = get(i).needsPatternContext();
		}
		return result;
	}

	@Override
	public String patternContextTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			// set the let separator
			String old = setSemanticSeparator(IsaToken.SEMICOLON.toString() + " ");
			String recTranslate = get(0).patternContextTranslate(varName); 
			sb.append(recTranslate);
			for (int i = 1; i < size(); i++)
			{
				if (!recTranslate.isEmpty())
				{
					sb.append(getSemanticSeparator());
					sb.append(getFormattingSeparator());
				}
				recTranslate = get(i).patternContextTranslate(varName);
				sb.append(recTranslate);
			}
			setSemanticSeparator(old);
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
			result.setSemanticSeparator(get(0).getSemanticSeparator());
			result.setFormattingSeparator(get(0).getFormattingSeparator());
			for (TRPatternList plist : this)
			{
				result.addAll(plist);
				concSize += plist.size();
			}
		}
		assert result.size() == concSize;	
		TRNode.setup(result);
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
		TRNode.setup(result);
		return result; 
	}

	public static TRPatternListList newPatternListList(TRPatternList... args)
	{
		TRPatternListList result = new TRPatternListList();
		if (args != null)
			result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		return result;	
	}

	public static TRPatternListList newPatternListList(TRPattern... args)
	{
		return TRPatternListList.newPatternListList(TRPatternList.newPatternList(args));	
	}
}
