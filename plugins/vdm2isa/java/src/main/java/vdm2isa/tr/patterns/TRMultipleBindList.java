package vdm2isa.tr.patterns;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.patterns.TCMultipleBind;
import com.fujitsu.vdmj.tc.patterns.TCMultipleBindList;

import vdm2isa.tr.TRMappedList;

public class TRMultipleBindList extends TRMappedList<TCMultipleBind, TRMultipleBind>
{
    private static final long serialVersionUID = 1L;
    
    public TRMultipleBindList()
    {
        super();
    }    

	public TRMultipleBindList(TRMultipleBindList from)  
	{
		this();
		addAll(from);
	}

    public TRMultipleBindList(TCMultipleBind bind) throws Exception
    {
        this(bind.getMultipleBindList()); 
    }

    public TRMultipleBindList(TCMultipleBindList from) throws Exception
	{
		super(from);
	}

	@Override
	protected void setup()
	{
		super.setup();
		setSemanticSeparator(" ");
	}

	/**
	 * Multiple bind list translation must take into consideration the kind of bind within it. For type binds
	 */
	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).translate());
			for (int i = 1; i < size(); i++)
			{
				sb.append(getSemanticSeparator());
                sb.append(getFormattingSeparator());
				sb.append(get(i).translate());
			}
		}
		return sb.toString();
	}

    public String compTranslate(boolean patternsOnly)
    {
        StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).compTranslate(patternsOnly));

			for (int i=1; i<size(); i++)
			{
				sb.append(getSemanticSeparator());
				sb.append(getFormattingSeparator());
				sb.append(get(i).compTranslate(patternsOnly));
			}
		}
		return sb.toString();
    } 

	public static String translate(TRMultipleBind... args)
	{
		TRMultipleBindList list = new TRMultipleBindList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
