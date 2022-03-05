package vdm2isa.lex;

import java.time.Instant;
import java.util.Collections;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.regex.Pattern;

import com.fujitsu.vdmj.lex.LexLocation;

import plugins.GeneralisaPlugin;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;

/**
 * Isabelle templates for VDM translation. These are to be independent of VDMJ's TRNode AST (i.e. no imports from vdm2isa.tr). 
 * This is important to ensure the right TRNode contains the right set of considerations, rather than
 * having them checked within templates. This is important so that as Isabelle evolves the templates
 * can evolve accordingly, where any broken dependencies will be at the appropriate site (in context)
 * within the TRNode AST, rather than ad-hoc wihtin IsaTemplates. Also, if/when we migrate to ST, this 
 * will be smoother as well.  
 */
public final class IsaTemplates {
    
    private static final SortedMap<String, SortedMap<String, IsaItem>> translatedItems = new TreeMap<String, SortedMap<String, IsaItem>>();
    //TODO add "@IsaModifier" annotation for the translation process, e.g. @IsaModifier("intro!") --> [intro!]

    //TODO could I have a Formatter.format(DEFINITION, pass some info + pass %xs for what I don't have?)
    //TODO generalise the tabbing/newlining later 
    private static final String MODULE       = "(* VDM to Isabelle Translation @%1$s\n   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk\n%2$s\n%3$s\n*)\ntheory %4$s\nimports %5$s\nbegin\n\n%6$s\nend";
    private static final String ABBREVIATION = "abbreviation\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s \\<equiv> %3$s\"\n";     
    private static final String DEFINITION   = "definition\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s %3$s \\<equiv> %4$s\"\n";
    private static final String FUNCTION     = "fun\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s %3$s = %4$s\"\n";
    private static final String TSYNONYM     = "type_synonym %1$s = \"%2$s\"";
    private static final String LEMMAS       = "lemmas %1$s = %2$s\n";
    private static final String LEMMA        = "lemma %1$s: \\<open>%2$s\\<close> \n\t %3$s";
    private static final String POGLOCALE    = "locale %1$s = \n\tassumes\n\t\t%2$s\nbegin\n\t%3$s\nend";
    private static final String POGSCRIPT    = "interpretation %1$s \n\t %2$s";
    //public final String TSYNONYM_INV = "definition\n\tinv_%1s :: \"%2s\"\nwhere\n\t\"%1s x \\<equiv> inv_%2s x \\<and> %3s\"\n";

    public final static String DATATYPE     = "datatype %1$s = %2$s";

    // Has to be here and not in IsaToken, because cannot be in Enum initialiser + constructor
    protected static final Set<String> ALL_ISA_TOKENS = new TreeSet<String>();

    public static final Map<String, Map<String, IsaItem>> getTranslatedItemsMap()
    {
        return Collections.unmodifiableMap(translatedItems);
    } 

    public static final SortedSet<String> getIsaItemsIn(LexLocation moduleLoc, IsaItem item)
    {
        SortedSet<String> result = new TreeSet<String>();
        if (translatedItems.containsKey(moduleLoc.module))
        {
            Map<String, IsaItem> mitems = translatedItems.get(moduleLoc.module);
            for(Map.Entry<String, IsaItem> e : mitems.entrySet())
            {
                if (e.getValue().equals(item))
                {
                    result.add(e.getKey());
                }
            }
        }
        return result;
    } 

    public static final void reset()
    {
        translatedItems.clear();
        IsaToken.dummyCount = 0;
        //IsaTemplates.INVALID_ISA_ISATOKEN_IDENTIFIERS.clear();
    }

    //@todo pass TCNameToken? Or LexLocation?
    private static void updateTranslatedIsaItem(LexLocation moduleLoc, String name, IsaItem item)
    {
        assert moduleLoc != null && moduleLoc.module != null && !moduleLoc.module.isEmpty();
        String moduleName = moduleLoc.module;
        //TODO accumulate all def names for latter creation of lemmas xyz_def etc...? 
        boolean moduleIsKnown = translatedItems.containsKey(moduleName);
        if (moduleIsKnown && translatedItems.get(moduleName).containsKey(name))
            GeneralisaPlugin.report(IsaErrorMessage.ISA_DUPLICATE_DEF_3P, moduleLoc, item, name, moduleName);
        else if (!moduleIsKnown)
        {
            SortedMap<String, IsaItem> mapPerModule = new TreeMap<String, IsaItem>();
            mapPerModule.put(name, item);
            translatedItems.put(moduleName, mapPerModule);
        }
        else
        {
            assert translatedItems.containsKey(moduleName);
            translatedItems.get(moduleName).put(name, item);    
        }
    }

