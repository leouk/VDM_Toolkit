/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;

import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;

public abstract class TRDefinition extends TRNode
{
	private static final long serialVersionUID = 1L;
	protected final TRIsaVDMCommentList comments;
	protected final TCAnnotationList annotations;

	/**
	 * Whether or not this definition is part of a local definition of someone else
	 */
	public boolean local;
	
	protected TRDefinition(LexLocation location, TRIsaVDMCommentList comments)
	{
		this(location, comments, null);
	}
	
	protected TRDefinition(LexLocation location, TRIsaVDMCommentList comments, TCAnnotationList annotations)
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

		if (comments != null)
		{
			sb.append(comments.translate());
		}

		if (annotations != null && annotations.size() > 0)
		{
			warning(11050, "Not yet processing annotations");
			sb.append("(* NOT YET PROCESSING ANNOTATIONS *)\n");
		}

		// issue TLD comment, if any
		// if (!tldIsaComment().isEmpty())
		// {
		// 	sb.append(getFormattingSeparator());
		// 	sb.append(tldIsaComment());
		// 	sb.append(getFormattingSeparator());
		// }
		return sb.toString();
	}

    public String tldIsaCommentTranslate(TRExpression exp)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(super.tldIsaComment());
        if (exp.requiresImplicitTypeInvariantChecks())
        {
            sb.append(exp.tldIsaComment());
            sb.append(exp.getFormattingSeparator());
        }   
        return sb.toString();
    }

	@Override
	public String translate()
	{
		return translatePreamble();
	}

	public abstract <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg);
}
