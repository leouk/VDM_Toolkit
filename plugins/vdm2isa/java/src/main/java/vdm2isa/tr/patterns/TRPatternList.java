package vdm2isa.tr.patterns;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRPatternList extends TRMappedList<TCPattern, TRPattern> {
    
	protected String separator; 

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

	public String translate()
	{
		assert separator != null;
		return IsaTemplates.listToString(this, separator);
	}

	public static String translate(TRPattern... args)
	{
		TRPatternList list = new TRPatternList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
