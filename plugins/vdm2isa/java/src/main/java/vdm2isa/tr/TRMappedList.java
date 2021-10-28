/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/
package vdm2isa.tr;

import java.util.List;

import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.mapper.MappedList;

import vdm2isa.lex.IsaTemplates;

//NB shouldn't this TO extends be added everywhere? 
public class TRMappedList<FROM, TO extends TRNode> extends MappedList<FROM, TO>
{
	private static final long serialVersionUID = 1L;

	public String separator; 
	
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
			catch (Throwable t)
			{
				System.out.println("Exception when creating " + from.getClass().getName());
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
		//throw new UnsupportedOperationException("Base TRMappedList class cannot be translated to Isabelle");
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
		//throw new UnsupportedOperationException("Base TRMappedList class does not have invariant translation to Isabelle");
	}
}
