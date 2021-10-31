/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/
package vdm2isa.tr;

import java.util.List;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.mapper.Mappable;
import com.fujitsu.vdmj.mapper.MappedList;

import plugins.Vdm2isaPlugin;

/**
 * Tighthened target (TO) type with an interface containing the key TRNode-related methods
 */
public abstract class TRMappedList<FROM extends Mappable, TO extends MappableNode> extends MappedList<FROM, TO> implements MappableNode
{
	private static final long serialVersionUID = 1L;

	private String separator;
	private String formattingSeparator; 
	
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
				Vdm2isaPlugin.report(11111, "Could not convert " + from.getClass().getName() + " = " + e.toString(), LexLocation.ANY);
				e.printStackTrace();
			}
			catch (Throwable t)
			{
				Vdm2isaPlugin.report(11111, "Unexpected exception when converting " + from.getClass().getName() + " = " + t.toString(), LexLocation.ANY);
				t.printStackTrace();
			}
		}
		setSeparator("");
		setFormattingSeparator("");
	}
	
	public TRMappedList()
	{
		super();
		setSeparator("");
		setFormattingSeparator("");
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
		if (sep == null)
			report(11111, "Cannot translate with a null separator");
		else
		{
			separator = sep;
			for (MappableNode n : this)
			{
				n.setSeparator(sep);
			}
		}
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
		if (sep == null)
			report(11111, "Cannot translate with a null separator");
		else
		{
			formattingSeparator = sep;
			for (MappableNode n : this)
			{
				n.setFormattingSeparator(sep);
			}
		}
		return result;
	}

	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).toString());
			//sb.append(getFormattingSeparator());
			for (int i = 1; i < size(); i++)
			{
				//TODO workout whether to include before/after formatting separators? 
				sb.append(getSeparator());
				sb.append(getFormattingSeparator());
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

	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).translate());
			for (int i = 1; i < size(); i++)
			{
				sb.append(getSeparator());
                sb.append(getFormattingSeparator());
				sb.append(get(i).translate());
			}
		}
		return sb.toString();
	}

	@Override
	public String invTranslate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			sb.append(get(0).invTranslate());
			for (int i = 1; i < size(); i++)
			{
				sb.append(getSeparator());
				sb.append(getFormattingSeparator());
				sb.append(get(i).invTranslate());
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
	public void report(int number, String msg)
	{
		Vdm2isaPlugin.report(number, msg, getLocation());
	}

	@Override
	public void warning(int number, String msg)
	{
		Vdm2isaPlugin.warning(number, msg, getLocation());
	}
}
