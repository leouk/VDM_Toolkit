package vdm2isa.tr.expressions;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.expressions.TCCaseAlternative;
import com.fujitsu.vdmj.tc.expressions.TCCaseAlternativeList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.types.TRTypeSet;

public class TRCaseAlternativeList extends TRMappedList<TCCaseAlternative, TRCaseAlternative> {
	private static final long serialVersionUID = 1L;
    
    private boolean casesTrueAlternative;

    protected TRCaseAlternativeList()
    {
        super();
        casesTrueAlternative = false;
    }

    public TRCaseAlternativeList(TRCaseAlternativeList from)
	{
		this();
		addAll(from);
	}

    public TRCaseAlternativeList(TCCaseAlternativeList from) throws Exception
    {
        super(from);
        casesTrueAlternative = false;
    }

    @Override
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t\t ");
        setSemanticSeparator(IsaToken.SPACE.toString() + IsaToken.BAR.toString() + IsaToken.SPACE.toString());
    }

    protected boolean setCasesTrueAlternative(boolean b)
    {
        boolean result = casesTrueAlternative; 
        casesTrueAlternative = b;
        for(TRCaseAlternative c : this)
        {
            c.setCasesTrueAlternative(b);
        }
        setSemanticSeparator(IsaToken.SPACE.toString() + (b ? IsaToken.AND.toString() : IsaToken.BAR.toString()) + IsaToken.SPACE.toString());
        return result;
    }

    /**
	 * Choose the first element type (could have been any); this is to attempt to solve the "(the (pattern))" problem
	 */
	public TRTypeSet getTypes()
	{
        TRTypeSet result = new TRTypeSet();
        for (TRCaseAlternative c : this)
        {
            result.add(c.getType());
        }
        TRNode.setup(result);
		return result;
	}

	public static final String translate(TRCaseAlternative... args)
	{
		TRCaseAlternativeList result = new TRCaseAlternativeList();
        result.addAll(Arrays.asList(args));
        TRNode.setup(result);
		return result.translate();	
	}
}
