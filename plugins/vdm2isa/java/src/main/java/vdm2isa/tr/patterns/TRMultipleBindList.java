package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;

import com.fujitsu.vdmj.ast.lex.LexKeywordToken;
import com.fujitsu.vdmj.lex.Token;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.patterns.TCMultipleBind;
import com.fujitsu.vdmj.tc.patterns.TCMultipleBindList;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRDefinitionSet;
import vdm2isa.tr.expressions.TRBinaryExpression;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRLiteralExpression;
import vdm2isa.tr.expressions.TRVariableExpression;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRUnknownType;

public class TRMultipleBindList extends TRMappedList<TCMultipleBind, TRMultipleBind> implements TRPatternContext
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
		this(bind != null ? bind.getMultipleBindList() : new TCMultipleBindList()); 
    }

    public TRMultipleBindList(TCMultipleBindList from) throws Exception
	{
		super(from);
	}

	@Override
	public void setup()
	{
		super.setup();
		setParenthesise(true);
		// multiple type binds are space (not comma) separated
        setSemanticSeparator(IsaToken.SPACE.toString());
        setFormattingSeparator(IsaToken.SPACE.toString());
		//Multiple bind list translation must take into consideration the kind of bind within it; for type binds that involves adding inv_T dummy; others just empty
        setInvTranslateSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());
	}

	public TCMultipleBindList getTCMultipleBindList()
	{
		TCMultipleBindList result = new TCMultipleBindList();
		for(TRMultipleBind b : this)
		{
			result.add(b.getVDMBind());	
		}
		return result;
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
				bindSpread.get(b.getMultipleBindKind()).add(i);
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

	@Override
	public boolean needsPatternContext() {
		boolean result = false;
		for(int i = 0; i < size() && !result; i++)
		{
			result = get(i).needsPatternContext();
		}
		return result;
	}

	@Override
    public String patternContextTranslate(String varName) {
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			String recTranslate = get(0).patternContextTranslate(varName);
			sb.append(recTranslate);
			for(int i = 1; i < size(); i++)
			{
				if (!recTranslate.isEmpty())
				{
					// no need for semantic separator since the PatternList keeps all the context in control up to "in" part
					//sb.append(getSemanticSeparator());
					sb.append(getFormattingSeparator());					
				}
				recTranslate = get(i).patternContextTranslate(varName);
				sb.append(recTranslate);
			}
		}
		return sb.toString();
    }

	private TRExpression patternExpression(TRPattern p, /*LexToken op,*/ TRExpression rhs)
	{
		assert 
		//TRExpression.VALID_BINARY_OPS.contains(IsaToken.from(op)) && 
//				IsaToken.from(op).equals(IsaToken.INSET) &&
				rhs.getType() instanceof TRSetType;
		TRSetType stype = (TRSetType)rhs.getType();
		// p in set RHS
		return TRBinaryExpression.newBinaryExpression(
			TRVariableExpression.newVariableExpr(p.location, p.patternTranslate(), stype.getInnerType()),
			new LexKeywordToken(Token.INSET, p.location),/*op //IsaToken.INSET,*/ 
			rhs, 
			TRBasicType.boolType(p.getLocation()));
	}

	private TRExpression patternListExpression(TRPatternList plist, TRExpression rhs)
	{
		assert plist != null && plist.size() > 0;
		TRExpression[] exprs = new TRExpression[plist.size()];
		for(int i = 0; i < plist.size(); i++)
		{
			exprs[i] = patternExpression(plist.get(i), rhs);
		}
		// plist(1) in set RHS and ... plist(n) in set RHS as a chained boolean AND 
		return TRBinaryExpression.newBooleanChain(new LexKeywordToken(Token.AND, plist.getLocation()), exprs);
	}

	private TRExpression bindingExpression(int index)
	{
		assert index >= 0 && index < size() && !(get(index) instanceof TRMultipleTypeBind);
		TRMultipleBind b = get(index);
		TRExpression rhs;
		//TRType btype;
		TRPatternList plist;
		if (b instanceof TRMultipleSetBind)
		{
			TRMultipleSetBind bset = (TRMultipleSetBind)b;
			rhs = (TRExpression)bset.getRHS();
			//TRSetType stype = (TRSetType)rhs.getType();
			//btype = stype.setof;
			assert !bset.plist.isEmpty();
			plist = bset.plist;
		}
		else if (b instanceof TRMultipleSeqBind)
		{
			TRMultipleSeqBind bseq = (TRMultipleSeqBind)b;
			rhs = (TRExpression)bseq.getRHS();
			//TRSeqType stype = (TRSeqType)rhs.getType();
			//btype = stype.seqof;
			assert !bseq.plist.isEmpty();
			plist = bseq.plist;
		}
		else
		{
			// error? imposible to reach?
			plist = TRPatternList.newPatternList((TRPattern[])null);
			rhs = TRLiteralExpression.newBooleanLiteralExpression(getLocation(), false);
			//btype = TRBasicType.boolType(getLocation());
			//TODO report VDMSL error?
		}
		// should never allow empty pattern?
		TRExpression result;
		if (plist != null && plist.size() > 0)
			result = patternListExpression(plist, rhs);
		else 
			result = rhs;
		return result;				
	}

	public TRExpression getBindingsExpression(TRExpression predicate)
	{
		TRExpression result = predicate == null ? TRLiteralExpression.newBooleanLiteralExpression(getLocation(), true) : predicate;
		if (!isEmpty())
		{
			Map<TRMultipleBindKind, SortedSet<Integer>> structure = figureBindsOut();			
			SortedSet<Integer> binding_indices_of_interest = new TreeSet<Integer>();
			for(int i = 0; i < size(); i++) { binding_indices_of_interest.add(i); }
			binding_indices_of_interest.removeAll(structure.get(TRMultipleBindKind.TYPE));
			if (!binding_indices_of_interest.isEmpty())
			{
				Iterator<Integer> indices = binding_indices_of_interest.iterator();
				TRExpression[] exprs = new TRExpression[binding_indices_of_interest.size() + (predicate == null ? 0 : 1)];
				int i = 0;
				while (indices.hasNext())
				{
					exprs[i] = bindingExpression(indices.next());
					i++;
				}
				// add the predicate if it exists as the final ping in the chain
				if (predicate != null)
					exprs[i] = result;
				result = TRBinaryExpression.newBooleanChain(new LexKeywordToken(Token.AND, getLocation()), exprs);
			}
		}
		else
		{
			// if called on empty, then give up! 
			//result = new TRNotYetSpecifiedExpression(getLocation(), TRExpression.unknownType(getLocation()));
			// Perhaps just say "true"? 
		}
		TRNode.setup(result);
		return result;
	}
	
	public boolean setSetSeqForMultiBindList()
	{
		boolean result = size() == 1 && get(0) instanceof TRMultipleSetBind;
		if (result)
		{
			((TRMultipleSetBind)get(0)).seqBind = true;
		}	
		return result; 
	}

	public boolean isSetSeqBind() {
		return size() == 1 && 
			get(0) instanceof TRMultipleSetBind && 
			((TRMultipleSetBind)get(0)).seqBind;
	}

	/**
	 * Returns the first bind RHS or null for empty
	 * @return
	 */
	public TRNode getRHS()
	{
		return isEmpty() ? new TRUnknownType(getLocation()) : get(0).getRHS();
	}

	public TRTypeBindList getTypeBindList()
    {
        // there can't be duplication in the named binds, so a list is fine.
        TRTypeBindList result = new TRTypeBindList();
        for(TRMultipleBind b : this)
        {
            result.addAll(b.getTypeBindList());
        }
		TRNode.setup(result);
        return result;
    }

	public TRPatternListList getPatternListList()
	{
		// these names must be unique for a TC binding list (e.g. no "x,y in set S, x,z in seq T" within same list)
		TRPatternListList result = new TRPatternListList();
		for(TRMultipleBind b : this)
		{
			result.add(b.plist);
		}
		TRNode.setup(result);
		return result;
	}

	/**
	 * Look through the multiple binding list patterns to see which ones matches it *first*. Assume unique names. No warn. 
	 */
	public TRMultipleBind findBinding(TCNameToken name)
	{
		TRMultipleBind result = null; 
		for(TRMultipleBind b : this)
		{
			if (b.plist.getNamesInPatternList().contains(name))
			{
				result = b;
			}
		}
		// if a result is found, then dwell on whether to warn or not
		if (result != null && !getPatternListList().uniqueNames())
		{
			warning(IsaWarningMessage.VDMSL_FIND_BINDING_OF_DUPLICATE_PATTERN_NAME_2P, result.translate(), name.toString());
		}
		return result; 
	}

	public TRDefinitionList getDefinitions()
    {
        TRDefinitionSet result = new TRDefinitionSet();
        for(TRMultipleBind b : this)
        {
			result.addAll(b.getDefinitions());
        }
		result.setup();
        return result.asList();
    }

	public static String translate(TRMultipleBind... args)
	{
		TRMultipleBindList result = new TRMultipleBindList();
		result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		return result.translate();	
	}
}
