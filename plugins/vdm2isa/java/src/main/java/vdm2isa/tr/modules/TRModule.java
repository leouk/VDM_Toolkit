/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.modules;

import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCImportFromModule;
import com.fujitsu.vdmj.tc.modules.TCModule;

import java.io.File;
import java.util.Arrays;
import java.util.Set;
import java.util.TreeSet;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.FileList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRRenamedDefinition;

public class TRModule extends TRNode
{
	private static final long serialVersionUID = 1L;
	public final TCIdentifierToken name;
	public final TRDefinitionList definitions;
	public final TRDefinitionList importdefs;
	public final TRDefinitionList exportdefs;
	public final TRIsaVDMCommentList comments;
	public final TCAnnotationList annotations; 
	public final FileList files;
	public final TCModule module;

	private final Set<String> imports; 
	private final TRDefinitionList allDefs;

	public TRModule(TCModule m, TRIsaVDMCommentList comments, TCAnnotationList annotations, TCIdentifierToken name, 
		TRDefinitionList importdefs, TRDefinitionList exportdefs, TRDefinitionList definitions, FileList files)
	{
		super(name != null ? name.getLocation() : LexLocation.ANY);
		this.module = m;
		this.comments = comments != null ? comments : new TRIsaVDMCommentList();
		this.annotations = annotations; 
		this.name = name == null ? TCModule.defaultName(location) : name;
		this.importdefs = importdefs;
		this.exportdefs = exportdefs;
		this.definitions = definitions;
		this.files = files;

		this.imports = new TreeSet<String>();
		this.allDefs = new TRDefinitionList();
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
				warning(IsaWarningMessage.ISA_INVALID_MODULE_NAME_2P, name.toString(), files.toString());
			}
		}
		figureOutModuleImports();
		allDefs.addAll(definitions);
		TRNode.setup(allDefs);
		//System.out.println(toString());
	}

	private void figureOutModuleImports()
	{
		this.imports.add(IsaToken.VDMTOOLKIT.toString());
		if (module.imports != null && module.imports.imports != null)
		{
			for(TCImportFromModule i : module.imports.imports)
			{
				this.imports.add(i.name.toString());
			}
		}
		if (importdefs != null)
		{
			// make sure imports are processed first
			assert allDefs.isEmpty();
			for(TRDefinition d : importdefs)
			{
				if (d instanceof TRRenamedDefinition)
				{
					allDefs.add(d);
				}
			}
		}
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
	 * If multiple imports list must take into account Isabelle importing syntax 
	 * (i.e. innerSyntax It if relative path; just space separated string otherwise);
	 * @return
	 */
	public String getImports()
	{
		assert imports.contains(IsaToken.VDMTOOLKIT.toString());
		StringBuilder sb = new StringBuilder();
		for(String i : imports)
		{
			sb.append(requiresQuotes(i) ? IsaToken.bracketit(IsaToken.ISAQUOTE, i, IsaToken.ISAQUOTE) : i);
			sb.append(IsaToken.SPACE.toString());
		}
		return sb.toString();
	}

	private final boolean requiresQuotes(String importName)
	{
		return importName.indexOf(File.pathSeparator) != -1 || 
				importName.indexOf(File.separator) != -1 || 
				!importName.equals(IsaToken.VDMTOOLKIT.toString()) ||
				!IsaToken.validIsaIdentifier(importName); 
	}

	@Override
	public String translate()
	{
		String loc = name.getLocation() != null ? name.getLocation().toString() : "";
		if (files != null && !files.isEmpty())
		{ 
			loc += "\nfiles = " + files.toString();
		}
		return IsaTemplates.translateModule("", loc, name.toString(), getImports(), allDefs.translate());
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
