/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr;

import vdm2isa.lex.IsaToken;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.MappedObject;

import plugins.Vdm2isaPlugin;

abstract public class TRNode extends MappedObject implements MappableNode
{
	private static final long serialVersionUID = 1L;
	public final static String MAPPINGS = "tc-tr.mappings";

	public final LexLocation location; 
	private String separator;
	private String formattingSeparator;

	protected TRNode(LexLocation location)
	{
		super();
		this.location = location; 
		setSeparator("");
		setFormattingSeparator("");
	}

	/**
	 * General debug string for all TRNode classes
	 */
    @Override
    public String toString()
    {
        return getClass().getSimpleName() + "[" + String.valueOf(isaToken()) + "] = " + translate();
    }

	@Override
	public String getSeparator()
	{
		return separator;
	}

	@Override
	public String setSeparator(String sep)
	{
		String result = separator;
		separator = sep;
		return result;
	}

	@Override
	public String getFormattingSeparator()
	{
		return formattingSeparator;
	}

	@Override
	public String setFormattingSeparator(String sep)
	{
		String result = formattingSeparator;
		formattingSeparator = sep;
		return result;
	}

	@Override
	public LexLocation getLocation()
	{
		return location;
	}
	
	@Override
	public void report(int number, String msg)
	{
		Vdm2isaPlugin.report(number, msg, getLocation());
	}

	@Override
	public void warning(int number, String msg)
	{
		Vdm2isaPlugin.warning(number, msg, getLocation());
	}
	
	/**
	 * Isabelle token associated with this TRNode. Some are control tokens, other are translation tokens.
	 * @return the IsaToken associated with this TRNode
	 */
	public abstract IsaToken isaToken();

	/**
	 * Top-level translation associated with this TRNode. 
	 * @return Isabelle YXML string.
	 */
	public abstract String translate();

	/**
	 * Top-level (implicit) invariant-related translation associated with this TRNode. TRNodes with contextual
	 * information do not require extra parameters (i.e. they can be inferred from TRNode fields); otherwise, 
	 * an extended version with the variable(s) names needed can be added (i.e. TRType doesn't have its associated 
	 * variable name to be used for invariant translation). See TRType#invTranslate(String). 
	 * @return Isabelle YXML string.
	 */
	public abstract String invTranslate();
}
