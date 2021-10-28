/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import vdm2isa.tr.TRNode;

import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.lex.LexLocation;

import plugins.Vdm2isaPlugin;

//@nb how to add this? 
//@todo add comments and/or location? 
public abstract class TRExpression extends TRNode
{
	private static final long serialVersionUID = 1L;
	
	public LexCommentList comments;

	public TRExpression(LexLocation location)
	{
		super(location);
	}

	public TRExpression(TRExpression exp)
	{
		this(exp.location);
	}

    /**
     * Expressions do not support invariant translation in general. Some type-bound/local expressions do and can extend this behaviour.
     */
    @Override
    public String invTranslate()
    {
        report(11111, "Expression \"" + toString() + "\" does not support Isabelle invariant translation.");
        return "";
    }
}
