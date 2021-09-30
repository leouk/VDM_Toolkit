/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.lex.LexComment;
import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;

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
		
		for (LexComment c: comments)
		{
			if (c.block)
			{
				sb.append(c.toString());
			}
			else
			{
				sb.append("//");
				sb.append(c.comment);
			}
			
			sb.append("\n");
		}

		return sb.toString();
	}
}
