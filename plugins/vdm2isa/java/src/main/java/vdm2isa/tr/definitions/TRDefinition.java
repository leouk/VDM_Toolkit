/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;

/**
 * Base class for TRNode definitions. In relation to TCDefinition, we use the same
 * comparable mechanisms in order to allow the proper construction of defiintion lists 
 */
public abstract class TRDefinition extends TRNode implements Comparable<TRDefinition>
{
	private static final long serialVersionUID = 1L;
	protected final TRIsaVDMCommentList comments;
	protected final TCAnnotationList annotations;

	// /** The name of the object being defined. */
	public final TCNameToken name;	
	// /** The scope of the definition name. */
	public final NameScope nameScope;

	// /** True if the definition has been used by the rest of the code. */
	public boolean used;
	
	/** True if the definition should be excluded from name lookups */
	public boolean excluded;
		
	/**
	 * Whether or not this definition is part of a local definition of someone else
	 */
	public boolean local;
	
	// protected TRDefinition(LexLocation location, TRIsaVDMCommentList comments)
	// {
	// 	this(location, comments, null);
	// }
	
	protected TRDefinition(LexLocation location, TRIsaVDMCommentList comments, TCAnnotationList annotations,
		TCNameToken name, NameScope nameScope, boolean used, boolean excluded)
	{
		super(location); 
		this.comments = comments == null ? new TRIsaVDMCommentList() : comments;
		this.annotations = annotations;
		this.name = name;
		this.nameScope = nameScope;
		this.used = used;
		this.excluded = excluded;
		this.local = false;
	}

	@Override 
	protected void setup()
	{
		super.setup();
		setFormattingSeparator("\n\t");
	}

	@Override
	public String toString()
	{
		return "\n\t name  = " + String.valueOf(name) + 
			   "\n\t scope = " + String.valueOf(nameScope) +
			   "\n\t used  = " + used +
			   "\n\t excld = " + excluded + 
			   "\n\t local = " + local + 
			   "\n\t " + super.toString();
	}

	@Override
	public int compareTo(TRDefinition o)
	{
		return name == null ? 0 : name.compareTo(o.name); 
	};

	@Override
	public int hashCode()
	{
		return name == null ? super.hashCode() : name.hashCode();		// Used for sets of definitions (see equals).
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
			warning(IsaWarningMessage.PLUGIN_NYI_2P, "annotations", getClass().getSimpleName());
			sb.append(IsaToken.bracketit(IsaToken.BLOCK_COMMENT_OPEN,	
				IsaWarningMessage.PLUGIN_NYI_2P.format("annotations", getClass().getSimpleName()),
				IsaToken.BLOCK_COMMENT_CLOSE));
		}

		if (Vdm2isaPlugin.printLocations)
		{
			sb.append(IsaToken.comment(getLocation().toString(), "\n"));
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
            sb.append(getFormattingSeparator());
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
