package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCPatternListTypePair;
import com.fujitsu.vdmj.tc.types.TCPatternListTypePairList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.patterns.TRPatternList;
import vdm2isa.tr.patterns.TRPatternListList;

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

    /**
     * Transforms a TRPattenrListTypePairList into a TRPatternListList
     * @return
     */
    public TRPatternListList getParamPatternListList()
    {
        TRPatternListList result = new TRPatternListList();
        TRPatternList patterns = new TRPatternList();
        for(TRPatternListTypePair pair : this)
        {
            // do I need to copy? likely not
            patterns.addAll(pair.getPatternsList());//.copy());
        }
        result.add(patterns);
        TRNode.setup(result);
        // no currying
        assert result.size() == 1;
        return result;
    }
}
