package vdm2isa.lex;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRExpressionList;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fujitsu.vdmj.ast.lex.LexToken;
import com.fujitsu.vdmj.lex.LexLocation;

public final class IsaTemplates {
    
    private final static Map<String, IsaItem> translatedItems = new HashMap<String, IsaItem>();
    //@todo add "@IsaModifier" annotation for the translation process, e.g. @IsaModifier("intro!") --> [intro!]

    private final static String MODULE       = "(* VDM to Isabelle Translated\n   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk\n%1$s\n%2$s\n*)\ntheory %3$s\nimports \"VDMToolkit\"\nbegin\n\n%4$s\nend";
    private final static String ABBREVIATION = "abbreviation\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s \\<equiv> %3$s\"\n";     
    //private final static String ABBREV_INV   = "definition\n\t%1$s :: \"\\<bool>\"\nwhere\n\t\"%1$s \\<equiv> %2$s\"\n";
    private final static String DEFINITION   = "definition\n\t%1$s :: \"%2$s\"\nwhere\n\t\"%1$s %3$s \\<equiv> %4$s\"\n";
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

    public static void reset()
    {
        translatedItems.clear();
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

    private static void updateTranslatedIsaItem(String name, IsaItem item)
    {
        //@todo accumulate all def names for latter creation of lemmas xyz_def etc...? 
        if (translatedItems.containsKey(name))
            throw new IllegalArgumentException("Invalid IsaItem " + item + ": " + name + " has already been defined."); 
        translatedItems.put(name, item);    
    }

    public static String translateAbbreviation(String name, TRType type, TRExpression exp)
    {
        assert name != null && type != null && exp != null;
        StringBuilder sb = new StringBuilder();
        String typeStr;
        // For values "v : R = mk_R(...)", the type name is the actual name, rather than the type translation 
        if (type instanceof TRRecordType)
            typeStr = ((TRRecordType)type).getName().toString();
        else
            typeStr = type.translate();
        sb.append(String.format(ABBREVIATION, name, typeStr, exp.translate()));
        updateTranslatedIsaItem(name, IsaItem.ABBREVIATION);
        return sb.toString();
    }
    
    public static String translateInvariantAbbreviation(String name, String varName, TRType type)
    {
        assert name != null && type != null;    
        String inType = null;
        String invStr;
        if (type instanceof TRRecordType)
        {
            invStr = type.invTranslate(null) + varName;
        }
        else
        {
            invStr = type.invTranslate(varName);
            // function typed abbreviations (i.e. lambdas) need different input signature for invariant! 
            if (type instanceof TRFunctionType)
            {
                inType = ((TRFunctionType)type).parameters.translate();
                //varName = ((TRFunctionType)type).dummyVarNames(varName);
                varName = IsaToken.dummyVarNames(((TRFunctionType)type).parameters.size());
            }
        }
        return translateDefinition(IsaToken.INV + name, inType, IsaToken.BOOL.toString(), varName, invStr);
    }

    //@todo perhaps have multiple inType and inVars params? 
    public static String translateDefinition(String name, String inType, String outType, String inVars, String exp)
    {
        assert name != null && outType != null && inVars != null && exp != null;
        StringBuilder sb = new StringBuilder();
        // null input types leads to just the resulting type as the signature, e.g. basic type abbreviation invariants
        String signature = inType != null ? inType + " " + IsaToken.FUN.toString() + " " + outType : outType;
        sb.append(String.format(DEFINITION, name, signature, inVars, exp));
        updateTranslatedIsaItem(name, IsaItem.DEFINITION);
        return sb.toString();
    }

    public static String translateInvariantDefinition(String name, String inType, String inVars, String exp)
    {
        assert name != null && inType != null && inVars != null && exp != null;
        return translateDefinition(IsaToken.INV + name, inType, IsaToken.BOOL.toString(), inVars, exp);
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
        sb.append(translateInvariantDefinition(name, exp, inVar, inv));
        return sb.toString();
    }

    public static String typeRecordDefinition(TRRecordType type)
    {
        return "";
    }

    public static String translateVDMValueDefinition(String name, TRType type, String varName, TRExpression exp)
    {
        assert name != null && type != null && exp != null;
        StringBuilder sb = new StringBuilder(); 
        if (varName == null) varName = name.toLowerCase();
        sb.append(translateAbbreviation(name, type, exp));
        sb.append("\n");
        //System.out.println("VDMValue translation invariant for " + name);
        sb.append(translateInvariantAbbreviation(name, varName, type));
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
            case INVERSE:
            case POWER:
                if (args.length != 1)
                    throw new RuntimeException("Invalid TRUnaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args));
                sb.append("(");
                
                sb.append(token.toString());
                sb.append(" ");
                sb.append(args[0].translate());
                sb.append(")");
                break;
            case UPLUS: // +x is just x
                if (args.length != 1)
                    throw new RuntimeException("Invalid TRUnaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args));
                sb.append(args[0].translate());
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
            case STARSTAR:
            case STARSTARNAT:
                if (args.length != 2)
                    throw new RuntimeException("Invalid power arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args));
                sb.append("(");
                sb.append(args[0].translate());
                sb.append(" ");
                sb.append(token.toString());
                sb.append(" ");
                sb.append(args[1].translate());
                sb.append(")\n");
                sb.append(IsaToken.COMMENT.toString());
                sb.append(IsaToken.COMMENT_OPEN.toString());
                sb.append("result context dependenant on nat or real. Adjust to " + token.toString() + " or just ^");
                sb.append(IsaToken.COMMENT_CLOSE.toString());
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
