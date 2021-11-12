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
