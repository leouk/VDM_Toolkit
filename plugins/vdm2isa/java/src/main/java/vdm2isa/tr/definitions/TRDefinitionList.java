/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;


import java.util.Arrays;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;

import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.patterns.TRMultipleBind;

public class TRDefinitionList extends TRMappedList<TCDefinition, TRDefinition>
{
	private static final long serialVersionUID = 1L;

	/**
	 * Allow this top-level list to be defined empty
	 */
	public TRDefinitionList()
	{
		super();
	} 

	public TRDefinitionList(TRDefinitionList from)
	{
		this();
		addAll(from);
	}	

	public TRDefinitionList(TCDefinitionList list) throws Exception
	{
		super(list);
	}

	@Override
	protected void setup()
	{
		super.setup();
		setFormattingSeparator("\n\t");
		// if (allAreLocalDefinition())
		// 	setLocal(true);
	}

	// public void setLocal(boolean local)
	// {
	// 	for (TRDefinition def : this)
	// 	{
	// 		def.setLocal(local);
	// 	}
	// }

	public  boolean allAreLocalDefinition()
	{
		return allAre(new TRLocalDefinition());
	}

	public <T extends TRDefinition> boolean allAre(T def)
	{
		boolean result = !isEmpty(); 
		for(int i = 0; i < size(); i++)
		{
			result = result && def.getClass().isInstance(get(i));
		}
		return result;
	}

	public TRDefinitionList copy()
	{
		return new TRDefinitionList(this); 
	}

	protected String recordPatternTranslate(int i)
	{
		assert i >= 0 && i < size();
		TRDefinition def = get(i);
		StringBuilder sb = new StringBuilder();
		if (def instanceof TRValueDefinition)
		{
			TRValueDefinition vdef = (TRValueDefinition)def;
			if (vdef.getPattern() != null)
			{
				sb.append(vdef.getPattern().getPatternList().recordPatternTranslate());
			}
		}
		else if (def instanceof TREqualsDefinition)
		{
			TREqualsDefinition eqdef = (TREqualsDefinition)def;
			if (eqdef.getPattern() != null)
			{
				sb.append(eqdef.getPattern().getPatternList().recordPatternTranslate());
			}
		}
		else if (def instanceof TRMultiBindListDefinition)
		{
			TRMultiBindListDefinition bdef = (TRMultiBindListDefinition)def;
			if (bdef.getBindings() != null)
			{
				for(TRMultipleBind b : bdef.getBindings())
				{
					sb.append(b.plist.recordPatternTranslate());
				}
			}
		}
		//TODO add anyone else with patterns to this
		return sb.toString();
	}

	/**
	 * Introduce any local context for record patterns in any involved binds/patterns. 
	 * @return
	 */
	public String recordPatternTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			String recTranslate = recordPatternTranslate(0);
			sb.append(recTranslate);	
			for (int i = 1; i < size(); i++)
			{
				if (!recTranslate.isEmpty())
				{
					// no need for semantic separator since the PatternList keeps all the context in control up to "in" part
					//sb.append(getSemanticSeparator());
					sb.append(getFormattingSeparator());					
				}
				recTranslate = recordPatternTranslate(i);
				sb.append(recTranslate);	
			}
		}
		return sb.toString();
	}

	public static TRDefinitionList newDefList(TRDefinition... args)
	{
		TRDefinitionList result = new TRDefinitionList();
		result.addAll(Arrays.asList(args));
		return result; 
	}
}
