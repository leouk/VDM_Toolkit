package vdm2isa.tr.expressions;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.expressions.TCElseIfExpression;
import com.fujitsu.vdmj.tc.expressions.TCElseIfExpressionList;

import vdm2isa.tr.TRMappedList;
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
    protected void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t");
    }

	public static String translate(TRElseIfExpression... args)
	{
		TRElseIfExpressionList list = new TRElseIfExpressionList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
