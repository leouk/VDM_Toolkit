package vdm2isa.lex;

//TODO remove all dependencies to vdm2isa.tr TRNode AST.
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

    //TODO have other methods beyond translate or use reflection? We have translate, invTranslate, compTranslate sprinkled around :-(
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

    //@todo pass TCNameToken? Or LexLocation?
    private static void updateTranslatedIsaItem(String name, IsaItem item)
    {
        //@todo accumulate all def names for latter creation of lemmas xyz_def etc...? 
        if (translatedItems.containsKey(name))
            Vdm2isaPlugin.report(10017, "Invalid IsaItem " + item + ": " + name + " has already been defined.", LexLocation.ANY); 
        else
            translatedItems.put(name, item);    
    }

    public static String translateAbbreviation(String name, String typeStr, String exp)
    {
        assert name != null && typeStr != null && exp != null;
        StringBuilder sb = new StringBuilder();
        sb.append(String.format(ABBREVIATION, name, typeStr, exp));
        updateTranslatedIsaItem(name, IsaItem.ABBREVIATION);
        return sb.toString();
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
    
    public static String translateInvariantAbbreviation(String name, String inType, String dummyNames, String invStr)
    {
        assert name != null && inType != null & dummyNames != null && invStr != null;    
        return translateDefinition(IsaToken.INV + name, inType, IsaToken.BOOL.toString(), dummyNames, invStr);
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
                    Vdm2isaPlugin.report(10013, "Invalid TRUnaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args), location);
                else
                {
                    sb.append("(");
                    sb.append(token.toString());
                    sb.append(" ");
                    sb.append(args[0].translate());
                    sb.append(")");
                }
                break;
            case UPLUS: // +x is just x
                if (args.length != 1)
                    Vdm2isaPlugin.report(10013, "Invalid TRUnaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args), location);
                else
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
                    Vdm2isaPlugin.report(10014, "Invalid TRBinaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args), location);
                else
                {
                    sb.append("(");
                    sb.append(args[0].translate());
                    sb.append(" ");
                    sb.append(token.toString());
                    sb.append(" ");
                    sb.append(args[1].translate());
                    sb.append(")");
                }
                break;
            case STARSTAR:
            case STARSTARNAT:
                if (args.length != 2)
                    Vdm2isaPlugin.report(10015, "Invalid power arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args), location);
                else
                {
                    String comment = "result context dependenant on nat or real. Adjust to " + token.toString() + " or just ^";
                    sb.append("(");
                    sb.append(args[0].translate());
                    sb.append(" ");
                    sb.append(token.toString());
                    sb.append(" ");
                    sb.append(args[1].translate());
                    sb.append(")\n");
                    sb.append(IsaToken.COMMENT.toString());
                    sb.append(IsaToken.COMMENT_OPEN.toString());
                    sb.append(comment);
                    sb.append(IsaToken.COMMENT_CLOSE.toString());
                    Vdm2isaPlugin.warning(11001, comment, location);
                }
                break;
            
            default:
                Vdm2isaPlugin.report(10016, "Not yet implemented translation for token " + token.toString() + " " + TRExpressionList.translate(args), location);
        }
        return sb.toString();
    }
}
