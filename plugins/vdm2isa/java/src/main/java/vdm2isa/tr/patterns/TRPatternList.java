package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRPatternList extends TRMappedList<TCPattern, TRPattern> {
    
    private static final long serialVersionUID = 1L;

	private final List<Integer> recordPatternIndices;
	protected boolean partOfListList;

	protected TRPatternList() 
	{
		super();
		partOfListList = false;
		recordPatternIndices = getRecordPatternIndeces();
	}  

	public TRPatternList(TRPatternList from)
	{
		this();
		addAll(from);
	}

	public TRPatternList(TCPatternList list) throws Exception
	{
		super(list);
		partOfListList = false; 
		recordPatternIndices = getRecordPatternIndeces();
	}

	@Override
	protected void setup()
	{
		super.setup();
		// pattern lists are space separated in Isabelle, not commas please. 
		setSemanticSeparator(" ");//IsaToken.COMMA.toString());
		setFormattingSeparator(" ");
		setInvTranslateSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());
	}

	@Override
	public String toString()
	{
		return super.toString() + " [PL=" + size() + "]";
	}

	private List<Integer> getRecordPatternIndeces()
	{
		List<Integer> result = new Vector<Integer>(size());
		for(int i = 0; i < size(); i++)
		{
			if (get(i) instanceof TRRecordPattern)
				result.add(i);
		}
		return result;
	}

	public boolean hasRecordPatternParameters()
	{
		return !recordPatternIndices.isEmpty();
	}

	/**
	 * Local context for record patterns is flattened out at list list if exists or added otherwise. 
	 * @return
	 */
	public String recordPatternOpenContext()
	{
		return partOfListList ? "" : IsaToken.LET.toString() + " ";
	}

	public String recordPatternCloseContext()
	{
		return partOfListList ? "" : " " + IsaToken.IN.toString() + " ";
	}

	public String recordPatternTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (hasRecordPatternParameters())
		{
			sb.append(recordPatternOpenContext());
			sb.append(((TRRecordPattern)get(recordPatternIndices.get(0))).recordPatternTranslate());
			for (int i = 1; i < recordPatternIndices.size(); i++)
			{
				sb.append(getSemanticSeparator());
				sb.append(getFormattingSeparator());
				sb.append(((TRRecordPattern)get(recordPatternIndices.get(0))).recordPatternTranslate());
			}
			sb.append(recordPatternCloseContext());
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
		TRPatternList list = new TRPatternList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
