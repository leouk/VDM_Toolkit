package vdm2isa.tr.types;

import java.util.Set;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCTokenType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRTokenType extends TRBasicType {

    private TRType innerTokenType; 
    private TRTypeSet argtypes;

    public TRTokenType(TCTokenType vdmType, TRDefinitionList definitions, TRTypeSet argtypes) {
        super(vdmType, definitions, IsaToken.TOKEN_TYPE);
        this.innerTokenType = null;
        this.argtypes = argtypes;
    }

    @Override 
    public void setup()
    {
        super.setup();
        TRNode.setup(innerTokenType, argtypes);
    }

    public TRTypeSet getArgTypes()
    {
        return argtypes;
    }

    /**
     * Once known (e.g. v: token = mk_token(...)), set the inner token type
     * @param t
     */
    public void setInnerTokenType(TRType t)
    {
        if (innerTokenType == null || innerTokenType instanceof TRUnknownType)
        {
            innerTokenType = t;
            TRNode.setup(innerTokenType);                
        }
    }

    protected void figureOutInnerTokenType()
    {
        // if the token types collapse to a singleton, we are game; otherwise, it's a token delcaration, hence take as generic type
        setInnerTokenType(argtypes.colapses());
        if (innerTokenType == null)
        {
            //innerTokenType = TRUnknownType.newUnkownType(location);
            innerTokenType = TRSeqType.newSeqType(location, TRBasicType.charType(location), false);
        }    
    }

	@Override
	public TRType copy(boolean atTLD)
	{
		TRTokenType result = new TRTokenType((TCTokenType)getVDMType(), definitions, argtypes.copy(true));
		TRNode.setup(result);
        result.setInnerTokenType(innerTokenType);
		result.setAtTopLevelDefinition(atTLD);
		return result;
	}

    @Override
    protected String getInvTypeString()
    {
        return IsaToken.INV.toString() + isaToken().toString() + IsaToken.DASH.toString();
    }

    @Override
    public Set<String> getDefLemmas()
    {
        Set<String> result = super.getDefLemmas();
        // this is already called by super?
        result.add(getInvTypeString());// + IsaToken.ISAR_LEMMAS_DEFS.toString());
        if (innerTokenType != null)
        {
            result.addAll(innerTokenType.getDefLemmas());
        }
        return result;
    }

    @Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
        sb.append(getInvTypeString());
        figureOutInnerTokenType();
        if (innerTokenType != null)
        {
            sb.append(IsaToken.SPACE.toString());
            sb.append(innerTokenType.invTranslate(null));
        }
        else 
        {
             // if not set, there will be a ISabelle type error for missing type parameter! 
             report(IsaErrorMessage.PLUGIN_INVALID_INNER_TOKEN_TYPE);
        }
        sb.append(varName != null ? IsaToken.SPACE.toString() + varName : "");
        return IsaToken.parenthesise(sb.toString()); 
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        figureOutInnerTokenType();
        if (innerTokenType != null)
        {
            sb.append(innerTokenType.translate());
            sb.append(IsaToken.SPACE.toString());    
        }
        else
        {
            // if not set, there will be a ISabelle type error for missing type parameter! 
            report(IsaErrorMessage.PLUGIN_INVALID_INNER_TOKEN_TYPE);
        }
        sb.append(super.translate());
        return sb.toString();
    }

    @Override
    public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg) {
        return visitor.caseTokenType(this, arg);
    }

    public static final TRType newTokenType(LexLocation location, TRTypeSet argtypes)  
	{
		TRTokenType result = new TRTokenType(new TCTokenType(location), new TRDefinitionList(), argtypes);
		TRNode.setup(result);
		return result;
	}
}
