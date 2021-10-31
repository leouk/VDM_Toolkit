/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.lex.LexComment;
import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;

import plugins.Vdm2isaPlugin;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;

public abstract class TRDefinition extends TRNode
{
	private static final long serialVersionUID = 1L;
	protected final LexCommentList comments;
	protected final TCAnnotationList annotations;

	/**
	 * Whether or not this definition is part of a local definition of someone else
	 */
	public boolean local;
	
	protected TRDefinition(LexLocation location, LexCommentList comments)
	{
		this(location, comments, null);
	}
	
	protected TRDefinition(LexLocation location, LexCommentList comments, TCAnnotationList annotations)
	{
		super(location); 
		this.comments = comments;
		this.annotations = annotations;
		this.local = false;
	}

	@Override
	public String toString()
	{
		return "{local=" + local + "}" + super.toString();
	}

	protected String translatePreamble()
	{
		StringBuilder sb = new StringBuilder();

		if (Vdm2isaPlugin.printComments && comments != null && comments.size() > 0) 
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
		if (annotations != null && annotations.size() > 0)
		{
			warning(11050, "Not yet processing annotations");
			sb.append("(* NOT YET PROCESSING ANNOTATIONS *)\n");
		}
		return sb.toString();
	}

	@Override
	public String translate()
	{
		return translatePreamble();
	}

	@Override
	public abstract String invTranslate();

	public abstract <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg);
}
