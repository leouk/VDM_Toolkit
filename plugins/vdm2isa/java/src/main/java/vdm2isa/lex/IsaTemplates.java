package vdm2isa.lex;

import java.time.Instant;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Pattern;

import com.fujitsu.vdmj.lex.LexLocation;

import plugins.GeneralisaPlugin;
import vdm2isa.messages.IsaErrorMessage;

/**
 * Isabelle templates for VDM translation. These are to be independent of VDMJ's TRNode AST (i.e. no imports from vdm2isa.tr). 
 * This is important to ensure the right TRNode contains the right set of considerations, rather than
 * having them checked within templates. This is important so that as Isabelle evolves the templates
 * can evolve accordingly, where any broken dependencies will be at the appropriate site (in context)
 * within the TRNode AST, rather than ad-hoc wihtin IsaTemplates. Also, if/when we migrate to ST, this 
 * will be smoother as well.  
 */
public final class IsaTemplates {
    
    private final static Map<String, Map<String, IsaItem>> translatedItems = new TreeMap<String, Map<String, IsaItem>>();
    //TODO add "@IsaModifier" annotation for the translation process, e.g. @IsaModifier("intro!") --> [intro!]

    //TODO could I have a Formatter.format(DEFINITION, pass some info + pass %xs for what I don't have?)
    //TODO generalise the tabbing/newlining later 
    private final static String MODULE       = "(* VDM to Isabelle Translation @%1$s\n   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk\n%2$s\n%3$s\n*)\ntheory %4$s\nimports %5$s\nbegin\n\n%6$s\nend";
    private final static String ABBREVIATION = "abbreviation\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s \\<equiv> %3$s\"\n";     
    private final static String DEFINITION   = "definition\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s %3$s \\<equiv> %4$s\"\n";
    private final static String TSYNONYM     = "type_synonym %1$s = \"%2$s\"";

    //public final String TSYNONYM_INV = "definition\n\tinv_%1s :: \"%2s\"\nwhere\n\t\"%1s x \\<equiv> inv_%2s x \\<and> %3s\"\n";

    public final static String DATATYPE     = "datatype %1$s = %2$s";

    public static void reset()
    {
        translatedItems.clear();
        IsaToken.dummyCount = 0;
    }

    //@todo pass TCNameToken? Or LexLocation?
    private static void updateTranslatedIsaItem(LexLocation moduleLoc, String name, IsaItem item)
    {
        String moduleName = moduleLoc.module;
        //TODO accumulate all def names for latter creation of lemmas xyz_def etc...? 
        boolean moduleIsKnown = translatedItems.containsKey(moduleName);
        if (moduleIsKnown && translatedItems.get(moduleName).containsKey(name))
            GeneralisaPlugin.report(IsaErrorMessage.ISA_DUPLICATE_DEF_3P, moduleLoc, item, name, moduleName);
        else if (!moduleIsKnown)
        {
            Map<String, IsaItem> mapPerModule = new TreeMap<String, IsaItem>();
            mapPerModule.put(name, item);
            translatedItems.put(moduleName, mapPerModule);
        }
        else
        {
            assert translatedItems.containsKey(moduleName);
            translatedItems.get(moduleName).put(name, item);    
        }
    }

    public static boolean matches(String pattern, String value)
    {
        return Pattern.matches(pattern, value);
    }

    /**
     * Checks the string against white space character class (i.e. \n, \t, \f, \r, ' ', \x0B)
     * @param sep
     * @return
     */
    public static boolean isValidFormatingSeparator(String sep)
    {
        return Pattern.matches("\\s*", sep);
    }

    public static boolean isValidSemanticSeparator(String sep)
    {
        //TODO add here a check against certain IsaToken characters only? 
        return isValidFormatingSeparator(sep) || true;
    }

    /**
     * Checks the given separator at its location to see whether it's valid or not. Formatting separators must be white space,
     * whereas semantic separators must only contain IsaToken or white space
     * @param location
     * @param sep
     * @param kind
     * @return
     */
    public static boolean checkSeparator(LexLocation location, String sep, IsaSeparator kind)
    {
        // assume it's not okay
        boolean result = false;
		if (sep == null)
            // null sep is not okay
			GeneralisaPlugin.report(IsaErrorMessage.ISA_SEP_ERROR_2P, location, "null", kind.toString().toLowerCase());
		else if (!sep.isEmpty()) 
        {
            if (kind == IsaSeparator.FORMATING && !IsaTemplates.isValidFormatingSeparator(sep))
                // non white space formatting sep is not okay
                GeneralisaPlugin.report(IsaErrorMessage.ISA_SEP_ERROR_2P, location, "formatting", "white space");
           else if (kind == IsaSeparator.SEMANTIC && !IsaTemplates.isValidSemanticSeparator(sep))
                // non valid isatoken sep is not okay 
                GeneralisaPlugin.report(IsaErrorMessage.ISA_SEP_ERROR_2P, location, "semantic", "Isabelle tokens or white space");
            else
                // validated sep is okay
                result = true;
        }
        else 
            // empty sep is okay
            result = true;
        return result;
    } 

