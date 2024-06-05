/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/
package vdm2isa.tr;

import java.util.ArrayList;
import java.util.List;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.mapper.Mappable;
import com.fujitsu.vdmj.mapper.MappedList;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.patterns.TCBind;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.types.TCType;

import plugins.commands.IsabelleCommand;
import vdm2isa.lex.IsaSeparator;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;

/**
 * Tighthened target (TO) type with an interface containing the key TRNode-related methods
 */
public abstract class TRMappedList<FROM extends Mappable, TO extends MappableNode> extends MappedList<FROM, TO> implements MappableNode
{
	private static final long serialVersionUID = 1L;

	private String separator;
	private String formattingSeparator;
	private String invTranslateSeparator; 
	private boolean alreadySetup;
	
	@SuppressWarnings("unchecked")
	public TRMappedList(List<FROM> from) throws Exception
	{
		// to enable debugging + setting up properly
		this();		
		ClassMapper mapper = ClassMapper.getInstance(TRNode.MAPPINGS);			
		for (FROM type: from)
		{
			try
			{
				add((TO)mapper.convert(type));
			}
			catch (Exception e)
			{				
				IsabelleCommand.report(IsaErrorMessage.PLUGIN_MISSING_MAPPING_ERROR_3P, 
					figureOutLocation(type), 
					from.getClass().getSimpleName(), 
					type.getClass().getSimpleName() + " " + type.toString(),
					e.toString());
				// don't debug "can't convert errors"! 
				if (e instanceof NullPointerException || e.getCause() instanceof StackOverflowError)
					e.printStackTrace();
			}
			catch (Throwable t)
			{
				IsabelleCommand.report(IsaErrorMessage.PLUGIN_UNEXPECTED_ERROR_3P, 
					figureOutLocation(from), 
					"when converting",
					from.getClass().getSimpleName(), 
					t.toString());
				t.printStackTrace();
			}
		}
	}
	
	/**
	 * Allow for empty list creation so that subclasses can call super when creating concrete empty lists, in which case their 
	 * location will be LexLocation.ANY. All subclasses *must* not make their default constructors public, so that we will always
	 * have location information from the TC AST. 
	 */
	protected TRMappedList()
	{
		super();
		// set this up at list level only, given setupElements will do the rest for the inner elements. 
		this.separator = "";
		this.formattingSeparator = "";
		this.invTranslateSeparator = ""; 
		this.alreadySetup = false;
	}

	protected TRMappedList<FROM, TO> doCopy(boolean atTLD)
	{
		throw new UnsupportedOperationException("Cannot copy mapped list " + getClass().getSimpleName());
	}

	public final TRMappedList<FROM, TO> copy(boolean atTLD)
	{
		//setup();
		return doCopy(atTLD);
	}

	/**
	 * Set up of basic parameters (separators etc) for the list. This cannot rely on fields being set on super calls!
	 */
	@Override
	public void setup()
	{
		TRMappedList.setupElements(this);
		alreadySetup = true;
	}

	@Override 
	public final boolean setupDone()
	{
		return this.alreadySetup;
	}

	@Override
	public IsaToken isaToken()
	{
		return IsaToken.EOF;
	}

	@Override
	public final String getSemanticSeparator()
	{
		return separator;
	}

	public String setSemanticSeparator(String sep, boolean deep)
	{
		String result = getSemanticSeparator();
		if (IsaTemplates.checkSeparator(getLocation(), sep, IsaSeparator.SEMANTIC))
		{
			separator = sep;
			if (deep)
			{
				for (MappableNode n : this)
				{
					n.setSemanticSeparator(sep);
				}
			}
		}
		return result;
	}

	@Override
	public String setSemanticSeparator(String sep)
	{
		return setSemanticSeparator(sep, true);
	}

	@Override
	public final String getFormattingSeparator()
	{
		return formattingSeparator;
	}

	public String setFormattingSeparator(String sep, boolean deep)
	{
		String old = getFormattingSeparator();
		if (IsaTemplates.checkSeparator(getLocation(), sep, IsaSeparator.FORMATING))
		{
			formattingSeparator = sep;
			if (deep)
			{
				for (MappableNode n : this)
				{
					n.setFormattingSeparator(sep);
				}	
			}
		}
		return old;
	}

	@Override
	public String setFormattingSeparator(String sep)
	{
		return setFormattingSeparator(sep, true);
	}

	@Override
	public final String getInvTranslateSeparator()
	{
		return invTranslateSeparator;
	}

