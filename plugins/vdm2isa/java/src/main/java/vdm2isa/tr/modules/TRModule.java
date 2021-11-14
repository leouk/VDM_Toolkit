/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.modules;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import java.io.File;
import java.util.Arrays;

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

	public TRModule(TCIdentifierToken name, TRDefinitionList definitions, FileList files)
	{
		super(name.getLocation());
		this.name = name;
		this.definitions = definitions;
		this.files = files;

		if (files == null || files.isEmpty())
			warning(IsaWarningMessage.VDMSL_EMPTY_MODULE_FILES_1P, name.toString());
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
		report(IsaErrorMessage.ISA_INVALID_INVTR_2P, getClass().getName(), name.toString());
        return "";
    }

	public static FileList asFileList(File... args)
	{
		FileList result = new FileList();
		result.addAll(Arrays.asList(args));
		return result;
	}
}
