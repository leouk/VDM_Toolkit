package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRNamedType extends TRInvariantType
{
	private static final long serialVersionUID = 1L;
    public final TCNameToken typename;
    public final TRType type;

    /**
     * Named types are treated differently, depending on whether they are part of a top-level definition,
     * or part of a chain of renamings (i.e. the inv_T will be different depending on that). 
     */
    private boolean atTLD;
    
    public TRNamedType(TCNameToken typename, TRDefinitionList definitions, TRType type, TRExplicitFunctionDefinition invdef, TRExplicitFunctionDefinition eqdef, TRExplicitFunctionDefinition orddef)
    {
        super(typename.getLocation(), definitions, invdef, eqdef, orddef);
        this.typename = typename;
        this.type = type;
        this.atTLD = true;
    }

    @Override
    protected void setup()
    {
        super.setup();
        setSemanticSeparator(" ");
    }

    public boolean atTopLevelDefinition()
    {
        return atTLD;
    }

    public void setAtTopLevelDefinition(boolean b)
    {
        atTLD = b;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.IDENTIFIER;
    }


    @Override
	public String getName()
	{
		return typename.toString();
	}

    /**
     * Chase the type renaming chain
     * @return
     */
    public TRType ultimateType()
    {
        TRType result = type;
        if (result instanceof TRNamedType)
            result = ((TRNamedType)result).ultimateType();
        return result;
    }

    /**
     * Depending on the context where this is called, you will want just the RHS; so only return the RHS, and use the typename for LHS where needed.
     */
    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        // Hide LHS
        // sb.append(getName());
        // sb.append(getSemanticSeparator());
        // sb.append(IsaToken.EQUALS.toString());
        // sb.append(getSemanticSeparator());
        // if (type instanceof TRNamedType)
        // {
        //     TRNamedType tnt = (TRNamedType)type;
        //     // for VDM named type synonyms (e.g. T = nat; T2 = T;); ISAQUOTE is to be done externally, given context where RHS is used! 
        //     //sb.append(IsaToken.bracketit(IsaToken.ISAQUOTE, tnt.getName(), IsaToken.ISAQUOTE));
        //     sb.append(tnt.getName());
        // }
        // else
        // {
        //     // for new types (e.g. T = nat, T = set of X, etc.)
        //     //sb.append(IsaToken.bracketit(IsaToken.ISAQUOTE, type.translate(), IsaToken.ISAQUOTE));
        //     sb.append(type.translate());
        // }
        sb.append(getName());//type.translate());
        return sb.toString();
    }

    @Override
	public String invTranslate(String varName) {
        //TODO not all type.getName() will directly work! Needs to take into account structure types etc. Okay for now. 
        // renamed records are slightly different: you call the inv_Type of the record itself, which must have been previously defined.  
        TRType utype = type;//ultimateType();//type;
        String nameStr = atTopLevelDefinition() ? utype.getName() : getName();//getName();//utype instanceof TRRecordType ? utype.getName() : getName();
        //STOPPED HERE: might need utype.invTranslate(varName)? and then the change of atTopLevel somewhere! 
        return IsaToken.parenthesise(
            IsaToken.INV.toString() + nameStr +
            (varName != null ? getSemanticSeparator() + varName : ""));
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseNamedType(this, arg);
	}
}