    public static final boolean matches(String pattern, String value)
    {
        return Pattern.matches(pattern, value);
    }

    /**
     * Checks the string against white space character class (i.e. \n, \t, \f, \r, ' ', \x0B)
     * @param sep
     * @return
     */
    public static final boolean isValidFormatingSeparator(String sep)
    {
        return Pattern.matches("\\s*", sep);
    }

    public static final boolean isValidSemanticSeparator(String sep)
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
    public static final boolean checkSeparator(LexLocation location, String sep, IsaSeparator kind)
    {
        assert location != null;
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

    public static final String translateAbbreviation(LexLocation module, String name, String typeStr, String exp)
    {
        assert module != null && name != null && typeStr != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(ABBREVIATION, name, typeStr, exp));
        updateTranslatedIsaItem(module, name, IsaItem.ABBREVIATION);
        return sb.toString();
    }

    public static final String translateTheoremDefinition(LexLocation module, String name, String exp)
    {
        assert module != null && name != null && exp != null; 
        return translateDefinition(IsaItem.THEOREM, module, name, null, IsaToken.BOOL.toString(), "", exp, false);
    }

    public static final String translateLemmaDefinition(LexLocation module, String name, String attribute, String exp, String script)
    {
        assert module != null && (name == null || !name.isEmpty()) && exp != null && !exp.isEmpty();
        if (name == null)
        {
            name = "";
        }
        if (attribute != null && !attribute.isEmpty())
        {
            name += "[" + attribute + "]";
        }
        if (script == null || script.isEmpty())
        {
            script = IsaToken.ISAR_OOPS.toString();
        }
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(LEMMA, name, exp, script));
        updateTranslatedIsaItem(module, name, IsaItem.LEMMA);
        return sb.toString();
    }

    private static final String translatePO(LexLocation module, int poNo, String po)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(module.module);
        sb.append(IsaToken.UNDERSCORE.toString());
        sb.append(IsaToken.PO.toString());
        sb.append(poNo);
        sb.append(IsaToken.COLON.toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(po);
        return sb.toString();
    }

    public static final String pogLocaleName(LexLocation module)
    {
        assert module != null;
        return  module.module + IsaToken.UNDERSCORE.toString() + IsaToken.POG.toString();
    }

    public static final String translatePOGLocaleInterpretationDefaultScript()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("\t");
        sb.append(IsaToken.ISAR_APPLY.toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.ISAR_UNFOLD_LOCALES.toString());
        sb.append("\n\t");
        sb.append(IsaToken.ISAR_BY.toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.ISAR_SIMP_ALL.toString());
        return sb.toString();
    }

    //TODO script has to be per lemma?!
    public static final String translatePOGLocaleInterpreation(LexLocation module, boolean createPOGLocaleInterpretationLemmas, String interpretation, String interpretationScript)
    {
        assert module != null ;//&& script != null;
        if (interpretationScript == null || interpretationScript.isEmpty())
        {
            interpretationScript = createPOGLocaleInterpretationLemmas ? 
                translatePOGLocaleInterpretationDefaultScript() : IsaToken.ISAR_OOPS.toString();
        }
        StringBuilder sb = new StringBuilder();
        String pogLocaleName = IsaTemplates.pogLocaleName(module);
        if (createPOGLocaleInterpretationLemmas)
        {
            SortedSet<String> pos = IsaTemplates.getIsaItemsIn(module, IsaItem.THEOREM);
            int poNo = 1;
            for(String po : pos)
            {
                sb.append("\n");
                sb.append(translateLemmaDefinition(module, 
                    pogLocaleName + IsaToken.UNDERSCORE.toString() + "l" + poNo, 
                    IsaToken.ISAR_SIMP.toString(), po, "sorry"));
                poNo++;
                sb.append("\n");
            }
        }
        String pogInterpreationName = 
            (interpretation != null && !interpretation.isEmpty() ? 
                interpretation + IsaToken.COLON.toString() : "") + pogLocaleName;  
        sb.append("\n");
        sb.append(String.format(POGSCRIPT, pogInterpreationName, interpretationScript));
        return sb.toString(); 
    }

    public static final String translatePOGLocale(LexLocation module)
    {
        assert module != null;
        String pogLocComment = IsaToken.comment(IsaInfoMessage.PO_POGLOC_USER.format(module.module));
        SortedSet<String> pos = IsaTemplates.getIsaItemsIn(module, IsaItem.THEOREM);
        StringBuilder pogLocAssumptions = new StringBuilder();     
        if (!pos.isEmpty())
        {
            int poNo = 1;
            Iterator<String> posit = pos.iterator();
            String po = posit.next();
            pogLocAssumptions.append("\t ");
            pogLocAssumptions.append(translatePO(module, poNo, po));
            while (posit.hasNext())
            {
                pogLocAssumptions.append("\n\t and ");
                poNo++;
                po = posit.next();
                pogLocAssumptions.append(translatePO(module, poNo, po));
            }
        }
        return String.format(POGLOCALE, pogLocaleName(module), pogLocAssumptions.toString(), pogLocComment);
    }

    //TODO perhaps have multiple inType and inVars params? 
    public static final String translateDefinition(IsaItem item, LexLocation module, String name, String inType, String outType, String inVars, String exp, boolean local)
    {
        assert module != null && name != null && outType != null && inVars != null && exp != null;
        StringBuilder sb = new StringBuilder();
        // null input types leads to just the resulting type as the signature, 
        // e.g. basic type abbreviation invariants or function constants
        String signature = inType != null ? inType + IsaToken.SPACE.toString() + IsaToken.FUN.toString() + IsaToken.SPACE.toString() + outType : outType;
        // theorems are definitions too 
        sb.append(String.format(item.equals(IsaItem.FUNCTION) ? FUNCTION : DEFINITION, name, signature, inVars, exp));
        // do not consider for the mapping of "known" translation local definitions, as they might
        // appear multiple times, due to the type checker having created them and sprinkled around 
        // the TRNode AST for various uses. The actual string will still be returned, so care needs 
        // to be taken here by caller to consider whether to add local definitions to the output or not. 
        if (!local)
            updateTranslatedIsaItem(module, name, item);
        return sb.toString();
    }
    
    public static final String translateInvariantAbbreviation(LexLocation moduleLocation, String name, String inType, String dummyNames, String invStr, boolean local)
    {
        return translateInvariantDefinition(moduleLocation, name, inType, dummyNames, invStr, local);
    }

    public static final String translateInvariantTypeSynonym(LexLocation module, String name, String inType, String dummyNames, String inv)
    {
        assert module != null && name != null && inType != null && dummyNames != null;// && inv != null;
        // Take into account inner type invariant (recursively?); possibly will introduce errors for some exps
        inv = IsaToken.INV.toString() + name + " " + dummyNames + " " + IsaToken.AND.toString() + " " + ((inv == null) ? IsaToken.TRUE.toString() : inv);
        return translateInvariantDefinition(module, name, inType, dummyNames, inv, false);
    }

    public static final String translateInvariantDefinition(LexLocation module, String name, String inType, String inVars, String exp, boolean local)
    {
        assert module != null && name != null && /*inType != null && */ inVars != null && exp != null;
        return translateDefinition(IsaItem.DEFINITION, module, IsaToken.INV.toString() + name, inType, IsaToken.BOOL.toString(), inVars, exp, local);
    }

    //public static final String isabelleIdentifier(String vdmIdentifier)
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
    public static final String isabelleRecordFieldName(String recordName, String vdmFieldName)
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
    public static final String translateTypeSynonymDefinition(LexLocation module, String name, String exp)
    {
        // TRNamedType will handle this, but the name is useful for IsaItem logging
        assert module != null && name != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(TSYNONYM, name, exp));
        updateTranslatedIsaItem(module, name, IsaItem.TYPE_SYNONYM);
        return sb.toString();
    }

    public static final String translateDatatypeDefinition(LexLocation module, String name, String exp)
    {
        // TRNamedType will handle this, but the name is useful for IsaItem logging
        assert module != null && name != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(DATATYPE, name, exp));
        updateTranslatedIsaItem(module, name, IsaItem.DATATYPE);
        return sb.toString();
    }

    public static final String translateLemmasDefinition(LexLocation location, String name, String lemmasDefs) 
    {
        assert location != null && name != null && lemmasDefs != null && !name.isEmpty() && !lemmasDefs.isEmpty();
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(LEMMAS, name + IsaToken.ISAR_LEMMAS_DEFS, lemmasDefs));
        return sb.toString();
    }

    public static final String translateModule(String comment, String loc, String name, String imports, String defs) 
    {
        assert comment != null && loc != null && name != null && defs != null;
        StringBuilder sb = new StringBuilder();
        if (imports == null || imports.isEmpty()) imports = IsaToken.VDMTOOLKIT.toString();
        sb.append(String.format(MODULE, Instant.now().toString(), comment, loc, name, imports, defs));
		return sb.toString();
    }

    public static final String getPOModuleName(String module) {
        return module + IsaToken.UNDERSCORE.toString() + IsaToken.PO.toString();
    }

    public static final String replicate(String s, long count)
    {
        assert count > 0;
        return String.format("%0" + (count) + "d", 0).replace("0", s);
    }
}
