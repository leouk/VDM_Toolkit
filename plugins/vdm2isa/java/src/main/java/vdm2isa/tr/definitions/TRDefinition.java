/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import java.util.HashMap;
import java.util.Map;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCLocalDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCUnknownType;
import com.fujitsu.vdmj.typechecker.NameScope;

import plugins.Vdm2isaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRUnionContext;

/**
 * Base class for TRNode definitions. In relation to TCDefinition, we use the same
 * comparable mechanisms in order to allow the proper construction of defiintion lists 
 */
public abstract class TRDefinition extends TRNode implements TRUnionContext//, Comparable<TRDefinition>
{
	private static final long serialVersionUID = 1L;
	public final TRIsaVDMCommentList comments;
	public final TRAnnotationList annotations;
	private final TCDefinition vdmDefinition;

	// /** The name of the object being defined. */
	public final TCNameToken name;	
	// /** The scope of the definition name. */
	public final NameScope nameScope;

	// /** True if the definition has been used by the rest of the code. */
	public final boolean used;
	
	/** True if the definition should be excluded from name lookups */
	public final boolean excluded;	
	
	protected TRDefinition(TCDefinition definition, LexLocation location, TRIsaVDMCommentList comments, TRAnnotationList annotations,
		TCNameToken name, NameScope nameScope, boolean used, boolean excluded)
	{
		super(location); 
		// create a default one in case of synthetic creation (with null), to avoid NPE on getVDMDefinition. 
		assert (definition == null && name != null) || definition != null;
		this.vdmDefinition = definition == null ? new TCLocalDefinition(location, name, new TCUnknownType(location), nameScope) : definition;
		this.comments = comments == null ? new TRIsaVDMCommentList() : comments;
		this.annotations = annotations;
		this.name = name;
		this.nameScope = nameScope;
		this.used = used;
		this.excluded = excluded;
	}

	public final TCDefinition getVDMDefinition()
	{
		return vdmDefinition;
	}

	public boolean isLocal()
	{
		return NameScope.LOCAL.equals(nameScope);
	}

	@Override 
	public void setup()
	{
		super.setup();
		setFormattingSeparator("\n\t");
		TRNode.setup(comments);
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

	// avoid the issue associated with value definitions having null name that appeared in TCDefinitionSet as well! Have HashSet instead.  
	// @Override
	// public int compareTo(TRDefinition o)
	// {
	// 	return name == null ? 0 : o == null ? 0 : o.name == null ? -1 : name.compareTo(o.name); 
	// };

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
		StringBuilder sb = new StringBuilder();
		sb.append(Vdm2isaPlugin.printVDMSource ? IsaToken.comment(IsaInfoMessage.VDM_SOURCE_1P.format(getVDMDefinition().toString()), "\n") : "");
		sb.append(Vdm2isaPlugin.printLocations ? 
			(getLocation() != null && !LexLocation.ANY.equals(getLocation()) ? IsaToken.comment(String.valueOf(getLocation()), "\n") : "") : "");
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

	@Override 
	public boolean hasUnionTypes()
	{
		return false;
	}

	@Override
	public String unionTypesTranslate(TRExpression body, TRUnionContext innerContext)
	{
		report(IsaErrorMessage.PLUGIN_NYI_2P, "union types translate", getClass().getSimpleName());
		return "";
	}

	@Override 
	public TRUnionContext getNextUnionContext()
	{
		return null;
	}

	public Map<TRSpecificationKind, TCNameSet> getCallMap()
	{
		return new HashMap<TRSpecificationKind, TCNameSet>();
	}

	/**
	 * Synthetic VDM definitions are created as TCLocalDefinition with unknown type
	 * (i.e. VDM definition input is null). Obviously no type correct VDM spec will
	 * have a TCUnknowType. This occurs for instance when processing PO modules, 
	 * where the definition of the TRProofObligationDefinition has no underlying VDM
	 * definition, for instance. This check is used to avoid wrong hide_const/typ exports 
	 * @param d
	 * @return
	 */
	public static final boolean isSyntheticDefinition(TCDefinition d)
	{
		return d instanceof TCLocalDefinition && ((TCLocalDefinition)d).type instanceof TCUnknownType;
	}
}
