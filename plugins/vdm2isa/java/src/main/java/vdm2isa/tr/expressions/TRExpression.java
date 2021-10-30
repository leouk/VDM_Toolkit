/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.lex.LexLocation;

//@nb how to add this? 
//@todo add comments and/or location? 
public abstract class TRExpression extends TRNode
{
	private static final long serialVersionUID = 1L;
	
	public LexCommentList comments;

	public TRExpression(LexLocation location)
	{
		super(location);
	}

	public TRExpression(TRExpression exp)
	{
		this(exp.location);
	}

    /**
     * Expressions do not support invariant translation in general. Some type-bound/local expressions do and can extend this behaviour.
     */
    @Override
    public String invTranslate()
    {
        report(11111, "Expression \"" + toString() + "\" does not support Isabelle invariant translation.");
        return "";
    }

	public abstract <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg);

	public String tokenise(IsaToken token, LexLocation location, TRExpression... args)
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
                    report(10013, "Invalid TRUnaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args));
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
                    report(10013, "Invalid TRUnaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args));
                else
                    sb.append(args[0].translate());
                break;
            
            // Binary Operators
            case AND:
            case OR:
            case IMPLIES:
            case EQUIVALENT:
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
            //TODO equals *must* be reimplemented for record types because of record equality abstraction! 
            //     Might even need a separate class from TRBinaryExpression! 
            case EQUALS:
                if (args.length != 2)
                    report(10014, "Invalid TRBinaryExpression arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args));
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
                    report(10015, "Invalid power arguments for " + token + " length(" + args.length + ") = " + TRExpressionList.translate(args));
                else
                {
                    sb.append("(");
                    sb.append(args[0].translate());
                    sb.append(" ");
                    sb.append(token.toString());
                    sb.append(" ");
                    sb.append(args[1].translate());
                    sb.append(")\n\t");
                    String comment = "result is context dependenant on second argument type being nat or real.";
                    sb.append(IsaToken.comment(comment));
                    warning(11001, comment);
                }
                break;
            
            default:
                report(10016, "Not yet implemented translation for token " + token.toString() + " " + TRExpressionList.translate(args));
        }
        return sb.toString();
    }
}
