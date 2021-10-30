/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.types;

import java.util.Arrays;
import java.util.List;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeList;

import plugins.Vdm2isaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRTypeList extends TRMappedList<TCType, TRType>
{
	private static final long serialVersionUID = 1L;
	
	protected TRTypeList()
	{
		super();
		setCurried(false);
	}

	public TRTypeList(TCTypeList list) throws Exception
	{
		super(list);
		setCurried(false);
	}

	public void setCurried(boolean curried) 
	{
		separator = curried ? IsaToken.FUN.toString() : IsaToken.CROSSPROD.toString();	
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
	public String invTranslate(List<String> varNames, String formattingSeparator)
	{
		assert formattingSeparator != null;
		if (varNames.size() > this.size())
		{
			this.report(11111, "Inconsistent invariant translation call: " + 
					varNames.size() + " variable " + Vdm2isaPlugin.plural(varNames.size(), "name", "s") + " for " + 
					this.size()     + " declared " + Vdm2isaPlugin.plural(this.size(), "type", "s") + ".",
					this.size() == 0 ? LexLocation.ANY : this.get(0).location);
		}
		StringBuilder sb = new StringBuilder();
		if (!isEmpty() && varNames.size() <= this.size()) 
		{
			sb.append("(");

			sb.append(get(0).invTranslate(varNames.get(0)));

			for (int i=1; i< varNames.size(); i++)
			{
				sb.append(" ");
				sb.append(IsaToken.AND.toString());
				// presumes the user defines sensible separator?
				sb.append(formattingSeparator);//sb.append("\n\t\t");
				sb.append(get(i).invTranslate(varNames.get(i)));
			}
			sb.append(")");
		}
		return sb.toString();	
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
		list.addAll(Arrays.asList(args));
		return list.invTranslate(varNames, formattingSeparator);	
	}
}
