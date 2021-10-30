package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

import com.fujitsu.vdmj.tc.patterns.TCMapletPattern;
import com.fujitsu.vdmj.tc.patterns.TCMapletPatternList;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRPatternList extends TRMappedList<TCPattern, TRPattern> {
    
    private static final long serialVersionUID = 1L;

	protected TRPatternList() 
	{
		super();
		separator = IsaToken.COMMA.toString();
	}  

	public TRPatternList(TCPatternList list) throws Exception
	{
		super(list);
		separator = IsaToken.COMMA.toString();
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

	public static String translate(TRPattern... args)
	{
		TRPatternList list = new TRPatternList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
