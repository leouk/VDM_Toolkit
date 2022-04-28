/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr;

import vdm2isa.lex.IsaSeparator;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.MappedObject;

import plugins.GeneralisaPlugin;

abstract public class TRNode extends MappedObject implements MappableNode
{
	private static final long serialVersionUID = 1L;
	public final static String MAPPINGS = "tc-tr.mappings";

	public final LexLocation location; 
	private String separator;
	private String formattingSeparator;
	private String invTranslateSeparator;
	private boolean alreadySetup;

	protected TRNode(LexLocation location)
	{
		super();
		this.location = location != null ? location : LexLocation.ANY; 
		this.separator = "";
		this.formattingSeparator = "";
		this.invTranslateSeparator = "";
		this.alreadySetup = false;
	}

	@Override
	public void setup()
	{
		//setSemanticSeparator("");
		//setFormattingSeparator("");
		//setInvTranslateSeparator("");
		alreadySetup = true;
	}

	@Override 
	public final boolean setupDone()
	{
		return this.alreadySetup;
	}

	/**
	 * No Isabelle comment by default 
	 */
	@Override 
	public String tldIsaComment()
	{
		return "";
	}

	/**
	 * General debug string for all TRNode classes
	 */
    @Override
    public String toString()
    {
        return getClass().getSimpleName() + "[" + String.valueOf(isaToken()) + "]" //+
			 	//String.valueOf(getLocation())
				 ; 
    }

	@Override
	public String getSemanticSeparator()
	{
		return separator;
	}

	@Override
	public String setSemanticSeparator(String sep)
	{
		String old = getSemanticSeparator();
		if (IsaTemplates.checkSeparator(getLocation(), sep, IsaSeparator.SEMANTIC))
		{
			separator = sep;
		}
		return old;
	}

	@Override
	public String getFormattingSeparator()
	{
		return formattingSeparator;
	}

	@Override
	public String setFormattingSeparator(String sep)
	{
		String old = getFormattingSeparator();
		if (IsaTemplates.checkSeparator(getLocation(), sep, IsaSeparator.FORMATING))
		{
			formattingSeparator = sep;
		}
		return old;
	}

	@Override
	public String getInvTranslateSeparator()
	{
		return invTranslateSeparator;
	}

	@Override
	public String setInvTranslateSeparator(String sep)
	{
		String old = getInvTranslateSeparator();
		if (IsaTemplates.checkSeparator(getLocation(), sep, IsaSeparator.SEMANTIC))
		{
			invTranslateSeparator = sep;
			//System.out.println("sep = " + sep + " for " + this.toString());
		}	
		return old;
	}

	@Override
	public LexLocation getLocation()
	{
		return location;
	}
	
	@Override
	public void report(IsaErrorMessage message)
	{
		GeneralisaPlugin.report(message, getLocation());
	}

	@Override
	public void warning(IsaWarningMessage warning)
	{
		GeneralisaPlugin.warning(warning, getLocation());
	}

	@Override
	public void report(IsaErrorMessage message, Object... args)
	{
		GeneralisaPlugin.report(message, getLocation(), args);
	}

	@Override
	public void warning(IsaWarningMessage warning, Object... args)
	{
		GeneralisaPlugin.warning(warning, getLocation(), args);
	}
	
	//@Override
	public void report(int number, String message)
	{
		GeneralisaPlugin.report(number, message, getLocation());
	}

	//@Override
	public void warning(int number, String warning)
	{
		GeneralisaPlugin.warning(number, warning, getLocation());
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
	@Override
	public abstract String translate();

	/**
	 * Top-level (implicit) invariant-related translation associated with this TRNode. TRNodes with contextual
	 * information do not require extra parameters (i.e. they can be inferred from TRNode fields); otherwise, 
	 * an extended version with the variable(s) names needed can be added (i.e. TRType doesn't have its associated 
	 * variable name to be used for invariant translation). See TRType#invTranslate(String). 
	 * @return Isabelle YXML string.
	 */
	protected String nodeInvTranslate()
	{
		report(IsaErrorMessage.ISA_INVALID_INVTR_2P, getClass().getSimpleName(), toString());
		return "";
	}
	
	/**
     * Expressions do not support invariant translation in general. Some type-bound/local expressions do and can extend this behaviour.
     */
    @Override
    public String invTranslate()
    {
		return nodeInvTranslate();
    }

	/**
	 * Derived classes can call this method to setup their inner parts taking into account when/if they are null. 
	 * @param nodes
	 */
	public static final void setup(MappableNode... nodes)
	{
		if (nodes != null)
		{
			for(MappableNode n : nodes)
			{
				// allow for null as some internal parts are allowed to be null 
				// testing for non-null is the responsability of each class.
				//
				// avoid loooping for when setting up inner definitions of certain TRNodes, like TRType.definitions etc. 
				if (n != null && !n.setupDone())
					n.setup();
			}
		}
	}
}
