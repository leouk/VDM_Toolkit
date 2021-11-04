package vdm2isa.tr.patterns;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.patterns.TCMultipleBind;
import com.fujitsu.vdmj.tc.patterns.TCMultipleBindList;

import vdm2isa.lex.IsaToken;
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
		// multiple type binds are space (not comma) separated
        setSemanticSeparator(" ");
        setFormattingSeparator(" ");
		//Multiple bind list translation must take into consideration the kind of bind within it; for type binds that involves adding inv_T dummy; others just empty
        setInvTranslateSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());
	}

    public String compTranslate(boolean vdmPatternsOnly)
    {
        StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).compTranslate(vdmPatternsOnly));

			for (int i=1; i<size(); i++)
			{
				sb.append(getSemanticSeparator());
				sb.append(getFormattingSeparator());
				sb.append(get(i).compTranslate(vdmPatternsOnly));
			}
		}
		return sb.toString();
    } 

	/**
     * If any bind is not type bind, requires multiple quantifiers and parenthesis 
     * @return true whether set/seq binds were found within this bind list
     */
	public boolean foundNonTypeBinds() {
        for(TRMultipleBind b : this)
        {
            if (!(b instanceof TRMultipleTypeBind))
                return true;
        }
        return false;
    }
	
	/**
	 * If any type bind has been found within this bind list 
	 * @return
	 */
    public boolean foundSomeTypeBinds() {
        for(TRMultipleBind b : this)
        {
            if (b instanceof TRMultipleTypeBind)
                return true;
        }
        return false;
    }

	public static String translate(TRMultipleBind... args)
	{
		TRMultipleBindList list = new TRMultipleBindList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}
}
