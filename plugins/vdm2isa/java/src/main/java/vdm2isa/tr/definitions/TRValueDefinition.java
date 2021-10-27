/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.lex.LexCommentList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.types.TRType;

public class TRValueDefinition extends TRDefinition
{
	private static final long serialVersionUID = 1L;
	private final TRPattern pattern;
	private final TRType type;
	private final TRExpression exp;
	private final TRDefinitionList defs;
	
	public TRValueDefinition(LexCommentList comments, TRPattern pattern, TRType type, TRExpression exp, TRDefinitionList defs)
	{
		super(pattern.location, comments);
		this.pattern = pattern;
		this.type = type;
		this.exp = exp;
		this.defs = defs;
		//System.out.println("Value Def for " + pattern.translate() + " \ndefs =\n " + defs.translate());
	}

	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		sb.append(super.translate());
		sb.append(IsaTemplates.translateVDMValueDefinition(pattern.translate(), type, null, exp));
		return sb.toString();
	}
}
