/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr;

import vdm2isa.lex.IsaToken;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.MappedObject;

import plugins.Vdm2isaPlugin;

abstract public class TRNode extends MappedObject
{
	private static final long serialVersionUID = 1L;
	public final static String MAPPINGS = "tc-tr.mappings";

	public final LexLocation location; 

	protected TRNode(LexLocation location)
	{
		super();
		this.location = location; 
	}

	public void report(int number, String msg)
	{
		Vdm2isaPlugin.report(number, msg, location);
	}

	public void warning(int number, String msg)
	{
		Vdm2isaPlugin.warning(number, msg, location);
	}
	
	public abstract IsaToken isaToken();
	public abstract String translate();
}
