package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;

public class TRPatternList extends TRMappedList<TCPattern, TRPattern> implements TRRecordContext, TRStructuredContext/*, TRUnionContext*/ {
    
    private static final long serialVersionUID = 1L;

	protected TRPatternList() 
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
		// pattern lists are space separated in Isabelle, not commas please. 
		setSemanticSeparator(IsaToken.SPACE.toString());//IsaToken.COMMA.toString());
		setFormattingSeparator(IsaToken.SPACE.toString());
		setInvTranslateSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());
	}

	@Override
	public String toString()
	{
		return super.toString() + " [PL=" + size() + "]";
	}

	protected List<Integer> getRecordPatternIndeces()
	{
		List<Integer> result = new Vector<Integer>(size());
		for(int i = 0; i < size(); i++)
		{
			if (get(i) instanceof TRRecordPattern)
				result.add(i);
		}
		return result;
	}

	protected List<Integer> getStructuredPatternIndeces()
	{
		List<Integer> result = new Vector<Integer>(size());
		for(int i = 0; i < size(); i++)
		{
			if (TRStructuredPattern.validStructuredContext(get(i)))
				result.add(i);
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
	public boolean hasRecordPattern()
	{
		return !getRecordPatternIndeces().isEmpty();
	}

	@Override
	public String recordPatternTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (hasRecordPattern())
		{
			String old = getSemanticSeparator();
			setSemanticSeparator(IsaToken.SEMICOLON.toString() + IsaToken.SPACE.toString());
			sb.append(patternOpenContext());
			List<Integer> recordPatternIndices = getRecordPatternIndeces();
			sb.append(((TRRecordPattern)get(recordPatternIndices.get(0))).recordPatternTranslate(varName));
			for (int i = 1; i < recordPatternIndices.size(); i++)
			{
				sb.append(getSemanticSeparator());
				sb.append(getFormattingSeparator());
				sb.append(((TRRecordPattern)get(recordPatternIndices.get(0))).recordPatternTranslate(varName));
			}
			sb.append(patternCloseContext());
			setSemanticSeparator(old);
		}
		return sb.toString();
	}

	@Override
	public boolean hasStructuredPattern()
	{
		return !getStructuredPatternIndeces().isEmpty();
	}

	@Override
	public String structuredPatternTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (hasStructuredPattern())
		{
			String old = getSemanticSeparator();
			setSemanticSeparator(IsaToken.SEMICOLON.toString() + IsaToken.SPACE.toString());
			sb.append(patternOpenContext());
			List<Integer> structuredPatternIndices = getStructuredPatternIndeces();
			sb.append(((TRStructuredPattern)get(structuredPatternIndices.get(0))).structuredPatternTranslate(varName));
			for (int i = 1; i < structuredPatternIndices.size(); i++)
			{
				sb.append(getSemanticSeparator());
				sb.append(getFormattingSeparator());
				sb.append(((TRStructuredPattern)get(structuredPatternIndices.get(0))).structuredPatternTranslate(varName));
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

	public static String translate(TRPattern... args)
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
	public static TRPatternList newPatternList(TRPattern... args)
	{
		TRPatternList result = new TRPatternList();
		if (args != null)
			result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		return result;	
	}
}
