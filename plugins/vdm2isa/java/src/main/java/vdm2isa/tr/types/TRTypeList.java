/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import java.util.Arrays;
import java.util.List;

import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeList;

import plugins.GeneralisaPlugin;
import vdm2isa.lex.IsaSeparator;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRExpressionList;

public class TRTypeList extends TRMappedList<TCType, TRType>
{
	private static final long serialVersionUID = 1L;
	
	private boolean curried;
	private String separator;

	protected TRTypeList()
	{
		super();
	}

	public TRTypeList(TRTypeList from)
	{
		this();
		addAll(from);
	}

	public TRTypeList(TCTypeList from) throws Exception
	{
		super(from);
	}

	@Override
	public void setup()
	{
		super.setup();
		setCurried(false);
		setFormattingSeparator(" ");
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
		setInvTranslateSeparator(" " + IsaToken.AND.toString() + " ");
	}

	@Override
	public String setSemanticSeparator(String sep)
	{
		String result = getSemanticSeparator();
		if (IsaTemplates.checkSeparator(getLocation(), sep, IsaSeparator.SEMANTIC))
		{
			this.separator = sep;
			// do not change the inner separator list elements separator? 
		}
		return result;
	}

	@Override
	public String getSemanticSeparator()
	{
		return separator;
	}

	public void setAtTopLevelDefinition(boolean b)
	{
		for(TRType t : this)
		{
			t.setAtTopLevelDefinition(b);
		}
	}

	private boolean isValidInvTranslateCall(List<String> varNames)
	{
		return varNames.size() <= size();
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
			sb.append(get(0).invTranslate(varNames.get(0)));
			for (int i = 1; i < varNames.size(); i++)
			{
				sb.append(getFormattingSeparator());
				sb.append(getInvTranslateSeparator());
				sb.append(getFormattingSeparator());
				sb.append(get(i).invTranslate(varNames.get(i)));
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

	public static String translate(TRType... args)
	{
		TRTypeList list = new TRTypeList();
		list.addAll(Arrays.asList(args));
		return list.translate();	
	}

	public static String invTranslate(List<String> varNames, String formattingSeparator, TRType... args)
	{
		TRTypeList list = new TRTypeList();
		list.setFormattingSeparator(formattingSeparator);
		list.addAll(Arrays.asList(args));
		return list.invTranslate(varNames);	
	}

	public static TRTypeList newTypeList(TRExpressionList members) {
		TRTypeList result = new TRTypeList();
		for(TRExpression e : members)
		{
			result.add(e.getType());
		}
		return result;
	}

	public static TRTypeList newTypeList(TRType... members) {
		TRTypeList result = new TRTypeList();
		if (members != null) 	
			result.addAll(Arrays.asList(members));
		return result;
	}
}
