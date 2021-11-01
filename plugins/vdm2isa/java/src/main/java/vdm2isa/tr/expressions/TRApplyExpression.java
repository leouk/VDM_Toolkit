/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRType;

public class TRApplyExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	public final TRType type;
	private final TRExpression root;
	private final TRExpressionList args;
	
	public TRApplyExpression(TRType type, TRExpression root, TRExpressionList args)
	{
		super(root);
		this.type = type;
		this.root = root;
		this.args = args;
		//@todo depending on the root:  map(x) is different from list(x) etc.? 
		this.args.setSemanticSeparator(type instanceof TRSeqType ? IsaToken.SEQAPPLY.toString() : IsaToken.APPLY.toString());
		//System.out.println(toString());
	}

	@Override
    public String toString()
    {
        return super.toString() + " type = " + type.translate();
    }

	@Override
	public String translate()
	{
		return "(" + root.translate() + this.args.getSemanticSeparator() + args.translate() + ")";
	}

	@Override
	public IsaToken isaToken() {
		return IsaToken.APPLY;
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseApplyExpression(this, arg);
	}
}
