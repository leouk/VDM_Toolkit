package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRNamedType extends TRInvariantType
{
	private static final long serialVersionUID = 1L;
    public  final TCNameToken typename;
    public final TRType type;
    
    public TRNamedType(TCNameToken typename, TRDefinitionList definitions, TRType type, TRExplicitFunctionDefinition invdef, TRExplicitFunctionDefinition eqdef, TRExplicitFunctionDefinition orddef)
    {
        super(typename.getLocation(), definitions, invdef, eqdef, orddef);
        this.typename = typename;
        this.type = type;
    }

    @Override
    protected void setup()
    {
        super.setup();
        setSemanticSeparator(" ");
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

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(getName());
        sb.append(getSemanticSeparator());
        sb.append(IsaToken.EQUALS.toString());
        sb.append(getSemanticSeparator());
        if (type instanceof TRNamedType)
        {
            TRNamedType tnt = (TRNamedType)type;
            // for VDM named type synonyms (e.g. T = nat; T2 = T;)
            sb.append(IsaToken.bracketit(IsaToken.ISAQUOTE, tnt.getName(), IsaToken.ISAQUOTE));
        }
        else
        {
            // for new types (e.g. T = nat, T = set of X, etc.)
            sb.append(IsaToken.bracketit(IsaToken.ISAQUOTE, type.translate(), IsaToken.ISAQUOTE));
        }
        return sb.toString();
    }

    @Override
	public String invTranslate(String varName) {
        //TODO not all type.getName() will directly work! Needs to take into account structure types etc. Okay for now. 
        return IsaToken.parenthesise(
            IsaToken.INV.toString() + type.getName() +
            (varName != null ? getSemanticSeparator() + varName : ""));
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseNamedType(this, arg);
	}
}
