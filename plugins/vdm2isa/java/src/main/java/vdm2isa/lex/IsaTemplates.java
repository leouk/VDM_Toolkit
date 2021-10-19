package vdm2isa.lex;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRExpressionList;
import vdm2isa.tr.types.TRType;

import java.util.List;

import com.fujitsu.vdmj.ast.lex.LexToken;
import com.fujitsu.vdmj.lex.LexLocation;

public final class IsaTemplates {
    
    //@todo add "@IsaModifier" annotation for the translation process, e.g. @IsaModifier("intro!") --> [intro!]

    private final static String MODULE       = "(* VDM to Isabelle Translated\n   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk\n%1$s\n%2$s\n*)\ntheory %3$s\nimports VDMToolkit\nbegin\n\n%4$s\nend";
    private final static String ABBREVIATION = "abbreviation\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s \\<equiv> %3$s\"\n";     
    private final static String ABBREV_INV   = "definition\n\t%1$s :: \"\\<bool>\"\nwhere\n\t\"%1$s \\<equiv> %2$s\"\n";
    private final static String DEFINITION   = "definition\n\t%1$s :: \"%2$s \\<Rightarrow> %3$s\"\nwhere\n\t\"%1$s %4$s \\<equiv> %5$s\"\n";
    private final static String TSYNONYM     = "type_synonym %1$s = \"%2$s\"";

    //@todo could I have a Formatter.format(DEFINITION, pass some info + pass %xs for what I don't have?)
    //public final String TSYNONYM_INV = "definition\n\tinv_%1s :: \"%2s\"\nwhere\n\t\"%1s x \\<equiv> inv_%2s x \\<and> %3s\"\n";

    public final static String DATATYPE     = "datatype %1$s = %2$s";

    public static void main(String args[])
    {
        //System.out.println(translateVDMValueDefinition("x", "VDMNat1", "10"));
        System.out.println(typeSynonymDefinition("T", "VDMNat1", "x", "x > 10"));
        StringBuilder name = new StringBuilder("(true::bool)");
        name.setCharAt(1, Character.toUpperCase(name.charAt(1)));
        StringBuilder name2 = new StringBuilder("(10::nat)");
        name2.setCharAt(1, Character.toUpperCase(name2.charAt(1)));
        System.out.println(name.toString() + " " + name2.toString());
    }

    public static String listToString(List<? extends TRNode> list, String separator)
	{
        return listToString("", list, separator, "");
    }

    public static String listToString(String before, List<? extends TRNode> list, String separator, String after)
	{
		StringBuilder sb = new StringBuilder();
		sb.append(before);

		if (!list.isEmpty())
		{
			sb.append(list.get(0).translate());

			for (int i=1; i<list.size(); i++)
			{
				sb.append(separator);
				sb.append(list.get(i).translate());
			}
		}

		sb.append(after);
		return sb.toString();
	}

    public static String translateAbbreviation(String name, String type, String exp)
    {
        assert name != null && type != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(ABBREVIATION, name, type, exp));
        return sb.toString();
    }
    
    public static String translateInvariantAbbreviation(String name, String type)
    {
        assert name != null && type != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(ABBREV_INV, "inv_" + name, "inv_" + type + " " + name));
        return sb.toString();
    }

    //@todo perhaps have multiple inType and inVars params? 
    public static String translateDefinition(String name, String inType, String outType, String inVars, String exp)
    {
        assert name != null && inType != null && outType != null && inVars != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(DEFINITION, name, inType, outType, inVars, exp));
        return sb.toString();
    }

    public static String translateInvariantDefinition(String name, String inType, String inVars, String exp)
    {
        assert name != null && inType != null && inVars != null && exp != null;
        return translateDefinition("inv_" + name, inType, IsaToken.BOOL.toString(), inVars, exp);
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
        assert name != null && inv != null && inVar != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(TSYNONYM, name, exp));
        sb.append("\n");
        // Take into account inner type invariant (recursively?); possibly will introduce errors for some exps
        inv = "inv_" + exp + " " + inVar + " " + IsaToken.AND + " " + ((inv == null) ? IsaToken.TRUE : inv);
        sb.append(translateInvariantDefinition(name, exp, inVar, inv));
        return sb.toString();
    }

    public static String translateVDMValueDefinition(String name, TRType type, TRExpression exp)
    {
        assert name != null && type != null && exp != null;
        StringBuilder sb = new StringBuilder();
    	
        // there is no "inv_\<bool>" in the translation; add inv_bool for completeness. 
        String typeStr = type.isaToken() == IsaToken.BOOL ? "bool" : type.translate();
        String expStr  = exp.translate();

        sb.append(translateAbbreviation(name, typeStr, expStr));
        sb.append("\n");
        sb.append(translateInvariantAbbreviation(name, typeStr));
        sb.append("\n");
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
            case NOT:
            case ABS: 
            case FLOOR:
            case UMINUS:
            case UPLUS:
            case CARD:
            case DUNION:
            case DINTER:
            case LEN:
            case HEAD:
            case TAIL:
            case INDS:
            case ELEMS:
            case DISTCONC:
            case REVERSE:
            case MERGE:
            case DOM:
            case RNG:
            //case POWER:
                if (args.length != 1)
                    throw new RuntimeException("Invalid TRUnaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args));
                sb.append("(");
                sb.append(token.toString());
                sb.append(" ");
                sb.append(args[0].translate());
                sb.append(")");
                break;
            
            // Binary Operators
            case AND:
            case OR:
            case IMPLIES:
            case EQUIVALENT:
            case EQUALS:
            case NE:
            case LT:
            case LE:
            case GT:
            case GE:
            case PLUS:
            case MINUS:
            case TIMES:
            case DIV:
            case DIVIDE:
            case MOD:
            case REM:
            case STARSTAR:
            case INSET:
            case NOTINSET:
            case UNION:
            case INTER:
            case SETDIFF:
            case SUBSET:
            case PSUBSET:
            case CONCATENATE:
            case PLUSPLUS:
            case DOMRESTO:
            case DOMRESBY:
            case RANGERESTO:
            case RANGERESBY:
            case MUNION:
            case COMP:
                if (args.length != 2)
                    throw new RuntimeException("Invalid TRBinaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args));
                sb.append("(");
                sb.append(args[0].translate());
                sb.append(" ");
                sb.append(token.toString());
                sb.append(" ");
                sb.append(args[1].translate());
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
