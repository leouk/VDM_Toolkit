/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import java.util.Arrays;
import java.util.List;

import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeList;

import plugins.GeneralisaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRTypeList extends TRMappedList<TCType, TRType>
{
	private static final long serialVersionUID = 1L;
	
	private boolean curried;

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
	protected void setup()
	{
		super.setup();
		setCurried(false);
		setFormattingSeparator(" ");
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

	private boolean isValidInvTranslateCall(List<String> varNames)
	{
		return varNames.size() > size();
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
		if (isValidInvTranslateCall(varNames))
		{
			report(11111, "Inconsistent invariant translation call in type list: " + 
					GeneralisaPlugin.plural(varNames.size(), "variable name", "s") + 
					" " + varNames.toString() + " for " + 
					GeneralisaPlugin.plural(size(), "declared type", "s") + ".");
			//System.out.println(varNames);
			//Throwable t = new Throwable();t.printStackTrace();
		}
		StringBuilder sb = new StringBuilder();
		if (!isEmpty() && varNames.size() <= this.size()) 
		{
			sb.append("(");
			sb.append(get(0).invTranslate(varNames.get(0)));
			for (int i = 1; i < varNames.size(); i++)
			{
				sb.append(getFormattingSeparator());
				sb.append(getInvTranslateSeparator());
				sb.append(getFormattingSeparator());
				sb.append(get(i).invTranslate(varNames.get(i)));
			}
			sb.append(")");
		}
		return sb.toString();	
	}

	public TRTypeList copy()
	{
		return new TRTypeList(this); 
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
}
