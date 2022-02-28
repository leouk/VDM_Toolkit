/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeList;

import plugins.GeneralisaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRExpressionList;

public class TRTypeList extends TRMappedList<TCType, TRType>
{
	private static final long serialVersionUID = 1L;
	
	private boolean curried;
	private TCNameToken typename;

	public TRTypeList()
	{
		super();
	}

	public TRTypeList(TRTypeList from)
	{
		this();
		addAll(from);
		typename = null;
	}

	public TRTypeList(TCTypeList from) throws Exception
	{
		super(from);
		typename = null;
	}

	@Override
	public void setup()
	{
		super.setup();
		setCurried(true);
		setFormattingSeparator(IsaToken.SPACE.toString());
		setInvTranslateSeparator(IsaToken.SPACE.toString() + IsaToken.AND.toString() + IsaToken.SPACE.toString());
	}

	public Set<String> getDefLemmas()
	{
		TreeSet<String> result = new TreeSet<String>();
		for(TRType t : this)
		{
			result.addAll(t.getDefLemmas());
		}
		return result;
	}

	/**
	 * The outer type name this type list belongs to
	 * @param tn
	 */
	protected void setInferredNamedForType(TCNameToken tn)
	{
		typename = tn;
	}

	public String getName()
	{
		return typename != null ? typename.toString() : IsaToken.UNKNOWN.toString();
	}

	/**
	 * Check there are no union types within the type list
	 * @param source
	 * @param arg
	 */
	protected void checkForUnionTypes()
	{
		for(TRType t : this)
		{
			t.checkForUnionTypes();
		}
	}

	public boolean isCurried()
	{
		return curried;//getSeparator().equals(IsaToken.FUN.toString()
	}

	public void setCurried(boolean curried) 
	{
		this.curried = curried;
		setSemanticSeparator(this.curried ? IsaToken.FUN.toString() : IsaToken.CROSSPROD.toString());
	}

	@Override
	public String setSemanticSeparator(String sep)
	{
		// do not change the inner separator list elements separator? 
		return setSemanticSeparator(sep, false);
	}

	public void setAtTopLevelDefinition(boolean b, boolean deep)
	{
		for(TRType t : this)
		{
			t.setAtTopLevelDefinition(b, deep);
		}
	}

	private boolean isValidInvTranslateCall(List<String> varNames)
	{
		return varNames.size() <= size();
	}

	@Override
	protected String invTranslateElement(int index)
	{
		return invTranslateElement(index, null);
	}

	protected String invTranslateElement(int index, String varName)
	{
		assert index >= 0 && index < size();
		TRType t = get(index);
		// for parametric type invariants, we have to ignore any inv translate calls, given they are given as a synthetic pattern  / type parameter
		return (t instanceof TRFunctionType && ((TRFunctionType)t).isParametricInvariantType()) ? "" : t.invTranslate(varName);
	}

	/**
	 * This call constructs impicit type invariant checks for the given variable names for every TRType in the list.
	 * Invariant checks are chained with IsaToken.AND, yet the user might want to varry output formatting (e.g. \\n\\t etc.).
	 * If varNames is smaller than the list, gets the first types up to varNames size. This is useful, for example, to 
	 * remove "RESULT" from post condition checks where relevant (i.e. linient post_f translations have to call pre_f)
	 * @param varNames invariant call variable names per TRType; size must equal list size
	 * @param formattingSeparator non-null possibly empty, formatting separator 
	 * @return implicit invariant check string for given var names and formatting separator 
	 */
	public String invTranslate(List<String> varNames)
	{
		boolean validCall = isValidInvTranslateCall(varNames);
		if (!validCall)
		{
			report(IsaErrorMessage.ISA_TYPELIST_INVTR_SIZE_3P, GeneralisaPlugin.plural(varNames.size(), "variable name", "s"), 
				varNames.toString(), GeneralisaPlugin.plural(size(), "declared type", "s"));
			//System.out.println(varNames);//Throwable t = new Throwable();t.printStackTrace();
		}
		// can ask to up to size but not beyond
		StringBuilder sb = new StringBuilder();
		if (!isEmpty() && validCall) 
		{
			sb.append(IsaToken.LPAREN.toString());
			String invStr = invTranslateElement(0, varNames.get(0));
			sb.append(invStr);
			for (int i = 1; i < varNames.size(); i++)
			{
				if (!invStr.isEmpty())
				{
					sb.append(getFormattingSeparator());
					sb.append(getInvTranslateSeparator());
					sb.append(getFormattingSeparator());
				}
				invStr = invTranslateElement(i, varNames.get(i));
				sb.append(invStr);
			}
			sb.append(IsaToken.RPAREN.toString());
		}
		return sb.toString();	
	}

	public TRTypeList copy(boolean atTLD)
	{
		TRTypeList result = new TRTypeList();
		for(TRType t : this)
		{
			result.add(t.copy(atTLD));
		}
		TRNode.setup(result);
		return result;
	}

	public TCTypeList getVDMTypeList()
	{
		TCTypeList result = new TCTypeList();
		for(TRType t : this)
		{
			result.add(t.getVDMType());
		}
		return result;
	}

	/**
	 * Type list parameters must take into account function types, which have to be parenthesised, given "=>" binds tighter
	 * and to the right in comparison to any other operator. 
	 */
	@Override
	protected String translateElement(int index)
	{
		String result = super.translateElement(index);
		return get(index) instanceof TRFunctionType ? IsaToken.parenthesise(result) : result;
	}

	public static final String translate(TRType... args)
	{
		TRTypeList result = new TRTypeList();
		result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		return result.translate();	
	}

	public static final String invTranslate(List<String> varNames, String formattingSeparator, TRType... args)
	{
		TRTypeList result = new TRTypeList();
		result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		result.setFormattingSeparator(formattingSeparator);
		return result.invTranslate(varNames);	
	}

	public static final TRTypeList newTypeList(TRExpressionList members) {
		TRTypeList result = new TRTypeList();
		for(TRExpression e : members)
		{
			result.add(e.getType());
		}
		TRNode.setup(result);
		return result;
	}

	public static final TRTypeList newTypeList(TRType... members) {
		TRTypeList result = new TRTypeList();
		if (members != null) 	
			result.addAll(Arrays.asList(members));
		TRNode.setup(result);
		return result;
	}
}
