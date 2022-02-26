/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.modules;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCExport;
import com.fujitsu.vdmj.tc.modules.TCExportAll;
import com.fujitsu.vdmj.tc.modules.TCImportFromModule;
import com.fujitsu.vdmj.tc.modules.TCModule;

import java.io.File;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.FileList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.annotations.TRAnnotationList;
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
	public final TRAnnotationList annotations; 
	public final FileList files;
	public final TCModule module;

	private final Set<String> imports; 
	private final Set<TCDefinition> defsToHide;
	private final TRDefinitionList allDefs;

	public TRModule(TCModule m, TRIsaVDMCommentList comments, TRAnnotationList annotations, TCIdentifierToken name, 
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
		this.defsToHide = new HashSet<TCDefinition>();
		this.allDefs = new TRDefinitionList();
	}

	protected boolean moduleMatches(String fileName)
	{
		return name.toString().equals(fileName);
	}

	@Override 
	public void setup()
	{
		super.setup();
		setFormattingSeparator("\n");
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
				found = moduleMatches(fileName);
			}
			if (!found)
			{
				warning(IsaWarningMessage.ISA_INVALID_MODULE_NAME_2P, name.toString(), files.toString());
			}
		}
		// figure out imports first so as to add any imported definition abbreviations at the top. 
		figureOutModuleImports();
		allDefs.addAll(definitions);
		
		// after adding definitions, figure out exports as complement of definitions for adding hide_const 
		figureOutModuleExports();

		TRNode.setup(allDefs);
		//System.out.println(toString());
	}

	/**
	 * VDM module imports are processed by "abbreviating" them in Isabelle, which will be processed through
	 * either TRImportedDefinition or TRRenamedDefinition. For the actual theory imports, figure out the names
	 * of imported modules to add to the Isabelle theory import list.
	 */
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

	// private Set<TCDefinition> figureOutFlatDefinitions(TCDefinitionList defsOfInterest)
	// {
	// 	Set<TCDefinition> result = new HashSet<TCDefinition>();
	// 	for(TCDefinition d : defsOfInterest)
	// 	{
	// 		// value definitions potentially have inner definitions (e.g. [A,B] = [1,2] has two definitions)
	// 		if (d instanceof TCValueDefinition)
	// 		{
	// 			TCValueDefinition vd = (TCValueDefinition)d;
	// 			result.addAll(figureOutFlatDefinitions(vd.getDefinitions()));
	// 		}
	// 		// type definitions need to consider any declared specification (e.g. inv/eq/ord)
	// 		else if (d instanceof TCTypeDefinition)
	// 		{
	// 			TCTypeDefinition td = (TCTypeDefinition)d;
	// 			result.add(td);

	// 			TCDefinitionList tdl = new TCDefinitionList();
	// 			if (td.invdef != null) 
	// 				tdl.add(td.invdef);
	// 			if (td.eqdef != null)
	// 				tdl.add(td.eqdef);
	// 			if (td.orddef != null)
	// 				tdl.add(td.orddef);
	// 			if (!tdl.isEmpty())
	// 				result.addAll(figureOutFlatDefinitions(tdl));
	// 		}
	// 		// function definitions need to consider any declared specification (e.g. pre/post/measure)
	// 		else if (d instanceof TCExplicitFunctionDefinition)
	// 		{
	// 			TCExplicitFunctionDefinition efd = (TCExplicitFunctionDefinition)d;
	// 			result.add(efd);

	// 			TCDefinitionList efdl = new TCDefinitionList();
	// 			if (efd.predef != null)
	// 				efdl.add(efd.predef);
	// 			if (efd.postdef != null)
	// 				efdl.add(efd.postdef);
	// 			//Measures are never translated?
	// 			//if (efd.measureDef != null)
	// 			//	efdl.add(efd.measureDef);
	// 			if (!efdl.isEmpty())
	// 				result.addAll(figureOutFlatDefinitions(efdl));
	// 		}
	// 		else if (d instanceof TCImplicitFunctionDefinition)
	// 		{
	// 			TCImplicitFunctionDefinition ifd = (TCImplicitFunctionDefinition)d;
	// 			result.add(ifd);

	// 			TCDefinitionList ifdl = new TCDefinitionList();
	// 			if (ifd.predef != null)
	// 				ifdl.add(ifd.predef);
	// 			if (ifd.postdef != null)
	// 				ifdl.add(ifd.postdef);
	// 			//if (ifd.measureDef != null)
	// 			//	ifdl.add(ifd.measureDef);
	// 			if (!ifdl.isEmpty())
	// 				result.addAll(figureOutFlatDefinitions(ifdl));
	// 		}
	// 		else if (d instanceof TCExplicitOperationDefinition)
	// 		{
	// 			TCExplicitOperationDefinition eod = (TCExplicitOperationDefinition)d;
	// 			result.add(eod);

	// 			TCDefinitionList eodl = new TCDefinitionList();
	// 			if (eod.predef != null)
	// 				eodl.add(eod.predef);
	// 			if (eod.postdef != null)
	// 				eodl.add(eod.postdef);
	// 			if (!eodl.isEmpty())
	// 				result.addAll(figureOutFlatDefinitions(eodl));
	// 		}
	// 		else if (d instanceof TCImplicitOperationDefinition)
	// 		{
	// 			TCImplicitOperationDefinition eid = (TCImplicitOperationDefinition)d;
	// 			result.add(eid);

	// 			TCDefinitionList eidl = new TCDefinitionList();
	// 			if (eid.predef != null)
	// 				eidl.add(eid.predef);
	// 			if (eid.postdef != null)
	// 				eidl.add(eid.postdef);
	// 			if (!eidl.isEmpty())
	// 				result.addAll(figureOutFlatDefinitions(eidl));
	// 		}
	// 		// renamed, qualified, local definitions are leafs
	// 		else if (d instanceof TCRenamedDefinition || d instanceof TCQualifiedDefinition || d instanceof TCLocalDefinition)
	// 		{
	// 			result.add(d);
	// 		}
	// 		// invalid TLD otherwise 
	// 		else 
	// 		{
	// 			report(IsaErrorMessage.VDMSL_INVALID_TLD_1P, d.toString());
	// 		}
	// 	}
	// 	return result;
	// }

	/**
	 * VDM module exports are processed by "hiding" in Isabelle what is not exported
	 * (i.e. hide all defs in "module.definitions \ module.exports"). 
	 */
	private void figureOutModuleExports()
	{
		//@NB addAll generates NPE because of TCValueDef null names!
		//TCDefinitionSet ds = new TCDefinitionSet();
		//ds.addAll(module.defs);

		// figure out all definitions, including implicit specification etc. 
		//defsToHide.addAll(figureOutFlatDefinitions(module.defs));
		//@NB's suggestion which does what I ended up coding! Duhh...
		defsToHide.clear();
		defsToHide.addAll(module.defs.singleDefinitions());
		if (module.exports != null && module.exports.exports != null)
		{
			for(TCExport e : module.exports.exports)
			{
				// if exporting all, there is nothing to hide
				if (e instanceof TCExportAll)
				{
					defsToHide.clear();
					break;
				}
				// with flattened out definitions set, look up/remove whatever is exported from it. 
				else 
				{
					defsToHide.removeAll(e.getDefinition(module.defs));
				}
				// if exporting a value, the definition "mathing" is between TCLocalDef x TCValueDef, so has to be done manually
				// else if (e instanceof TCExportedValue)
				// {	
				// 	TCDefinitionList dl = e.getDefinition(module.defs);
				// 	defsToHide.removeAll(dl);
				// }
				// // function, operation, type; just lookup the name
				// else 
				// {
				// 	defsToHide.removeAll(e.getDefinition(module.defs));
				// }
			}
		}
	}

	@Override 
	public String toString()
	{
		return  "Module " + name.toString() + 
		 	"\n\t imports = " + (module != null ? module.imports != null ? module.imports.toString() : "" : "") +
		 	"\n\t impdefs = " + (module != null ? module.importdefs != null ? module.importdefs.toString() : "" : "") +
		 	"\n\t exports = " + (module != null ? module.exports != null ? module.exports.toString() : "" : "") +
		 	"\n\t expdefs = " + (module != null ? module.exportdefs != null ? module.exportdefs.toString() : "" : "");
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
			sb.append(IsaToken.innerSyntaxIt(i));//requiresQuotes(i) ? IsaToken.innerSyntaxIt(i) : i);
			sb.append(IsaToken.SPACE.toString());
		}
		return sb.toString();
	}

	public String getExports()
	{
		StringBuilder sb = new StringBuilder();
		if (!defsToHide.isEmpty())
		{
			//setFormattingSeparator("\n");
			sb.append(getFormattingSeparator());
			sb.append(IsaToken.comment(IsaInfoMessage.ISA_PROCESS_VDM_EXPORTS.message, getFormattingSeparator()));
			for(TCDefinition d : defsToHide)
			{
				// synthetic definitions in PO modules don't need to be processed
				if (TRDefinition.isSyntheticDefinition(d)) 
				{
					continue;
				}
				else
				{
					sb.append(d instanceof TCTypeDefinition ? IsaToken.HIDE_TYPE.toString() : IsaToken.HIDE_CONST.toString());
					sb.append(IsaToken.SPACE.toString());
					sb.append(IsaToken.innerSyntaxIt(IsaToken.isabelleName(d.name)));
					sb.append(getFormattingSeparator());
				}
			}
		}
		return sb.toString();
	}

	// private final boolean requiresQuotes(String importName)
	// {
	// 	return importName.indexOf(File.pathSeparator) != -1 || 
	// 			importName.indexOf(File.separator) != -1 || 
	// 			!importName.equals(IsaToken.VDMTOOLKIT.toString()) ||
	// 			!IsaToken.validIsaIdentifier(importName); 
	// }

	@Override
	public String translate()
	{
		String loc = name.getLocation() != null ? name.getLocation().toString() : "";
		if (files != null && !files.isEmpty())
		{ 
			loc += "\nfiles = " + files.toString();
		}
		StringBuilder sb = new StringBuilder();
		sb.append(allDefs.translate());
		sb.append(getExports());
		return IsaTemplates.translateModule("", loc, name.toString(), getImports(), sb.toString());
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
