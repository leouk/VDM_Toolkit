/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;

public class TRApplyExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	private final TRExpression root;
	private final TRExpressionList args;
	
	public TRApplyExpression(TRExpression root, TRExpressionList args)
	{
		super(root);
		this.root = root;
		this.args = args;
	}

	@Override
	public String translate()
	{
		return IsaTemplates.tokenise(isaToken(), location, root, args);
	}

	@Override
	public IsaToken isaToken() {
		return IsaToken.APPLY;
	}
}
