package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRInvariantType;
import vdm2isa.tr.types.TRType;

/**
 * General class for typed definitions, namely TRLocalDefinition, TRValueDefinition, and TRTypedDefinition. 
 * These named typed definitions have to be translated with the same set of considerations irrespective of 
 * context. TRValueDefinition derives from TRLocalDefinition, where extra top-level considerations 
 * are added for the TLD value. Similarly, TRTypeDefinition needs to take into account similar issues regarding
 * the structure of its declared type. This class normalises the named type handling at the cost of possibly 
 * confusing/complicating the hierarchy slightly.
 */
public abstract class TRAbstractTypedDefinition extends TRDefinition {
    
    private static final long serialVersionUID = 1L;

    // keep public (but final) so that ClassMapping works and object access is not a problem in derived classes. 
    public final TRType type;

    protected TRAbstractTypedDefinition(TCDefinition definition, 
        LexLocation location, 
        TRIsaVDMCommentList comments, 
        TRAnnotationList annotations, 
        TCNameToken name, 
        NameScope nameScope, 
        boolean used, 
        boolean excluded,
        TRType type)
    {
        // name might be null in some cases. See TRLocalDefinition and TRValueDefinition
        super(definition, location, comments, annotations, name, nameScope, used, excluded);
        this.type = type;
    }

    @Override
	public String toString()
	{
		return getClass().getSimpleName() + " for \"" + getDeclaredName() + "\" type = " + String.valueOf(getType());
	}

    @Override
    public void setup()
    {
        super.setup();
        setSemanticSeparator(IsaToken.SPACE.toString());
        TRNode.setup(type);
    }

    protected String getDeclaredName()
    {
        // make sure it doesn't fall on null; but TRValueDefinition ought to override this method to consider its bindings!
        return String.valueOf(name);
    }

    public TRType getType()
	{
		return type;
	}

    protected String getTypeString()
    {
        // type string depends on TRType class
        String typeStr;
        // make sure no union types at TLD
        type.checkForUnionTypes();
        if (type instanceof TRInvariantType)
            // "v : R = mk_R(...)", the type name is the actual name, rather than the type translation 
            typeStr = type.getName();
        else
            // other types, translate it directly
            typeStr = type.translate();
        return typeStr;
    }

    protected String getInvariantString(String varName)
    {
        // invariant type string depends on the TRType class
		String invStr;

        // values and local definitions ought to always used previously defined inv_T instead of its "opened" definition! 
        boolean old = type.setAtTopLevelDefinition(!(this instanceof TRTypeDefinition), true);
        if (type instanceof TRInvariantType)
        {
			// records have to apply to the varName rather than use it as part of the type-inv-translate string
			invStr = type.invTranslate(null) + IsaToken.SPACE.toString() + varName;
        }
        else
        {
            invStr = type.invTranslate(varName);
        }
        type.setAtTopLevelDefinition(old, true);
        //System.out.println("getInvariantString(" + String.valueOf(varName) + ") = " + invStr);
        return invStr;
    }

    protected String dummyVarNames()
    {
        String dummyNames = "";
        if (type instanceof TRFunctionType)
        {   
            // function types require dummy names for invariant string translation
            dummyNames = IsaToken.dummyVarNames(((TRFunctionType)type).parameters.size(), false, type.location);
        }
        return dummyNames;
    }

    @Override
    public String invTranslate()
    {
		// get invariant variable name
		String varName = getDeclaredName();//.toLowerCase();
		String dummyNames = dummyVarNames();
        
        // translate the type invariant definition calss as (inv_T v), possibly with dummy names for lambdas
		return IsaToken.parenthesise(getInvariantString(varName) + (dummyNames.isEmpty() ? "" : getSemanticSeparator() + dummyNames));
    }
}
