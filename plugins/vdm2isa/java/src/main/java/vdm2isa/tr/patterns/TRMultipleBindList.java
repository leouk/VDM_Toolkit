package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;

import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.tc.patterns.TCMultipleBind;
import com.fujitsu.vdmj.tc.patterns.TCMultipleBindList;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRMappedList;

public class TRMultipleBindList extends TRMappedList<TCMultipleBind, TRMultipleBind>
{
    private static final long serialVersionUID = 1L;

	private Map<TRMultipleBindKind, SortedSet<Integer>> bindSpread = null;
	private boolean parenthesise;
    
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
		setParenthesise(true);
		// multiple type binds are space (not comma) separated
        setSemanticSeparator(" ");
        setFormattingSeparator(" ");
		//Multiple bind list translation must take into consideration the kind of bind within it; for type binds that involves adding inv_T dummy; others just empty
        setInvTranslateSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());
	}

	public boolean getParenthesise()
	{
		return parenthesise;
	}

    public boolean setParenthesise(boolean p) {
		boolean old = p;
		this.parenthesise = p;
		for(TRMultipleBind b : this)
		{
			b.setParenthesise(p);
		}
		return old;
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
	 * Returns a map of how many binds in the list have what kind where range contains the indexes of what kind 
	 * @return
	 */
	public Map<TRMultipleBindKind, SortedSet<Integer>> figureBindsOut()
	{
		if (bindSpread == null)
		{
			bindSpread = new HashMap<TRMultipleBindKind, SortedSet<Integer>>();
			// add the zero values as well so that other checks count them up
			bindSpread.put(TRMultipleBindKind.SET, new TreeSet<Integer>());
			bindSpread.put(TRMultipleBindKind.SEQ, new TreeSet<Integer>());
			bindSpread.put(TRMultipleBindKind.TYPE, new TreeSet<Integer>());
			for(int i = 0; i < size(); i++)
			{
				TRMultipleBind b = get(i);
				if (b instanceof TRMultipleSetBind)
					bindSpread.get(TRMultipleBindKind.SET).add(i);
				else if (b instanceof TRMultipleSeqBind)
					bindSpread.get(TRMultipleBindKind.SEQ).add(i);
				else if (b instanceof TRMultipleTypeBind)
					bindSpread.get(TRMultipleBindKind.TYPE).add(i);
				else 
					throw new InternalException(IsaErrorMessage.PLUGIN_NYI_2P.number, "Invalid type bind kind " + b.getClass().getSimpleName());
			}
			assert size() == bindSpread.get(TRMultipleBindKind.SET).size() + 
							 bindSpread.get(TRMultipleBindKind.SEQ).size() + 
							 bindSpread.get(TRMultipleBindKind.TYPE).size();
		}	
		// everyone is accounted for, including zero cases
		assert bindSpread != null && !bindSpread.isEmpty() && 
			   bindSpread.containsKey(TRMultipleBindKind.SET) && 
			   bindSpread.containsKey(TRMultipleBindKind.SEQ) && 
			   bindSpread.containsKey(TRMultipleBindKind.TYPE);
		return Collections.unmodifiableMap(bindSpread);
	}

	/**
	 * Checks whether there are binds of the given kind in the list
	 * @param kind
	 * @return
	 */	
    public boolean foundBinds(TRMultipleBindKind kind) {
		return !figureBindsOut().get(kind).isEmpty();
    }

	public boolean areBindsUniform(TRMultipleBindKind kind) {
		return figureBindsOut().get(kind).size() == size();
	}

	/**
	 * Checks whether all binds are of the same kind in the list 
	 * @param kind
	 * @return
	 */	
	public boolean areBindsUniform() {
		return areBindsUniform(TRMultipleBindKind.SET) || areBindsUniform(TRMultipleBindKind.SEQ) || areBindsUniform(TRMultipleBindKind.TYPE);   
    }

	public boolean hasRecordPatterns() {
		boolean result = false;
		for(int i = 0; i < size() && !result; i++)
		{
			result = get(i).hasRecordPatterns();
		}
		return result;
	}

    public String recordPatternTranslate() {
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			String recTranslate = get(0).recordPatternTranslate();
			sb.append(recTranslate);
			for(int i = 1; i < size(); i++)
			{
				if (!recTranslate.isEmpty())
				{
					// no need for semantic separator since the PatternList keeps all the context in control up to "in" part
					//sb.append(getSemanticSeparator());
					sb.append(getFormattingSeparator());					
				}
				recTranslate = get(i).recordPatternTranslate();
				sb.append(recTranslate);
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
