/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/
package vdm2isa.tr;

import java.util.List;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.mapper.Mappable;
import com.fujitsu.vdmj.mapper.MappedList;

import vdm2isa.lex.IsaTemplates;
import plugins.Vdm2isaPlugin;

/**
 * Tighthened target (TO) type with an interface containing the key TRNode-related methods
 */
public class TRMappedList<FROM extends Mappable, TO extends MappableNode> extends MappedList<FROM, TO> implements MappableNode
{
	private static final long serialVersionUID = 1L;

	public String separator; 
	
	@SuppressWarnings("unchecked")
	public TRMappedList(List<FROM> from) throws Exception
	{
		//super(TRNode.MAPPINGS, from);
		super();
		// to enable debugging
		ClassMapper mapper = ClassMapper.getInstance(TRNode.MAPPINGS);	
		
		for (FROM type: from)
		{
			try
			{
				add((TO)mapper.convert(type));
			}
			catch (Exception e)
			{
				Vdm2isaPlugin.report(11111, "Could not yet convert " + from.getClass().getName() + " = " + e.toString(), LexLocation.ANY);
				//e.printStackTrace();
			}
			catch (Throwable t)
			{
				Vdm2isaPlugin.report(11111, "Unexpected exception when converting " + from.getClass().getName() + " = " + t.toString(), LexLocation.ANY);
				t.printStackTrace();
			}
		}
		separator = "";
	}
	
	public TRMappedList()
	{
		super();
		separator = "";
	}
	
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).toString());
			for (int i = 1; i < size(); i++)
			{
				// in case of silly null separator!
				sb.append(String.valueOf(separator));
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

	public String translate()
	{
		return IsaTemplates.listToString(this, separator);
	}

	public String invTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).invTranslate());
			for (int i = 1; i < size(); i++)
			{
				sb.append(separator);
				sb.append(get(i).invTranslate());
			}
		}
		return sb.toString();
	}

	public void report(int number, String msg, LexLocation location)
	{
		Vdm2isaPlugin.report(number, msg, location);
	}

	public void warning(int number, String msg, LexLocation location)
	{
		Vdm2isaPlugin.warning(number, msg, location);
	}
}
