/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.tc.patterns.TCPattern;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.TRType;

public class TRValueDefinition extends TRDefinition
{
	private static final long serialVersionUID = 1L;
	private final String pattern;
	private final TRType type;
	private final TRExpression exp;
	
	public TRValueDefinition(LexCommentList comments, TCPattern pattern, TRType type, TRExpression exp)
	{
		super(comments);
		this.pattern = pattern.toString();
		this.type = type;
		this.exp = exp;
	}

	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		sb.append(super.translate());
		sb.append(IsaTemplates.translateVDMValueDefinition(pattern, type, exp));
		return sb.toString();
	}
}
