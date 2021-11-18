/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCLocalDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCUnknownType;
import com.fujitsu.vdmj.typechecker.NameScope;

import plugins.Vdm2isaPlugin;
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
	private final TCDefinition vdmDefinition;

	// /** The name of the object being defined. */
	public final TCNameToken name;	
	// /** The scope of the definition name. */
	public final NameScope nameScope;

	// /** True if the definition has been used by the rest of the code. */
	public final boolean used;
	
	/** True if the definition should be excluded from name lookups */
	public final boolean excluded;	
	
	protected TRDefinition(TCDefinition definition, LexLocation location, TRIsaVDMCommentList comments, TCAnnotationList annotations,
		TCNameToken name, NameScope nameScope, boolean used, boolean excluded)
	{
		super(location); 
		// create a default one in case of synthetic creation (with null), to avoid NPE on getVDMDefinition. 
		this.vdmDefinition = definition == null ? new TCLocalDefinition(location, name, new TCUnknownType(location), nameScope) : definition;
		this.comments = comments == null ? new TRIsaVDMCommentList() : comments;
		this.annotations = annotations;
		this.name = name;
		this.nameScope = nameScope;
		this.used = used;
		this.excluded = excluded;
		//this.local = false;
	}

	public final TCDefinition getVDMDefinition()
	{
		return vdmDefinition;
	}

	public boolean isLocal()
	{
		return NameScope.LOCAL.equals(nameScope);
	}

	// public boolean setLocal(boolean l)
	// {
	// 	boolean result = local;
	// 	local = l;
	// 	return result;
	// }

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
			   "\n\t local = " + isLocal() + 
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

		sb.append(tldLocationTranslate());

		// issue TLD comment, if any
		// if (!tldIsaComment().isEmpty())
		// {
		// 	sb.append(getFormattingSeparator());
		// 	sb.append(tldIsaComment());
		// 	sb.append(getFormattingSeparator());
		// }
		return sb.toString();
	}

	/**
	 * Add TLD location as an isabelle comment, if enabled and not null or not just ANY location. 
	 * @return
	 */
	public String tldLocationTranslate()
	{
		return Vdm2isaPlugin.printLocations ? 
			(getLocation() != null && !LexLocation.ANY.equals(getLocation()) ? IsaToken.comment(String.valueOf(getLocation()), "\n") : "") : "";
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
