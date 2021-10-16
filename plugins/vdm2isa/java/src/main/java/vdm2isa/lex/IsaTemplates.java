package vdm2isa.lex;

public final class IsaTemplates {
    
    public final static string MODULE       = "(* VDM to Isabelle Translated\n   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk\n%1s\n%2s\n*)\ntheory %2s\nimports VDMToolkit\nbegin\n\n%3s\nend";
    //@todo add "@IsaModifier" annotation for the translation process, e.g. @IsaModifier("intro!") --> [intro!]
    public final static String ABBREVIATION = "abbreviation\n\t%1s :: \"%2s\"\nwhere\n\t\"%1s \\<equiv> %3s\"\n";     
    public final static String DEFINITION   = "definition\n\t%1s :: \"%2s \\<Rightarrow> %3s\"\nwhere\n\t\"%1s %4s \\<equiv> %5s\"\n";
    public final static String TSYNONYM     = "type_synonym %1s = \"%2s\"";

    //@todo could I have a Formatter.format(DEFINITION, pass some info + pass %xs for what I don't have?)
    //public final String TSYNONYM_INV = "definition\n\tinv_%1s :: \"%2s\"\nwhere\n\t\"%1s x \\<equiv> inv_%2s x \\<and> %3s\"\n";

    public final static String DATATYPE     = "datatype %1s = %2s";

    public static String typeSynonymDefinition(String name, String exp, String inv)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(TSYNONYM, name, exp));
        sb.append("\n");
        // Take into account inner type invariant (recursively?); possibly will introduce errors for some exps
        inv = "inv_ " + exp + "\\<and> " + ((inv == null) ? "True" : inv);
        sb.append(String.format(DEFINITION, "inv_" + name, exp, IsaToken.BOOL, "x", inv));
        return sb.toString();
    }

    public static String explicitFunctionDefnition(String name, String inTypeSig, String outTypeSig, String inParam, String exp)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(DEFINITION,  "pre_" + name, inTypeSig, IsaToken.BOOL, inParam, exp));
        sb.append("\n");
        sb.append(String.format(DEFINITION, "post_" + name, inTypeSig + IsaToken.FUN + outTypeSig, IsaToken.BOOL, inParam + " RESULT", exp));
        sb.append("\n");
        sb.append(String.format(DEFINITION,           name, inTypeSig,    outTypeSig, inParam, exp));
        return sb.toString();
    }

    public static String translateModule(String comment, String loc, String name, String defs) 
    {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(MODULE, comment, loc, name, defs));
		return sb.toString();
    }
}
