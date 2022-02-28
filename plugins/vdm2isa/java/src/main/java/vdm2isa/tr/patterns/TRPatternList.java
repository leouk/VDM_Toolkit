package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;

public class TRPatternList extends TRMappedList<TCPattern, TRPattern> implements TRPatternContext/*, TRUnionContext*/ {
    
    private static final long serialVersionUID = 1L;

	private boolean dummyFreshness;

	//Patterns might be changed/massaged, so recreated every time
	//private TCNameList namesInPattern = null;

	public TRPatternList() 
	{
		super();
	}  

	public TRPatternList(TRPatternList from)
	{
		this();
		addAll(from);
	}

	public TRPatternList(TCPatternList list) throws Exception
	{
		super(list);
	}

	@Override
	public void setup()
	{
		super.setup();
		dummyFreshness = false;
		// pattern lists are space separated in Isabelle, not commas please. 
		setSemanticSeparator(IsaToken.SPACE.toString());//IsaToken.COMMA.toString());
		setFormattingSeparator(IsaToken.SPACE.toString());
		setInvTranslateSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());

		if (hasMultipleNonBasicPatterns())
		{
			report(IsaErrorMessage.ISA_INVALID_VDM_PATTERN_1P, this.toString());
		}
	}

	protected boolean hasMultipleNonBasicPatterns()
	{
		int result = 0;
		// count number of non basic patterns
		for(int i = 0; i < size() && result <= 1; i++)
		{
			result += get(i) instanceof TRAbstractContextualPattern ? 1 : 0;
		}
		// return result
		return result > 1;
	}

	@Override
	public String toString()
	{
		return super.toString() + " [PL=" + size() + "]";
	}

	public TCPatternList getVDMPatternList()
	{
		TCPatternList result = new TCPatternList();
		for(TRPattern p : this)
		{
			result.add(p.getVDMPattern());
		}
		return result;
	}

	public TCNameList getNamesInPatternList()
    {
		TCNameList nlist = new TCNameList();
		for(TRPattern p : this)
		{
			nlist.addAll(p.getNamesInPattern());
		}
        return nlist;
    }

	public boolean getDummyFreshness()
	{
		return dummyFreshness;
	}

	public boolean setDummyFreshness(boolean requiresFreshness, boolean deep)
	{
		boolean result = getDummyFreshness();
		dummyFreshness = requiresFreshness;
		if (deep)
		{
			for (TRPattern n : this)
			{
				n.setDummyFreshness(requiresFreshness);
			}
		}
		return result;
	}

	public boolean uniqueNames()
	{
		TCNameList names = getNamesInPatternList();
		TCNameSet nset = new TCNameSet();
		nset.addAll(names);
		return names.size() == nset.size();		
	}

	protected List<Integer> getPatternContextIndeces()
	{
		List<Integer> result = new Vector<Integer>(size());
		for(int i = 0; i < size(); i++)
		{
			TRPattern p = get(i);
			if (p.needsPatternContext())
			{
				result.add(i);
			}
		}
		return result;
	}

	/**
	 * Local context for record patterns is flattened out at list list if exists or added otherwise. 
	 * @return
	 */
	protected String patternOpenContext()
	{
		//TODO mixed contexts! 
		return //partOfListList ? "" : " " + 
			IsaToken.LET.toString() + " "
			;
	}

	protected String patternCloseContext()
	{
		return //partOfListList ? "" : " " + 
			" " + IsaToken.IN.toString() + " "
			;
	}

	@Override
	public boolean needsPatternContext()
	{
		return !getPatternContextIndeces().isEmpty();
	}

	@Override
	public String patternContextTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (needsPatternContext())
		{
			String old = getSemanticSeparator();
			setSemanticSeparator(IsaToken.SEMICOLON.toString() + IsaToken.SPACE.toString());
			sb.append(patternOpenContext());
			List<Integer> patternContextIndices = getPatternContextIndeces();
			sb.append(get(patternContextIndices.get(0)).patternContextTranslate(varName));
			for (int i = 1; i < patternContextIndices.size(); i++)
			{
				sb.append(getSemanticSeparator());
				sb.append(getFormattingSeparator());
				sb.append(get(patternContextIndices.get(0)).patternContextTranslate(varName));
			}
			sb.append(patternCloseContext());
			setSemanticSeparator(old);
		}
		return sb.toString();
	}

	/**
	 * Pattern lists can be translated (i.e. all one string with chosen separator) or 
	 * can be varName translated (i.e. each translation structurally separated). The 
	 * former occurs for function calls etc, whereas the latter occurs for implicit 
	 * invTranslate or compTranslate, which requires the variable/pattern name at different
	 * times/places, hence the result as a list of strings rather than the combined (+separators) string. 
	 * @return the result of translate calls for each TRPattern in the list
	 */
	public List<String> varNameTranslate()
	{
		List<String> result;
		if (!isEmpty())
		{
			result = new Vector<String>(size());
			for (TRPattern p : this)
			{
				result.add(p.translate());
			}
		}
		else
			result = Collections.emptyList();
		assert result.size() == this.size();	
		return result; 
	}

	public TRPatternList copy()
	{
		return new TRPatternList(this); 
	}

	public static final String translate(TRPattern... args)
	{
		TRPatternList result = new TRPatternList();
		result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		return result.translate();	
	}

	/**
	 * Allow for null parameters to allow for empty patterns in TRExpression.getPatternListList? 
	 * @param args
	 * @return
	 */
	public static final TRPatternList newPatternList(TRPattern... args)
	{
		TRPatternList result = new TRPatternList();
		if (args != null)
			result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		return result;	
	}
}
