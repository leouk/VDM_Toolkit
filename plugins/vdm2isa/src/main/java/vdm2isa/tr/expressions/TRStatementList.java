package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.tc.statements.TCStatementList;

import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;

public class TRStatementList extends TRMappedList<TCStatement, TRStatement> {
    
    private int currentUnionContext;

	/**
	 * Allow this top-level list to be defined empty
	 */
	public TRStatementList()
	{
		super();
		currentUnionContext = 0;
	}

    public TRStatementList(TRStatementList from)
	{
		this();
		addAll(from);
	}	

    public TRStatementList(TCStatementList list) throws Exception
	{
		super(list);
	}

    public TRStatementList copy()
	{
		TRStatementList result = new TRStatementList(this); 
		TRNode.setup(result);
		return result;
	}

    @Override
	public void setup()
	{
		super.setup();
		setFormattingSeparator("\n\t");
	}

	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(translateElement(0));
			for (int i = 1; i < size(); i++)
			{
				sb.append(getFormattingSeparator());
				sb.append(getSemanticSeparator());
                sb.append(getFormattingSeparator());
				sb.append(translateElement(i));
			}
			sb.append(getFormattingSeparator());
			sb.append(getSemanticSeparator());
			sb.append(getFormattingSeparator());
			sb.append("dummy0"); // Relying on state being the first dummy0
		}
		return sb.toString();
	}

}
