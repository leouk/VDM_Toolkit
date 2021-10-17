package vdm2isa.lex;

import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.TRType;

import com.fujitsu.vdmj.ast.lex.LexToken;
import com.fujitsu.vdmj.lex.LexLocation;

public final class IsaTemplates {
    
    private final static String MODULE       = "(* VDM to Isabelle Translated\n   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk\n%1s\n%2s\n*)\ntheory %2s\nimports VDMToolkit\nbegin\n\n%3s\nend";
    //@todo add "@IsaModifier" annotation for the translation process, e.g. @IsaModifier("intro!") --> [intro!]
    private final static String ABBREVIATION = "abbreviation\n\t%1s :: \"%2s\"\nwhere\n\t\"%1s \\<equiv> %3s\"\n";     
    private final static String DEFINITION   = "definition\n\t%1s :: \"%2s \\<Rightarrow> %3s\"\nwhere\n\t\"%1s %4s \\<equiv> %5s\"\n";
    private final static String TSYNONYM     = "type_synonym %1s = \"%2s\"";

    //@todo could I have a Formatter.format(DEFINITION, pass some info + pass %xs for what I don't have?)
    //public final String TSYNONYM_INV = "definition\n\tinv_%1s :: \"%2s\"\nwhere\n\t\"%1s x \\<equiv> inv_%2s x \\<and> %3s\"\n";

    public final static String DATATYPE     = "datatype %1s = %2s";

    public static String translateValueDefinition(String name, String type, String exp)
    {
        assert name != null && type != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(ABBREVIATION, name, type, exp));
        sb.append("\n");
        //@todo make this tokenised as well? 
        sb.append(String.format(DEFINITION, "inv_" + name, type, IsaToken.BOOL, "", "inv_" + type + " " + name));
        sb.append("\n");
        return sb.toString();
    }

    /**
     * Creates a type synonum definition, including its type invariant definition, for VDM Type "NAME = EXPR inv x == INV"
     * @param name type name
     * @param exp type expression 
     * @param inv explicit type invariant expression
     * @return Isabelle YXML string
     */
    public static String typeSynonymDefinition(String name, String exp, String inv)
    {
        assert name != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(TSYNONYM, name, exp));
        sb.append("\n");
        // Take into account inner type invariant (recursively?); possibly will introduce errors for some exps
        inv = "inv_ " + exp + "\\<and> " + ((inv == null) ? "True" : inv);
        sb.append(String.format(DEFINITION, "inv_" + name, exp, IsaToken.BOOL, "x", inv));
        return sb.toString();
    }

    public static String explicitFunctionDefnition(String name, String inTypeSig, String outTypeSig, 
        String inParam, String exp, String pre, String post)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(DEFINITION,  "pre_" + name, inTypeSig, IsaToken.BOOL, inParam, pre));
        sb.append("\n");
        sb.append(String.format(DEFINITION, "post_" + name, inTypeSig + IsaToken.FUN + outTypeSig, IsaToken.BOOL, inParam + " RESULT", post));
        sb.append("\n");
        sb.append(String.format(DEFINITION,           name, inTypeSig,    outTypeSig, inParam, exp));
        return sb.toString();
    }

    public static String translateModule(String comment, String loc, String name, String defs) 
    {
        assert comment != null && loc != null && name != null && defs != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(MODULE, comment, loc, name, defs));
		return sb.toString();
    }

    public static String tokenise(IsaToken token, LexLocation location, Object... args)
    {
        StringBuilder sb = new StringBuilder();
        boolean parenthesise = false;
        int parenCnt = 0;
        for(Object i : args)
        {
            if (i instanceof IsaToken)
            {
                if (IsaToken.parenthesise((IsaToken)i)) 
                { 
                    parenCnt++;
                    sb.append("(");
                }
                sb.append(String.valueOf(i));
            }
            else if (i instanceof TRType)
            {
                sb.append(((TRType)i).translate());
            }
            else if (i instanceof TRExpression)
            {
                sb.append(((TRExpression)i).translate());
            }
            else if (i instanceof TRDefinition)
            {
                sb.append(((TRDefinition)i).translate());
            }
            else if (i instanceof LexToken)
            {
                // deal with it! 
            }
            else
            {
                System.out.println("Ignoring " + i.toString() + " of class" + i.getClass().getName());
            }
        }
        return sb.toString();
    }
}
