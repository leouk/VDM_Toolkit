package vdm2isa.lex;

import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRExpressionList;
import vdm2isa.tr.types.TRType;

import com.fujitsu.vdmj.ast.lex.LexToken;
import com.fujitsu.vdmj.lex.LexLocation;

public final class IsaTemplates {
    
    private final static String MODULE       = "(* VDM to Isabelle Translated\n   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk\n%1$s\n%2$s\n*)\ntheory %3$s\nimports VDMToolkit\nbegin\n\n%4$s\nend";
    //@todo add "@IsaModifier" annotation for the translation process, e.g. @IsaModifier("intro!") --> [intro!]
    private final static String ABBREVIATION = "abbreviation\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s \\<equiv> %3$s\"\n";     
    private final static String ABBRV_INV    = "definition\n\t%1$s :: \"\\<bool>\"\nwhere\n\t\"%1$s \\<equiv> %2$s\"\n";
    private final static String DEFINITION   = "definition\n\t%1$s :: \"%2$s \\<Rightarrow> %3$s\"\nwhere\n\t\"%1$s %4$s \\<equiv> %5$s\"\n";
    private final static String TSYNONYM     = "type_synonym %1$s = \"%2$s\"";

    //@todo could I have a Formatter.format(DEFINITION, pass some info + pass %xs for what I don't have?)
    //public final String TSYNONYM_INV = "definition\n\tinv_%1s :: \"%2s\"\nwhere\n\t\"%1s x \\<equiv> inv_%2s x \\<and> %3s\"\n";

    public final static String DATATYPE     = "datatype %1$s = %2$s";

    public static void main(String args[])
    {
        System.out.println(translateValueDefinition("x", "VDMNat1", "10"));
        System.out.println(typeSynonymDefinition("T", "VDMNat1", "x", "x > 10"));

    }
    public static String translateValueDefinition(String name, String type, String exp)
    {
        assert name != null && type != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(ABBREVIATION, name, type, exp));
        sb.append("\n");
        //@todo make this tokenised as well? 
        sb.append(String.format(ABBRV_INV, "inv_" + name, "inv_" + type + " " + name));
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
    public static String typeSynonymDefinition(String name, String exp, String inv_var_name, String inv)
    {
        assert name != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(TSYNONYM, name, exp));
        sb.append("\n");
        // Take into account inner type invariant (recursively?); possibly will introduce errors for some exps
        inv = "inv_" + exp + " " + inv_var_name + " \\<and> " + ((inv == null) ? "True" : inv);
        sb.append(String.format(DEFINITION, "inv_" + name, exp, IsaToken.BOOL, inv_var_name, inv));
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

    public static String tokenise(IsaToken token, LexLocation location, TRExpression... args)
    {
        StringBuilder sb = new StringBuilder();
        switch (token)
        {
            case ABS: 
            case FLOOR:
            case CARD:
            case DUNION:
            case DINTER:
            case LEN:
            case HEAD:
            case TAIL:
            case INDS:
            case DISTCONC:
            case MERGE:
                if (args.length != 1)
                    throw new RuntimeException("Invalid TRUnaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args));
                sb.append("(");
                sb.append(token.toString());
                sb.append(" ");
                sb.append(args[0].translate());
                sb.append(")");
                break;
            default:
                sb.append("NYI = " + token.toString() + " " + TRExpressionList.translate(args));
        }
        return sb.toString();
        /*
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
        */
    }
}
