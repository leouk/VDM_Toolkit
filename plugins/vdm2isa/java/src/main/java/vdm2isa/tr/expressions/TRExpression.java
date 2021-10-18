/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.tr.TRNode;
import vdm2isa.lex.IsaToken;

import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.lex.LexLocation;

//@nb how to add this? 
//@todo add comments and/or location? 
public abstract class TRExpression extends TRNode
{
	private static final long serialVersionUID = 1L;
	
	public final LexLocation location;

	public LexCommentList comments;

	public TRExpression(LexLocation location)
	{
		this.location = location;
	}

	public TRExpression(TRExpression exp)
	{
		this(exp.location);
	}
}
