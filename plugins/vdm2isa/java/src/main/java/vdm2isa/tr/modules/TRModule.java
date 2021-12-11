/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.modules;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModule;

import java.io.File;
import java.util.Arrays;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.FileList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;

public class TRModule extends TRNode
{
	private static final long serialVersionUID = 1L;
	public final TCIdentifierToken name;
	public final TRDefinitionList definitions;
	public final FileList files;
	public final TCModule module; 

	public TRModule(TCModule m, TCIdentifierToken name, TRDefinitionList definitions, FileList files)
	{
		super(name != null ? name.getLocation() : LexLocation.ANY);
		this.module = m;
		this.name = name;
		this.definitions = definitions;
		this.files = files;
	}

	@Override 
	public void setup()
	{
		super.setup();
		if (files == null || files.isEmpty())
		{
			// will take the module name anyhow
			warning(IsaWarningMessage.VDMSL_EMPTY_MODULE_FILES_1P, name.toString());
		}
		else 
		{
			boolean found = false;
			String fileName;
			for(int i = 0; i < files.size() && !found; i++)
			{
				File f = files.get(i);
				fileName = f.getName();
				int pos = fileName.lastIndexOf(".");
				if (pos > 0 && pos < (fileName.length() - 1)) 
				{   // If '.' is not the first or last character.
					fileName = fileName.substring(0, pos);
				}
				found = fileName.equals(name.toString());
			}
			if (!found)
			{
				report(IsaErrorMessage.ISA_INVALID_MODULE_NAME_2P, name.toString(), files.toString());
			}
		}
		
		TRNode.setup(definitions);
		System.out.println(toString());
	}

	@Override 
	public String toString()
	{
		return  "Module " + name.toString() + 
		 	"\n\t imports = " + (module != null ? module.imports != null ? module.imports.toString() : "" : "") +
		 	"\n\t impdefs = " + (module != null ? module.importdefs != null ? module.importdefs.toString() : "" : "");
	}

	@Override
	public IsaToken isaToken() {
		return IsaToken.MODULE;
	}

	/**
	 * If multiple imports list must take into account Isabelle impoting syntax 
	 * (i.e. innerSyntaxIt if relative path; just space separated string otherwise)
	 * @return
	 */
	public String getImports()
	{
		return IsaToken.VDMTOOLKIT.toString();
	}

	@Override
	public String translate()
	{
		String loc = name.getLocation() != null ? name.getLocation().toString() : "";
		if (files != null && !files.isEmpty())
		{ 
			loc += "\nfiles = " + files.toString();
		}
		return IsaTemplates.translateModule("", loc, name.toString(), getImports(), definitions.translate());
	}

    /**
     * Modules do not support invariant translation.
     */
    @Override
    public String invTranslate()
    {
		report(IsaErrorMessage.ISA_INVALID_INVTR_2P, getClass().getSimpleName(), name.toString());
        return "";
    }

	public static FileList asFileList(File... args)
	{
		FileList result = new FileList();
		if (args != null)
			result.addAll(Arrays.asList(args));
		return result;
	}
}
