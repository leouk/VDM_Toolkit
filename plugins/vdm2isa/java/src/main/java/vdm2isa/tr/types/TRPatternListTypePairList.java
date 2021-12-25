package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCPatternListTypePair;
import com.fujitsu.vdmj.tc.types.TCPatternListTypePairList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRPatternListTypePairList extends TRMappedList<TCPatternListTypePair, TRPatternListTypePair> 
{
    public TRPatternListTypePairList()
    {
        super();
    }

    public TRPatternListTypePairList(TCPatternListTypePairList from) throws Exception
    {
        super(from);
    }

    public TRPatternListTypePairList(TRPatternListTypePairList from)
    {
        this();
        addAll(from);
    }

    @Override
	public void setup()
	{
		super.setup();
		setFormattingSeparator(IsaToken.SPACE.toString());
	}
}
