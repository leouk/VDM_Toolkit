/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRMapType;
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
		//depending on the root: f(x) is different from list(x). map(x) also requires attention!  
		this.args.setSemanticSeparator(type instanceof TRSeqType ? IsaToken.SEQAPPLY.toString() : IsaToken.APPLY.toString());
		//System.out.println(toString());
	}

	@Override
	public TRType getType()
	{
		return type;
	}

	@Override
    public String toString()
    {
        return super.toString() + " type = " + String.valueOf(type);
    }

	@Override
	public String translate()
	{
		StringBuilder call = new StringBuilder();
		call.append(root.translate());
		call.append(args.getSemanticSeparator());
		call.append(args.translate());
	
		StringBuilder sb = new StringBuilder();
		// for map applications, we need to add "the" for optional removal
		if (type instanceof TRMapType)
		{
			sb.append(IsaToken.OPTIONAL_THE.toString());
			sb.append(IsaToken.parenthesise(call.toString()));
		}
		else
		{
			sb.append(call.toString());
		}
		return IsaToken.parenthesise(sb.toString());
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