    public static String translateAbbreviation(LexLocation module, String name, String typeStr, String exp)
    {
        assert name != null && typeStr != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(ABBREVIATION, name, typeStr, exp));
        updateTranslatedIsaItem(module, name, IsaItem.ABBREVIATION);
        return sb.toString();
    }

    //TODO perhaps have multiple inType and inVars params? 
    public static String translateDefinition(LexLocation module, String name, String inType, String outType, String inVars, String exp, boolean local)
    {
        assert name != null && outType != null && inVars != null && exp != null;
        StringBuilder sb = new StringBuilder();
        // null input types leads to just the resulting type as the signature, 
        // e.g. basic type abbreviation invariants or function constants
        String signature = inType != null ? inType + " " + IsaToken.FUN.toString() + " " + outType : outType;
        sb.append(String.format(DEFINITION, name, signature, inVars, exp));
        // do not consider for the mapping of "known" translation local definitions, as they might
        // appear multiple times, due to the type checker having created them and sprinkled around 
        // the TRNode AST for various uses. The actual string will still be returned, so care needs 
        // to be taken here by caller to consider whether to add local definitions to the output or not. 
        if (!local)
            updateTranslatedIsaItem(module, name, IsaItem.DEFINITION);
        return sb.toString();
    }
    
    public static String translateInvariantAbbreviation(LexLocation module, String name, String inType, String dummyNames, String invStr, boolean local)
    {
        return translateInvariantDefinition(module, name, inType, dummyNames, invStr, local);
    }

    public static String translateInvariantTypeSynonym(LexLocation module, String name, String inType, String dummyNames, String inv)
    {
        assert name != null && inType != null && dummyNames != null;// && inv != null;
        // Take into account inner type invariant (recursively?); possibly will introduce errors for some exps
        inv = IsaToken.INV.toString() + name + " " + dummyNames + " " + IsaToken.AND.toString() + " " + ((inv == null) ? IsaToken.TRUE.toString() : inv);
        return translateInvariantDefinition(module, name, inType, dummyNames, inv, false);
    }

    public static String translateInvariantDefinition(LexLocation module, String name, String inType, String inVars, String exp, boolean local)
    {
        assert name != null && inType != null && inVars != null && exp != null;
        return translateDefinition(module, IsaToken.INV.toString() + name, inType, IsaToken.BOOL.toString(), inVars, exp, local);
    }

    //public static String isabelleIdentifier(String vdmIdentifier)
    //{
        //TODO Look at LexTokenReader.startOfName for what would be useful to use.  
    //    return "reserved_" + vdmIdentifier;
    //}

    /**
     * VDM identifiers will not have sup/sub, so these are good substitutes for uniqueness. 
     * @param recordName as in "R" for "R :: x : nat"
     * @param vdmFieldName as in "x" for "R :: x : nat"
     * @return Isabelle field name subscripted with record name as in "x\\<^sub>R".
     */
    public static String isabelleRecordFieldName(String recordName, String vdmFieldName)
    {
        assert recordName != null && vdmFieldName != null && vdmFieldName.length() > 0;
        // if recordName has multiple caracters, get the whole name with SUB! 
        StringBuilder sb = new StringBuilder();
        sb.append(vdmFieldName);

        // If recordname is empty then there will be no change to vdmFieldName
        // split record name by its characters, e.g "MyRec" becomes ["M","y","R","e","c"]
        for (String ch : recordName.split("(?<=.)"))
        {
            // for each inner character string, append subscript to the name
            sb.append(IsaToken.SUBSCRIPT.toString());
            sb.append(ch);
        }

        return sb.toString();
    }

    /**
     * Creates a type synonum definition, including its type invariant definition, for VDM Type "NAME = EXPR inv x == INV"
     * @param module module where this comes from; can be the TRNode location itself. 
     * @param name type name
     * @param exp type expression 
     * @param inv explicit type invariant expression
     * @return Isabelle YXML string
     */
    public static String translateTypeSynonymDefinition(LexLocation module, String name, String exp)
    {
        // TRNamedType will handle this, but the name is useful for IsaItem logging
        assert name != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(TSYNONYM, name, exp));
        updateTranslatedIsaItem(module, name, IsaItem.TYPE_SYNONYM);
        return sb.toString();
    }

    public static String translateDatatypeDefinition(LexLocation module, String name, String exp)
    {
        // TRNamedType will handle this, but the name is useful for IsaItem logging
        assert name != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(DATATYPE, name, exp));
        updateTranslatedIsaItem(module, name, IsaItem.DATATYPE);
        return sb.toString();
    }

    public static String translateModule(String comment, String loc, String name, String imports, String defs) 
    {
        assert comment != null && loc != null && name != null && defs != null;
        StringBuilder sb = new StringBuilder();
        if (imports == null || imports.isEmpty()) imports = IsaToken.VDMTOOLKIT.toString();
        sb.append(String.format(MODULE, Instant.now().toString(), comment, loc, name, imports, defs));
		return sb.toString();
    }

    public static String getPOModuleName(String module) {
        return module + "_PO";
    }

    public static String replicate(String s, long count)
    {
        assert count > 0;
        return String.format("%0" + (count) + "d", 0).replace("0", s);
    }
}
