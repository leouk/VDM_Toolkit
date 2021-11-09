package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.types.TRType;

/**
 * VDM local definitions are constructed by the type checker for certain kinds of TLDs (e.g. TRValueDefinition, some
 * let-defs, some lambdas, etc.). This is a useful class also to generalise aspects of TRValueDefinition, which are common.
*/
public class TRLocalDefinition extends TRAbstractTypedDefinition {
    
    private static final long serialVersionUID = 1L;

    // For exclusive use of TRDefinitionList test for all being LocalDefinition. OVerkill?
    protected TRLocalDefinition()
    {
        //this(LexLocation.ANY, new TCNameToken(LexLocation.ANY, ASTModule.defaultName(LexLocation.ANY).name, "default"), null);
        this(LexLocation.ANY, null, null,null, null, false, false, null);
    }

    public TRLocalDefinition(LexLocation location, 
        TRIsaVDMCommentList comments, 
        TCAnnotationList annotations, 
        TCNameToken name, 
        NameScope nameScope, 
        boolean used, 
        boolean excluded,
        TRType type)
    {
        super(location, comments, annotations, name, nameScope, used, excluded, type);
        // TRValueDefinition have patterns hence can pass name as null; it will have to change its own locality further
        this.local = name != null;

        //TODO get TCLocalDefinition.valueDefinition?
    }

    @Override
    public IsaToken isaToken()
	{
		return IsaToken.LOCAL;
	}
    
    @Override
    public String translate()
    {
		// translate the "v: T"
		StringBuilder sb = new StringBuilder();

        // add any annotations or comments
		sb.append(translatePreamble());
		sb.append(IsaToken.parenthesise(getDeclaredName() + IsaToken.TYPEOF.toString() + getTypeString()));
		//System.out.println(toString());
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseLocalDefinition(this, arg);
	}
}
