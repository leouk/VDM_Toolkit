package vdm2isa.lex;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import com.fujitsu.vdmj.lex.LexLocation;

import plugins.Vdm2isaPlugin;

/**
 * Isabelle templates for VDM translation. These are to be independent of VDMJ's TRNode AST (i.e. no imports from vdm2isa.tr). 
 * This is important to ensure the right TRNode contains the right set of considerations, rather than
 * having them checked within templates. This is important so that as Isabelle evolves the templates
 * can evolve accordingly, where any broken dependencies will be at the appropriate site (in context)
 * within the TRNode AST, rather than ad-hoc wihtin IsaTemplates. Also, if/when we migrate to ST, this 
 * will be smoother as well.  
 */
public final class IsaTemplates {
    
    private final static Map<String, IsaItem> translatedItems = new HashMap<String, IsaItem>();
    //TODO add "@IsaModifier" annotation for the translation process, e.g. @IsaModifier("intro!") --> [intro!]

    //TODO could I have a Formatter.format(DEFINITION, pass some info + pass %xs for what I don't have?)
    //TODO generalise the tabbing/newlining later 
    private final static String MODULE       = "(* VDM to Isabelle Translated\n   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk\n%1$s\n%2$s\n*)\ntheory %3$s\nimports \"VDMToolkit\"\nbegin\n\n%4$s\nend";
    private final static String ABBREVIATION = "abbreviation\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s \\<equiv> %3$s\"\n";     
    private final static String DEFINITION   = "definition\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s %3$s \\<equiv> %4$s\"\n";
    private final static String TSYNONYM     = "type_synonym %1$s = \"%2$s\"";

    //public final String TSYNONYM_INV = "definition\n\tinv_%1s :: \"%2s\"\nwhere\n\t\"%1s x \\<equiv> inv_%2s x \\<and> %3s\"\n";

    public final static String DATATYPE     = "datatype %1$s = %2$s";

    public static void reset()
    {
        translatedItems.clear();
    }

    //@todo pass TCNameToken? Or LexLocation?
    private static void updateTranslatedIsaItem(String name, IsaItem item)
    {
        //@todo accumulate all def names for latter creation of lemmas xyz_def etc...? 
        if (translatedItems.containsKey(name))
            Vdm2isaPlugin.report(10017, "Invalid IsaItem " + item + ": " + name + " has already been defined.", LexLocation.ANY); 
        else
            translatedItems.put(name, item);    
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
			Vdm2isaPlugin.report(11111, "Cannot translate with a null " + kind.toString().toLowerCase() + " separator", location);
		else if (!sep.isEmpty()) 
        {
            if (kind == IsaSeparator.FORMATING && !IsaTemplates.isValidFormatingSeparator(sep))
                // non white space formatting sep is not okay
			    Vdm2isaPlugin.report(11111, "Invalid formatting separator: only white space characters are allowed", location);
            else if (kind == IsaSeparator.SEMANTIC && !IsaTemplates.isValidSemanticSeparator(sep))
                // non valid isatoken sep is not okay 
                Vdm2isaPlugin.report(11111, "Invalid semantic separator: only Isabelle tokens or white space characters are allowed", location);
            else
                // validated sep is okay
                result = true;
        }
        else 
            // empty sep is okay
            result = true;
        return result;
    } 

    public static String translateAbbreviation(String name, String typeStr, String exp)
    {
        assert name != null && typeStr != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(ABBREVIATION, name, typeStr, exp));
        updateTranslatedIsaItem(name, IsaItem.ABBREVIATION);
        return sb.toString();
    }

    //TODO perhaps have multiple inType and inVars params? 
    public static String translateDefinition(String name, String inType, String outType, String inVars, String exp, boolean local)
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
            updateTranslatedIsaItem(name, IsaItem.DEFINITION);
        return sb.toString();
    }
    
    public static String translateInvariantAbbreviation(String name, String inType, String dummyNames, String invStr, boolean local)
    {
        assert name != null && inType != null & dummyNames != null && invStr != null;    
        return translateDefinition(IsaToken.INV + name, inType, IsaToken.BOOL.toString(), dummyNames, invStr, local);
    }

    public static String translateInvariantDefinition(String name, String inType, String inVars, String exp, boolean local)
    {
        assert name != null && inType != null && inVars != null && exp != null;
        return translateDefinition(IsaToken.INV + name, inType, IsaToken.BOOL.toString(), inVars, exp, local);
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
     * @param name type name
     * @param exp type expression 
     * @param inv explicit type invariant expression
     * @return Isabelle YXML string
     */
    public static String typeSynonymDefinition(String name, String exp, String inVar, String inv)
    {
        //@todo pass TRNamedType ? 
        assert name != null && inv != null && inVar != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(TSYNONYM, name, exp));
        updateTranslatedIsaItem(name, IsaItem.TYPE_SYNONYM);
        sb.append("\n");
        // Take into account inner type invariant (recursively?); possibly will introduce errors for some exps
        inv = "inv_" + exp + " " + inVar + " " + IsaToken.AND + " " + ((inv == null) ? IsaToken.TRUE : inv);
        sb.append(translateInvariantDefinition(name, exp, inVar, inv, false));
        return sb.toString();
    }

    public static String translateModule(String comment, String loc, String name, String defs) 
    {
        assert comment != null && loc != null && name != null && defs != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(MODULE, comment, loc, name, defs));
		return sb.toString();
    }
}
