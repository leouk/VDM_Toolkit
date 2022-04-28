package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCLocalDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRUnionContext;
import vdm2isa.tr.types.TRDataType;
import vdm2isa.tr.types.TRType;

/**
 * VDM local definitions are constructed by the type checker for certain kinds of TLDs (e.g. TRValueDefinition, some
 * let-defs, some lambdas, etc.). This is a useful class also to generalise aspects of TRValueDefinition, which are common.
*/
public class TRLocalDefinition extends TRAbstractTypedDefinition {
    
    private static final long serialVersionUID = 1L;

    public static final TRLocalDefinition DEFAULT = new TRLocalDefinition();
    
    //For exclusive use of TRDefinitionList test for all being LocalDefinition. OVerkill?
    private TRLocalDefinition()
    {
        this(null, LexLocation.ANY, null, null, IsaToken.newNameToken("local_def_default"), null, false, false, null);
    }

    protected TRLocalDefinition(
        TCDefinition definition, 
        LexLocation location, 
        TRIsaVDMCommentList comments, 
        TRAnnotationList annotations, 
        TCNameToken name, 
        NameScope nameScope, 
        boolean used, 
        boolean excluded,
        TRType type)
    {
        super(definition, location, comments, annotations, name, nameScope, used, excluded, type);
    }

    // name might be null in some cases. See TRLocalDefinition and TRValueDefinition
    public TRLocalDefinition(TCLocalDefinition definition,
        LexLocation location, 
        TRIsaVDMCommentList comments, 
        TRAnnotationList annotations, 
        TCNameToken name, 
        NameScope nameScope, 
        boolean used, 
        boolean excluded,
        TRType type)
    {
        // TRValueDefinition have patterns hence can pass name as null; it will have to change its own locality further
        this((TCDefinition)definition, location, comments, annotations, name, nameScope, used, excluded, type);
    }

    @Override
    public IsaToken isaToken()
	{
		return IsaToken.LOCAL;
	}

    @Override
	public String tldLocationTranslate()
    {
        // don't add local definitions locations!
        return isLocal() ? "" : super.tldLocationTranslate(); 
    }

    /**
     * Create internal translate to allow jumps within the hierarchy
     * @return
     */
    protected String translateNamedType()
    {
		// translate the "v: T"
		StringBuilder sb = new StringBuilder();

        // add any annotations or comments
		sb.append(translatePreamble());
		sb.append(IsaToken.parenthesise(getDeclaredName() + IsaToken.TYPEOF.toString() + getTypeString()));
        return sb.toString();
    }
    
    @Override
    public String translate()
    {
        return translateNamedType();
    }

	@Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseLocalDefinition(this, arg);
	}

    /**
     * If the local definition (ultimate) type (i.e. chase renamed types) is a union, then needs union context
     */
    @Override 
	public boolean hasUnionTypes()
	{
        return this.type.ultimateType() instanceof TRDataType;
	}

    /**
     * Strategy for union types context is to use the inner param definition lists within explicit function definitions,
     * which ultimately leads to here.  
     */
	@Override
	public String unionTypesTranslate(TRExpression body, TRUnionContext innerContext)
	{
		StringBuilder sb = new StringBuilder();
        if (hasUnionTypes())
        {
            TRDataType dtype = (TRDataType)type.ultimateType();
            if (dtype.isEnumerated())
            {
                sb.append(body.translate());
            }
            else
            {
                String isaName = IsaToken.isabelleName(this.name);
                sb.append(IsaToken.CASE.toString());
                sb.append(IsaToken.SPACE.toString());
                sb.append(isaName);
                sb.append(IsaToken.SPACE.toString());
                sb.append(IsaToken.OF.toString());
                sb.append(getFormattingSeparator());
                sb.append(dtype.getDataTypeConstructors().unionTypesTranslate(isaName, body, innerContext));
            }
            return IsaToken.parenthesise(sb.toString());
        }
        else 
        {
            sb.append(body.translate());
        }
        return sb.toString();
	}

    public static final TRLocalDefinition newLocalDefinition(
        LexLocation location, 
        TCNameToken name, 
        TRType type)
    {
        return TRLocalDefinition.newLocalDefinition(location, null, null, name, NameScope.LOCAL, true, false, type);  
    }

    public static final TRLocalDefinition newLocalDefinition(
        LexLocation location, 
        TRIsaVDMCommentList comments, 
        TRAnnotationList annotations, 
        TCNameToken name, 
        NameScope nameScope, 
        boolean used, 
        boolean excluded,
        TRType type)
    {
        return TRLocalDefinition.newLocalDefinition(
            new TCLocalDefinition(location, name, type.getVDMType(), nameScope), 
            location, comments, annotations, name, nameScope, used, excluded, type);
    }

    public static final TRLocalDefinition newLocalDefinition(TCLocalDefinition definition,
        LexLocation location, 
        TRIsaVDMCommentList comments, 
        TRAnnotationList annotations, 
        TCNameToken name, 
        NameScope nameScope, 
        boolean used, 
        boolean excluded,
        TRType type)
    {
        TRLocalDefinition result = new TRLocalDefinition(definition, location, comments, annotations, name, nameScope, used, excluded, type);
        TRNode.setup(result);
        return result;
    }
}
