/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRUnknownType;

public class TRBinaryExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	protected final TRExpression left;
	protected final TRExpression right;
	protected final LexToken op;
	
	public TRBinaryExpression(TRExpression left, LexToken op, TRExpression right)
	{
		super(op.location);
		this.left = left;
		//@todo equals expression has to be specialised because of record and other equality tests ? 
		this.op = op;
		this.right = right;
		if (!VALID_BINARY_OPS.contains(isaToken()))
			report(IsaErrorMessage.VDMSL_INVALID_EXPROP_1P, isaToken().toString());
		if (isaToken().equals(IsaToken.STARSTAR) || isaToken().equals(IsaToken.STARSTARNAT))
			// add because of comment on potential problem? 
			setFormattingSeparator("\n\t");
	}

	/**
	 * Choose the type according to the operator
	 */
	@Override
	public TRType getType()
	{
		TRType result;
		switch (isaToken())
		{
			case AND:
            case OR:
            case IMPLIES:
            case EQUIVALENT:
            case INSET:
            case NOTINSET:
            case SUBSET:
            case PSUBSET:
            case LT:
            case LE:
            case GT:
            case GE:
				result = TRBasicType.boolType(location);
				break;
			
			case NE:
			case EQUALS:
				result = left.getType();
				if (result instanceof TRUnknownType)
					result = right.getType(); 
				if (result instanceof TRUnknownType)
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), isaToken().toString(), "2", "expects equivalent type");
				break;

            case PLUS:
            case MINUS:
            case TIMES:
            case DIV:
            case DIVIDE:
            case MOD:
            case REM:
			case STARSTAR:
			case STARSTARNAT:				
				result = left.getType();
				if (result instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result instanceof TRBasicType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), isaToken().toString(), "2", "expects basic type");
				break; 
				
			case UNION:
            case INTER:
            case SETDIFF:
				result = left.getType();
				if (result instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result instanceof TRSetType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), isaToken().toString(), "2", "expects set type");

				break;

			case CONCATENATE:
				result = left.getType();
				if (result instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result instanceof TRSeqType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), isaToken().toString(), "2", "expects seq type");
				break;

            case MUNION:
            case PLUSPLUS:
            case COMP:
				result = left.getType();
				if (result instanceof TRUnknownType)
					result = right.getType(); 
				if (!(result instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), isaToken().toString(), "2", "expects map type");
				break;

			case DOMRESTO:  // S <: m , get right  
            case DOMRESBY:
				result = right.getType();
				if (!(result instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), isaToken().toString(), "2", "expects map type");
				break;

            case RANGERESTO: // m :> S, get left
            case RANGERESBY:
				result = left.getType();
				if (!(result instanceof TRMapType))
					report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), isaToken().toString(), "2", "expects map type");
				break;

			default:
				result = super.getType();
				break;
		}
		return result;
	}

    @Override 
    protected void setup()
    {
        super.setup();
		// binary operator are spaced given Isabelle currying
        setSemanticSeparator(" ");
    }

	@Override
	public IsaToken isaToken()
	{
		return IsaToken.from(op);
	}

	@Override
	public String translate()
	{
		return tokenise(isaToken(), location, left, right);
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseBinaryExpression(this, arg);
	}
}