	public String setInvTranslateSeparator(String sep, boolean deep)
	{
		String old = getInvTranslateSeparator();
		if (IsaTemplates.checkSeparator(getLocation(), sep, IsaSeparator.SEMANTIC))
		{
			invTranslateSeparator = sep;
			if (deep)
			{
				for (MappableNode n : this)
				{
					n.setInvTranslateSeparator(sep);
				}	
			}
		}	
		return old;
	}

	@Override
	public String setInvTranslateSeparator(String sep)
	{
		return setInvTranslateSeparator(sep, true);
	}

	/**
	 * No Isabelle comment by default 
	 */
	@Override 
	public String tldIsaComment()
	{
		return "";
	}

	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).toString());
			sb.append(getFormattingSeparator());
			for (int i = 1; i < size(); i++)
			{
				//TODO workout whether to include before/after formatting separators? 
				//sb.append(getSemanticSeparator());
				//sb.append(getFormattingSeparator());
				sb.append("\n\t\t");
				sb.append(get(i).toString());
			}
		}
		return sb.toString();
	}

	@Override
	public boolean equals(Object other)
	{
		if (other instanceof TRMappedList)
		{
			return super.equals(other);
		}
		
		return false;
	}

	protected String translateElement(int index)
	{
		assert index >= 0 && index < size();
		return get(index).translate();
	}

	public List<String> translateList()
	{
		List<String> result = new ArrayList<String>();
		for(TO t : this)
		{
			result.add(t.translate());
		}
		return result;
	}

	@Override
	public String translate()
	{
		return oldtranslate(); 
	}

	//@Override
	public String oldtranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(translateElement(0));
			for (int i = 1; i < size(); i++)
			{
				sb.append(getFormattingSeparator());
				sb.append(getSemanticSeparator());
                sb.append(getFormattingSeparator());
				sb.append(translateElement(i));
			}
		}
		return sb.toString();
	}

	protected String invTranslateElement(int index)
	{
		assert index >= 0 && index < size();
		return get(index).invTranslate();
	}

	@Override
	public String invTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			// might be empty for TRParameterType in TRTypeList 
			String invStr = invTranslateElement(0);
			sb.append(invStr);
			for (int i = 1; i < size(); i++)
			{
				if (!invStr.isEmpty())
				{
					sb.append(getFormattingSeparator());
					sb.append(getInvTranslateSeparator());
					sb.append(getFormattingSeparator());
				}
				invStr = invTranslateElement(i);
				sb.append(invStr);
			}
		}
		return sb.toString();
	}

	@Override 
	public LexLocation getLocation()
	{
		return size() == 0 ? LexLocation.ANY : this.get(0).getLocation();
	}

	@Override
	public void report(IsaErrorMessage message, Object... args)
	{
		IsabelleCommand.report(message, getLocation(), args);
	}

	@Override
	public void warning(IsaWarningMessage warning, Object... args)
	{
		IsabelleCommand.warning(warning, getLocation(), args);
	}

	@Override
	public void report(IsaErrorMessage message)
	{
		IsabelleCommand.report(message, getLocation(), (Object[])null);
	}

	@Override
	public void warning(IsaWarningMessage warning)
	{
		IsabelleCommand.warning(warning, getLocation(), (Object[])null);
	}

	public static <T extends Mappable/*Node!*/>  LexLocation figureOutLocation(List<T> list)
	{
		LexLocation result = LexLocation.ANY;
		// figure out the first possile location or ANY otherwise.
		for(int i = 0; i < list.size() && result.equals(LexLocation.ANY); i++)
		{
			result = figureOutLocation(list.get(i));
		}
		return result;
	}

	public static <T extends Mappable/*Node!*/>  LexLocation figureOutLocation(T t)
	{
		return t instanceof TCExpression ? 
			((TCExpression)t).location : 
				t instanceof TCType ? 
					((TCType)t).location : 
						t instanceof TCDefinition ? 
							((TCDefinition)t).location : 
								t instanceof TCModule ? 
									((TCModule)t).name.getLocation() :
										t instanceof TCPattern ? 
											((TCPattern)t).location :
												t instanceof TCBind ? 
													((TCBind)t).location : LexLocation.ANY;
	}
	
	public static <FROM extends Mappable, TO extends MappableNode> void setupElements(MappedList<FROM, TO> list)
	{
		for(TO t : list)
		{
			if (t != null && !t.setupDone()) 
				t.setup();
		}
	}
}
