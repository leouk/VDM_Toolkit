/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.lex.LexComment;
import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;

public abstract class TRDefinition extends TRNode
{
	private static final long serialVersionUID = 1L;
	protected final LexCommentList comments;
	protected final TCAnnotationList annotations;
	
	protected TRDefinition(LexCommentList comments)
	{
		this(comments, null);
	}
	
	protected TRDefinition(LexCommentList comments, TCAnnotationList annotations)
	{
		this.comments = comments;
		this.annotations = annotations;
	}
	
	public String translate()
	{
		StringBuilder sb = new StringBuilder();

		if (comments.size() > 0) 
		{
			sb.append("(* ");
			for (LexComment c: comments)
			{
				sb.append("@ ");
				sb.append(c.location.toString());
				sb.append("\n\n");
				sb.append(c.comment);
				sb.append("\n\n");
			}
			sb.append("*)");
			sb.append("\n");
		}
		return sb.toString();
	}

	public IsaToken isaToken()
	{
		return null;
	}
}
