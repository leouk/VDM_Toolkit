package vdm2isa.tr.patterns;

import java.util.Arrays;

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

	public static String translate(TRPattern... args)
	{
		TRPatternList list = new TRPatternList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
