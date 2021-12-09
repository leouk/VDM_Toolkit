package vdm2isa.tr.expressions;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.expressions.TCElseIfExpression;
import com.fujitsu.vdmj.tc.expressions.TCElseIfExpressionList;

import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.types.TRType;

public class TRElseIfExpressionList extends TRMappedList<TCElseIfExpression, TRElseIfExpression>{
    
    protected TRElseIfExpressionList()
    {
        super();
    }

    public TRElseIfExpressionList(TRElseIfExpressionList from)
	{
		this();
		addAll(from);
	}

    public TRElseIfExpressionList(TCElseIfExpressionList from) throws Exception
    {
        super(from);
    }

    /**
	 * Choose the first element type (could have been any); this is to attempt to solve the "(the (pattern))" problem
	 */
	public TRType getType()
	{
		return isEmpty() ? TRExpression.unknownType(getLocation()) : get(0).getType();
	}

    @Override
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t");
    }

    public TCElseIfExpressionList getVDMElseIfExpressionList()
    {
        TCElseIfExpressionList result = new TCElseIfExpressionList();
        for(TRElseIfExpression eif : this)
        {
            result.add(eif.getVDMElseIfExpression());
        }
        return result;
    }

	public static final String translate(TRElseIfExpression... args)
	{
		return TRElseIfExpressionList.newElseIfExpressionList(args).translate();	
	}

    public static final TRElseIfExpressionList newElseIfExpressionList(TRElseIfExpression... args)
    {
        TRElseIfExpressionList result = new TRElseIfExpressionList();
        if (args != null)
    		result.addAll(Arrays.asList(args));
        TRNode.setup(result);
        return result;
    }
}
