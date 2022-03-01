/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;


import java.util.Arrays;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;

import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRPatternContext;
import vdm2isa.tr.patterns.TRUnionContext;

public class TRDefinitionList extends TRMappedList<TCDefinition, TRDefinition> implements TRPatternContext, TRUnionContext
{
	private static final long serialVersionUID = 1L;

	private int currentUnionContext;

	/**
	 * Allow this top-level list to be defined empty
	 */
	public TRDefinitionList()
	{
		super();
		currentUnionContext = 0;
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
	public void setup()
	{
		super.setup();
		setFormattingSeparator("\n\t");
	}

	public  boolean allAreLocalDefinition()
	{
		return allAre(TRLocalDefinition.DEFAULT);
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
		TRDefinitionList result = new TRDefinitionList(this); 
		TRNode.setup(result);
		return result;
	}

	protected static final String patternContextTranslate(TRDefinition def)
	{
		StringBuilder sb = new StringBuilder();
		if (def instanceof TRValueDefinition)
		{
			TRValueDefinition vdef = (TRValueDefinition)def;
			if (vdef.getPattern() != null)
			{
				sb.append(vdef.getPattern().getPatternList().patternContextTranslate(null));
			}
		}
		else if (def instanceof TREqualsDefinition)
		{
			TREqualsDefinition eqdef = (TREqualsDefinition)def;
			if (eqdef.getPattern() != null)
			{
				sb.append(eqdef.getPattern().getPatternList().patternContextTranslate(null));
			}
		}
		else if (def instanceof TRMultiBindListDefinition)
		{
			TRMultiBindListDefinition bdef = (TRMultiBindListDefinition)def;
			if (bdef.getBindings() != null)
			{
				for(TRMultipleBind b : bdef.getBindings())
				{
					sb.append(b.plist.patternContextTranslate(null));
				}
			}
		}
		else if (def instanceof TRQualifiedDefinition)
		{
			TRQualifiedDefinition qdef = (TRQualifiedDefinition)def;
			if (qdef.def != null)
			{
				sb.append(patternContextTranslate(def));
			}
		}
		//TODO add anyone else with patterns to this
		return sb.toString();
	}

	protected String patternContextTranslate(int i)
	{
		assert i >= 0 && i < size();
		return TRDefinitionList.patternContextTranslate(get(i));
	}

	@Override 
	public boolean needsPatternContext()
	{
		boolean result = false;
		for(int i = 0; i < size() && !result; i++)
		{
			// if found some... 
			//TODO perhaps refactor his a bit .
			result = !TRDefinitionList.patternContextTranslate(get(i)).isEmpty();
		}
		return result;
	}

	/**
	 * Introduce any local context for record patterns in any involved binds/patterns. 
	 * @return
	 */
	@Override
	public String patternContextTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			String recTranslate = patternContextTranslate(0);
			sb.append(recTranslate);	
			for (int i = 1; i < size(); i++)
			{
				if (!recTranslate.isEmpty())
				{
					// no need for semantic separator since the PatternList keeps all the context in control up to "in" part
					//sb.append(getSemanticSeparator());
					sb.append(getFormattingSeparator());					
				}
				recTranslate = patternContextTranslate(i);
				sb.append(recTranslate);	
			}
		}
		return sb.toString();
	}

	@Override
	public boolean hasUnionTypes() {
		boolean result = false;
		for(int i = 0; i < size() && !result; i++)
		{
			result = get(i).hasUnionTypes();
		}
		return result;
	}

	@Override
	public String unionTypesTranslate(TRExpression body, TRUnionContext innerContext) {
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			currentUnionContext = 0;
			// when inner context is null, we are ready for the body. 
			//TODO innerContext might not be null in case of curried union contexts. Perhaps flatten the defListList in that case? 
			sb.append(get(0).unionTypesTranslate(body, innerContext == null ? getNextUnionContext() : innerContext));	
		}
		return sb.toString();
	}

	@Override 
	public TRUnionContext getNextUnionContext()
	{
		assert currentUnionContext >= 0 && currentUnionContext < size();
		TRUnionContext result = null; 
		if (currentUnionContext < size()-1)
		{
			currentUnionContext++;
			result = get(currentUnionContext);
		}	
		return result;
	}

	public TCDefinitionList getVDMDefinitionList()
	{
		TCDefinitionList result = new TCDefinitionList();
		for(TRDefinition d : this)
		{
			result.add(d.getVDMDefinition());
		}
		return result;
	}

	public static final TRDefinitionList newDefList(TRDefinition... args)
	{
		TRDefinitionList result = new TRDefinitionList();
		result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		return result; 
	}
}
